#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR, "WW2_Assets_c_Weapons_Ammoboxes_c","IFA3_COMP_ACE_mortar","WW2_Assets_c_Vehicles_Tanks_c","WW2_Assets_c_Vehicles_SimpleObjects_c"};
		author[] = {"Tuntematon"};
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
		skipWhenMissingDependencies = 1;
	};
};
// configs go here
#include "CfgVehicles.hpp"
