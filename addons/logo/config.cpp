#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR,"A3_Data_F_Enoch_Loadorder"};
		author[] = {"Tuntematon"};
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
	};
};
// configs go here
//#include "CfgEventHandlers.hpp"

#define SERVER_IP	'37.27.232.48'

class RscPictureKeepAspect;
class RscStandardDisplay;
class RscControlsGroup;
class RscDisplayStart: RscStandardDisplay {
	class controls {
		class LoadingStart: RscControlsGroup {
			class controls {
				class Logo: RscPictureKeepAspect {
					onLoad = QUOTE(_this select 0 ctrlsettext QUOTE(QPATHTOF(afilogo.paa)););
				};
			};
		};
	};
};
class RscDisplayLoadMission: RscStandardDisplay {
	class controls{
		class LoadingStart: RscControlsGroup {
			class controls {
				class Logo: RscPictureKeepAspect {
					onLoad = QUOTE(_this select 0 ctrlsettext QUOTE(QPATHTOF(afilogo.paa)););
				};
			};
		};
	};
};
class RscDisplayNotFreeze: RscStandardDisplay {
	class controls {
		class LoadingStart: RscControlsGroup {
			class controls {
				class Logo: RscPictureKeepAspect {
					onLoad = QUOTE(_this select 0 ctrlsettext QUOTE(QPATHTOF(afilogo.paa)););
				};
			};
		};
	};
};
class RscActivePictureKeepAspect;
class RscButton;
class RscDisplayMain: RscStandardDisplay{
	class ControlsBackground {
		class GVAR(serveriLeftImage): RscActivePictureKeepAspect {
			text = QPATHTOF(afilogo.paa);
			x = "0.5 - (1.5 * 10) * (pixelW * pixelGridNoUIScale * 2) - (2 * pixelW)";
			y = "0.01 - (10 / 2) * (pixelH * pixelGridNoUIScale * 2)";
			w = "10 * (pixelW * pixelGridNoUIScale * 2)";
			h = "7 * (pixelH * pixelGridNoUIScale * 2)";
			color[] = {1,1,1,1};
			background = 1;
		};

		class GVAR(serveriCenterImage): GVAR(serveriLeftImage) {
			text = QPATHTOF(afilogo.paa);
			x = "0.5 - (0.5 * 10) * (pixelW * pixelGridNoUIScale * 2)";
		};

		class GVAR(serveriRightImage): GVAR(serveriLeftImage) {
			text = QPATHTOF(afilogo.paa);
			x = "0.5 + (0.5 * 10) * (pixelW * pixelGridNoUIScale * 2) + (2 * pixelW)";
		};
	};
	class Controls {
		class GVAR(serveriLeftText): RscButton {
			text = "Join AFI Coop Ops & Misc Event server";
			tooltip = "This is afi Coop Ops server and misc event server";
			style = QUOTE(2 + 192);
			SizeEx = QUOTE(GUI_TEXT_SIZE_LARGE);
			onButtonClick = QUOTE(connectToServer ARR_3([SERVER_IP,2302,'kotka']););
			x = "0.5 - (1.5 * 10) * (pixelW * pixelGridNoUIScale * 2) - (2 * pixelW)";
			y = "0.37 - (10 / 2) * (pixelH * pixelGridNoUIScale * 2)";
			w = "10 * pixelW * pixelGridNoUIScale * 2)";
			h = "1 * (pixelH * pixelGridNoUIScale * 2)";
			colorBackground[] = {0,0,0,1};
		};
		class GVAR(serveriCenterText): GVAR(serveriLeftText) {
			text = "Join AFI Main Event Server";
			tooltip = "This is main afi event server, all our events use this if not told otherwise.";
			onButtonClick = QUOTE(connectToServer ARR_3([SERVER_IP,2202,'kotka']););
			x = "0.5 - (0.5 * 10) * (pixelW * pixelGridNoUIScale * 2)";

		};
		class GVAR(serveriRightText): GVAR(serveriLeftText) {
			text = "Join AFI Secondary Event Server";
			tooltip = "Used for some events when main event is used for bigger events";
			onButtonClick = QUOTE(connectToServer ARR_3([SERVER_IP,2502,'kotka']););
			x = "0.5 + (0.5 * 10) * (pixelW * pixelGridNoUIScale * 2) + (2 * pixelW)";
		};
	};
};