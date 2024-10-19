# Roblox Config type generator

Quick and (very) dirty generator for config tables that correspond to the properties/events found in roblox classes, primarily Instances.

The target use case is generating prop table types for declarative UI libraries like Vide and React

Consumes the roblox API dump to be up-to-date

It will output invalid luau if the property name has spaces, but this is never the case for writable properties in creatable classes. So this does not necessarily work for the general case.

Thanks to Dekkonot's [runtime API dump](https://github.com/Dekkonot/rbx-api-dump) module for documentation as well as the base types file for the API dump

# Usage

Run the script with lune and pipe stdout to a file of your choosing