#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR, "A3_Data_F", "A3_UI_F", "ace_hearing", "CBA_Common"};
		author[] = {"Tikka", "Tuntematon"};
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
	};
};
// configs go here
#include "CfgEventHandlers.hpp"