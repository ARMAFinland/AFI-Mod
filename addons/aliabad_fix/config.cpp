#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR, "MCN_Aliabad"};
		author[] = {"Tuntematon"};
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
		skipWhenMissingDependencies = 1;
	};
};
// configs go here
#include "CfgWorlds.hpp"
