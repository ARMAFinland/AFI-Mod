#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR,"ace_vehicles", "afi_engine_delay","UK3CB_Factions_Vehicles_2S6M_Tunguska","UK3CB_Factions_Vehicles_ZSU39","UK3CB_Factions_Vehicles_M60","UK3CB_Factions_Vehicles_Tseries","UK3CB_Factions_Vehicles_Bicycles","UK3CB_Factions_Vehicles_Tractor"};
		author[] = {"Tuntematon"};
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
		skipWhenMissingDependencies = 1;
	};
};
// configs go here
#include "CfgVehicles.hpp"
