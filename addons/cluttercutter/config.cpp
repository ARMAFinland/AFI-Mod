#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR,"ACE_interact_menu"};
		author = "Raimo";
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
	};
};
// configs go here
#include "CfgVehicles.hpp"
