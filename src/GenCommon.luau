--!strict

local ApiTypes = require("ApiTypes")
local ApiTools = require("ApiTools")

local PRIMITIVE_MAP = {
	bool = "boolean",
	double = "number",
	float = "number",
	int = "number",
	int64 = "number",
	string = "string",
	["string?"] = "string?",
	["null"] = "()"
}
table.freeze(PRIMITIVE_MAP)

local GROUP_MAP = {
	Array = "{ [number]: any }",
	["Array?"] = "{ [number]: any }?",
	Dictionary = "{ [string]: any }",
	["Dictionary?"] = "{ [string]: any }?",
	Variant = "any",
	["Variant?"] = "any?",
	Tuple = "...any",
	Map = "{ [unknown]: unknown }"
}
table.freeze(GROUP_MAP)

local VALUETYPE_CATEGORY_MAP: { [string]: (v: ApiTypes.ValueType) -> string } = {
	Primitive = function(v: ApiTypes.ValueType)
		return PRIMITIVE_MAP[v.Name]
	end,
	Enum = function(v: ApiTypes.ValueType)
		return "Enum." .. v.Name
	end,
	Class = function(v: ApiTypes.ValueType)
		return v.Name
	end,
	DataType = function(v: ApiTypes.ValueType)
		return v.Name
	end,
	Group = function(v: ApiTypes.ValueType)
		return GROUP_MAP[v.Name]
	end
}
table.freeze(VALUETYPE_CATEGORY_MAP)

local function property_valuetype_to_luau_type(value_type: ApiTypes.ValueType): string
	local a = VALUETYPE_CATEGORY_MAP[value_type.Category](value_type)
	if not a then print(value_type) end
	return VALUETYPE_CATEGORY_MAP[value_type.Category](value_type)
end

local function params_to_luau_type(params: ApiTypes.ParamList)
	local out = "("

	for i = 1, #params do
		local p = params[i]
		local t = property_valuetype_to_luau_type(p.Type)

		if i > 1 and i <= #params then
			out ..= ", "
		end

		if p.Type.Name == "Tuple" then
			out ..= "...any"
		else
			out ..= p.Name .. ": " .. t
		end
	end

	out ..= ")"
	return out
end

local function event_to_luau_type(event: ApiTypes.Event): string
	local params = params_to_luau_type(event.Parameters)
	params ..= " -> (),"
	return params
end

local function callback_to_luau_type(callback: ApiTypes.Callback): string
	local params = params_to_luau_type(callback.Parameters)
	local ret = property_valuetype_to_luau_type(callback.ReturnType)

	return params .. " -> (" .. ret .. "),"
end


local function member_rhs(member: ApiTypes.Member): string?
	local rhs = nil
	if member.MemberType == "Property" then
		if ApiTools.member_is_configurable(member) then
			return nil
		end

		rhs = property_valuetype_to_luau_type(member.ValueType) .. ","
	elseif member.MemberType == "Event" then
		rhs = event_to_luau_type(member)
	elseif member.MemberType == "Callback" then
		rhs = callback_to_luau_type(member)
	else
		return nil
	end

	return rhs
end

-- Returns the type of a member with field name and trailing comma
local function member_to_luau_type(member: ApiTypes.Member): string?
	if not ApiTools.member_is_configurable(member) then
		return nil
	end

	local rhs = member_rhs(member)
	if not rhs then
		return nil
	end

	return "\t" .. member.Name .. ": " .. rhs
end

return {
    property_valuetype_to_luau_type = property_valuetype_to_luau_type,
    params_to_luau_type = params_to_luau_type,
    event_to_luau_type = event_to_luau_type,
    callback_to_luau_type = callback_to_luau_type,
    member_rhs = member_rhs,
    member_to_luau_type = member_to_luau_type,
    PRIMITIVE_MAP = PRIMITIVE_MAP,
    GROUP_MAP = GROUP_MAP,
}