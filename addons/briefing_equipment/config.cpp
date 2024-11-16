#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR,"CBA_Events","CBA_XEH"};
		author[] = {"Raimo"};
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
	};
};
// configs go here
#include "CfgEventHandlers.hpp"