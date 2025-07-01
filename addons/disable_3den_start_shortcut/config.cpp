#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR,"3den"};
		author[] = {"Tuntematon"};
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
	};
};
// configs go here

class ctrlMenuStrip;
class ctrlShortcutButton;
class Display3den {
	class Controls {
		class MenuStrip: ctrlMenuStrip {
			class Items {
				class MissionPreviewSP {
					shortcuts[]={};
				};
			};
		};
		class ButtonPlay: ctrlShortcutButton {
			shortcuts[]= {"0x00050000 + 0", 57};
		};
	};
};
