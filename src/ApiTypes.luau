--!strict

--[[
	Adapted from Dekkonot's type file
	https://github.com/Dekkonot/rbx-api-dump
]]

type Array<T> = { [number]: T }

export type ValueType = {
	Category: string,
	Name: string,
}

export type ParamList = Array<{Name: string, Type: ValueType}>

export type SecurityLevel = "None" | "CoreScript" | "Plugin" | "Normal" | "RobloxScriptSecurity"

export type Property = {
	Category: string,
	MemberType: "Property",
	Name: string,
	Security: { Read: SecurityLevel, Write: SecurityLevel },
	Serialization: {
		CanLoad: boolean,
		CanSave: boolean,
	},
	ValueType: ValueType,

	Tags: Array<string>?,
}

export type Function = {
	MemberType: "Function",
	Name: string,
	Parameters: ParamList,
	ReturnType: ValueType,
	Security: SecurityLevel,

	Tags: Array<string>?,
}

export type Event = {
	MemberType: "Event",
	Name: string,
	Parameters: ParamList,
	Security: SecurityLevel,

	Tags: Array<string>?,
}

export type Callback = {
	MemberType: "Callback",
	Name: string,
	Parameters: ParamList,
	ReturnType: ValueType,
	Security: SecurityLevel,

	Tags: Array<string>?,
}

export type Member = Property |
	Function |
	Event |
	Callback

export type Class = {
	Members: Array<Member>,
	MemoryCategory: string,
	Name: string,
	Superclass: string,
	Tags: Array<string>?,
}

export type Enum = {
	Items: Array<{ Name: string, Value: string }>,
	Name: string,
	Tags: Array<string>?,
}

export type API = {
	Classes: Array<Class>,
	Enums: Array<Enum>,
	Version: number,
}

return true
