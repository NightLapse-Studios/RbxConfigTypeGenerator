--!strict
--[[
    Common storage for runtime data
]]

local APITypes = require("ApiTypes")

export type RuntimeAPIData = {
    -- Lookup by class name
    ClassLookup: { [string]: APITypes.Class},
    -- Array of classes which with no descendants
    LeafClasses: { [string]: APITypes.Class },
    -- Lookup descendant classes by parent name
    SubclassLookup: { [string]: { APITypes.Class }? },
    -- API with undesired classes or fields removed
    -- By default this has deprecated classes/members removed
    -- as well as non-creatable classes/members
    -- Non-creatables which have creatable descendants will NOT be removed
    StrippedApi: { APITypes.Class },
    RbxVersion: string,

    TypeSuffix: string,
    IgnoreDeprecatedMembers: boolean,
    IgnoreDeprecatedClasses: boolean,
    GenerateTypesFile: boolean,
	-- Does a second pass that outputs a list of types associated
	-- with each particular member string
    DumpAmbiguousMembers: boolean,
	-- Bypass fetching with this file instead
    APIFetchCacheFile: boolean,
}

local runtime_data: RuntimeAPIData = {
    ClassLookup = { },
    LeafClasses = { },
    SubclassLookup = { },
    StrippedApi = { } :: APITypes.API,
    RbxVersion = "",
    TypeSuffix = "Cfg",
	IgnoreDeprecatedMembers = true,
	IgnoreDeprecatedClasses = true,
	GenerateTypesFile = false,
	DumpAmbiguousMembers = false,
	APIFetchCacheFile = true
}

return runtime_data
