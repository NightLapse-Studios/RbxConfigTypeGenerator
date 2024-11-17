--!strict
--!native

local fs = require("@lune/fs")
local net = require("@lune/net")
local serde = require("@lune/serde")

local ApiTypes = require("ApiTypes")
local Runtime = require("Runtime")

local GET_VERSION_URL = "https://setup.rbxcdn.com/versionQTStudio"
local GET_API_JSON_URL = "https://setup.rbxcdn.com/%s-API-Dump.json"

local BAD_SECURITIES = {
	RobloxScriptSecurity = true,
	CoreScript = true,
	Plugin = true,
}

local function get_rbx_version(): string
	local res = net.request({
		url = GET_VERSION_URL,
		method = "GET"
	})

	return res.body
end

local function get_api(version): ApiTypes.API
	local url = string.format(GET_API_JSON_URL, version)

	local res = net.request({
		url = url,
		method = "GET"
	})

	return serde.decode("json", res.body)
end

local function get_cached_api(version: string): ApiTypes.API
	local api
    local cache_dir_exists = fs.isDir("fetch_cache")
    if not cache_dir_exists then
        error("Fetch cache enabled but no cache directory exists\nPlease navigate to a suitable CWD and create `fetch_cache` directory\n\t(this is not done automatically to avoid over-engineering a standard cache location)")
    end

    local cur_cache_file = `fetch_cache/{version}.json`
    local cache_exists = fs.isFile(cur_cache_file)
    if cache_exists then
        api = serde.decode("json", fs.readFile(cur_cache_file))
    else
        for i,v in fs.readDir("fetch_cache") do
            fs.removeFile("fetch_cache/" .. v)
        end

        api = get_api(version)
        fs.writeFile(cur_cache_file, serde.encode("json", api, true))
    end

	return api
end

local function has_bad_security(m: ApiTypes.Member): boolean
	if m.MemberType == "Property" then
		return BAD_SECURITIES[m.Security.Write]
	else
		return BAD_SECURITIES[m.Security]
	end
end

local function has_tag(m: ApiTypes.Member | ApiTypes.Class, tag: string): boolean
	if m.Tags then
		return table.find(m.Tags, tag) ~= nil
	else
		return false
	end
end

local function member_is_configurable(member: ApiTypes.Member): boolean
	if has_bad_security(member) then
		return false
	end

	if has_tag(member, "NotScriptable") or has_tag(member, "ReadOnly") then
		return false
	elseif Runtime.IgnoreDeprecatedMembers and has_tag(member, "Deprecated") then
		return false
	end

	return true
end

local function class_group_is_creatable(c: ApiTypes.Class): boolean
	local class_lookup, subclass_lookup = Runtime.ClassLookup, Runtime.SubclassLookup
	if has_tag(c, "NotCreatable") then
		local name = c.Name
		if subclass_lookup[name] then

			local has_creatable_subclass
			for i,v in subclass_lookup[name] do
				if has_tag(v, "NotCreatable") then
					has_creatable_subclass = class_group_is_creatable(class_lookup[v.Name])
					if has_creatable_subclass then
						break
					end
				else
					has_creatable_subclass = true
					break
				end
			end

			if not has_creatable_subclass then
				return false
			end
		else
			return false
		end
	end

	return true
end

local function class_group_has_members(c: ApiTypes.Class): boolean
	if #c.Members ~= 0 then
		for i,v in c.Members do
			if member_is_configurable(v) then
				return true
			end
		end
	end

	local subclasses = Runtime.SubclassLookup[c.Name]
	if not subclasses then
		return false
	end

	for i,v in subclasses do
		if class_group_has_members(v) then
			return true
		end
	end

	return false
end

local function cull_classes(api: ApiTypes.API): { ApiTypes.Class }
	local Stripped = { }

	for i,v in api.Classes do
		if has_tag(v, "Service") or has_tag(v, "Settings") then
			continue
		end

		if not class_group_has_members(v) then
			continue
		end

		if not class_group_is_creatable(v) then
			continue
		end

		table.insert(Stripped, v)
	end

	return Stripped
end

return {
	get_rbx_version = get_rbx_version,
	get_api = get_api,
	get_cached_api = get_cached_api,
	has_bad_security = has_bad_security,
	has_tag = has_tag,
	member_is_configurable = member_is_configurable,
	class_group_is_creatable = class_group_is_creatable,
	class_group_has_members = class_group_has_members,
	cull_classes = cull_classes,
}