#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR,"ace_vehicles", "afitweaks_engine_delay","rhs_c_2s1","rhs_c_2s3","rhs_c_bmd","rhs_c_bmp3","rhs_c_bmp","rhs_c_sprut","rhs_c_t14","rhs_c_t15","rhs_c_t72","rhs_c_vehiclesounds","rhs_c_tanks","rhs_c_a2port_armor"};
		author = "Tuntematon";
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
		skipWhenMissingDependencies = 1;
	};
};
// configs go here
#include "CfgVehicles.hpp"
