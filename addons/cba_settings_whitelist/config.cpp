#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR,"CBA_settings"};
		author[] = {"Tikka"};
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
		skipWhenMissingDependencies = 1;
	};
};
// configs go here
// enzio, tuntematon, tikka, furean, blahh
cba_settings_whitelist[] = {"76561198002057694", "76561197976768806","76561197990347153", "76561197972154686", "76561197990633198"};