--!strict
--!native

local fs = require("@lune/fs")
local process = require("@lune/process")

local ApiTools = require("ApiTools")
local ApiTypes = require("ApiTypes")
local Runtime = require("Runtime")
local GenPropSets = require("GenPropSets")
local GenInstanceCfgs = require("GenInstanceCfgs")

local function deep_freeze(t: { any })
	for i,v in t do
		if typeof(v) == "table" and not table.isfrozen(v) then
			table.freeze(v)
			deep_freeze(v)
		end
	end
end

local possible_args = {
	gen_instance_cfgs = true,
	gen_propsets = true,
	keep_deprecated_members = true,
	keep_deprecated_classes = true,
	dump_ambiguous_members = true,
	dump_api_fetch = true,
	ignore_cache_api_fetch = true,
	help = true,
	clean = true,
}

local function main(args: { string })
	local args2 = { }
	local has_invalid_args = false
	for i,v in args do
		args2[v] = true
		if not possible_args[v] then
			has_invalid_args = true
			warn("Unknown arg `" .. v .. "`")
		end
	end
	
	if has_invalid_args then
		process.exit(1)
	end

	if args2.help then
		print([[Generate types (or other things) based on roblox API dump
	help				Print this message and ignore other flags
	clean				Remove contents of out folder then exit
				        and skip generators even if used

Generators:
	gen_instance_cfgs	        Generates types that describe what can be
				        passed to Vide's `create` function.
				        Easily adaptable to React, if not already
				        suitable.
	gen_propsets		        Generates a comprehensive PropSet file
				        which implements prop tables with builder
				        pattern

Options:
	keep_deprecated_members		Keep deprecated members in output
					Default: false
	keep_deprecated_classes		Keep deprecated classes in output
					Default: false
	dump_ambiguous_members		Dumps any members which exist in multiple
					classes but with different types
					Default: false
	dump_api_fetch			Dump the API result to dump.json
					Default: false
	ignore_cache_api_fetch		Cache API fetch in CWD/<version>.json for
					the next run of the script. Will not use
					cached file if this option is enabled
					Default: false]])

		return
	end
	
	if not fs.isDir("out/") then
		fs.writeDir("out/")
	end

	if args2.clean then
		for i,v in fs.readDir("out/") do
			local path = "out/" .. v
			if fs.isDir(path) then
				fs.removeDir(path)
			else
				fs.removeFile(path)
			end
		end

		print("Cleaned cwd/out/*")
		process.exit(0)
	end

	-- Setup Runtime
	if args2.keep_deprecated_classes then
		Runtime.IgnoreDeprecatedClasses = false
	end
	if args2.keep_deprecated_members then
		Runtime.IgnoreDeprecatedMembers = false
	end
	if args2.dump_ambiguous_members then
		Runtime.DumpAmbiguousMembers = true
	end
	if args2.ignore_cache_api_fetch then
		Runtime.APIFetchCacheFile = false
	end



	-- Setup API for Runtime
	local api_version = ApiTools.get_rbx_version()
	Runtime.RbxVersion = api_version
	local _api
	if Runtime.APIFetchCacheFile then
		_api = ApiTools.get_cached_api(api_version)
	else
		_api = ApiTools.get_api(api_version)
	end

	local api: ApiTypes.API = _api
	assert(api.Version == 1, "API Version is not 1")

	local class_lookup = { }
	for i,v in api.Classes do
		class_lookup[v.Name] = v
	end

	local subclass_lookup = { }
	for i,v in api.Classes do
		if not v.Superclass then continue end

		local super_name = v.Superclass
		subclass_lookup[super_name] = subclass_lookup[super_name] or { }
		local list = subclass_lookup[super_name]
		assert(list)

		table.insert(list, v)
	end

	Runtime.ClassLookup = class_lookup
	Runtime.SubclassLookup = subclass_lookup
	Runtime.StrippedApi = ApiTools.cull_classes(api)

	for i,v in Runtime.StrippedApi do
		if subclass_lookup[v.Name] == nil then
			Runtime.LeafClasses[v.Name] = v
		end
	end

	deep_freeze(Runtime)



	if args2.gen_instance_cfgs then
		fs.writeFile("out/InstanceCfgs.luau", GenInstanceCfgs())
		print("Wrote Cfg types to InstanceCfgs.luau")
	end

	if args2.gen_propsets then
		fs.writeFile("out/PropSet.luau", GenPropSets())
		print("Wrote PropSet to PropSet.luau")
	end
end

main(process.args)

