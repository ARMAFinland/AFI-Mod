#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR};
		author[] = {"Tikka"};
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
	};
};
// configs go here
#include "CfgEventHandlers.hpp"

#define GUI_GRID_X	(0)
#define GUI_GRID_Y	(0)
#define GUI_GRID_W	(0.025)
#define GUI_GRID_H	(0.04)
#define GUI_GRID_WAbs	(1)
#define GUI_GRID_HAbs	(1)

class RscDisplayGetReady;
class RscButtonMenuOK;
class RscButtonMenuCancel;
class ShortcutPos;
class RscMessageBox;
class RscControlsGroupNoScrollbars;
class RscBackgroundGUITop;
class RscBackgroundGUI;
class RscStructuredText;

/*
class RscDisplayGetReady: RscDisplayMainMap
class RscDisplayServerGetReady: RscDisplayGetReady
class RscDisplayClientGetReady: RscDisplayGetReady
*/

class RscDisplayClientGetReady: RscDisplayGetReady {
	class controls {
		class ButtonContinueTest: RscButtonMenuOK {
			default = 1;
			idc=100;
			action = "if (serverCommandAvailable ""#logout"") then {(findDisplay 53) createDisplay ""afi_confirm_start"";};";
			
			text = "$STR_DISP_CONTINUE";
			x = "SafezoneX + SafezoneW - (11 * 			(			((safezoneW / safezoneH) min 1.2) / 40))";
			y = "23 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 			(safezoneY + safezoneH - 			(			((safezoneW / safezoneH) min 1.2) / 1.2))";
			w = "10 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			h = "1 * 			(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
			class ShortcutPos: ShortcutPos
			{
				left = "8.9 * 			(			((safezoneW / safezoneH) min 1.2) / 40)";
			};
		};
		class ButtonContinue: RscButtonMenuOK {
			default = 0;
			x = "-1 * GUI_GRID_W + GUI_GRID_X";
			y = "-1 * GUI_GRID_H + GUI_GRID_Y";
			w = "0 * GUI_GRID_W";
			h = "0 * GUI_GRID_H";
			shortcuts[] = {};
		};
	};
};

class afi_confirm_start : RscControlsGroupNoScrollbars {
	idd = 700;
	
	class controls
	{
		class MessageBox: RscMessageBox
		{
			idc = -1;
			x = "10.6 * 					(			((safezoneW / safezoneH) min 1.2) / 40) + 		(safezoneX + (safezoneW - 					((safezoneW / safezoneH) min 1.2))/2)";
			y = "7 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25) + 		(safezoneY + (safezoneH - 					(			((safezoneW / safezoneH) min 1.2) / 1.2))/2)";
			w = "1";
			h = "1";
			
			class Controls
			{
				class BcgCommonTop: RscBackgroundGUITop
				{
					idc = -1;
					x = "0";
					y = "0";
					w = "18.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {"(profilenamespace getvariable ['GUI_BCG_RGB_R',0.77])","(profilenamespace getvariable ['GUI_BCG_RGB_G',0.51])","(profilenamespace getvariable ['GUI_BCG_RGB_B',0.08])",1};
				};
				class BcgCommon: RscBackgroundGUI
				{
					idc = -1;
					x = "0";
					y = "1.1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "18.8 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1.7 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,1};
				};
				class Text: RscStructuredText
				{
					idc = -1;
					x = "0.7 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "1.6 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "17 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					text = "Are you sure you want to start mission?";
				};
				class BackgroundButtonOK: RscBackgroundGUI
				{
					idc = -1;
					x = "0";
					y = "2.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "6.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					colorBackground[] = {0,0,0,1};
				};
				class BackgroundButtonMiddle: BackgroundButtonOK
				{
					idc = -1;
					x = "6.3 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
				};
				class BackgroundButtonCancel: BackgroundButtonOK
				{
					idc = -1;
					x = "12.6 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
				};
				class ButtonOK: RscButtonMenuOK
				{
					default = 0;
					idc = 100;
					colorBackground[] = {0,0,0,1};
					x = "0";
					y = "2.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "6.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					text = "Yes";
					action = "ctrlActivate ((findDisplay 53) displayCtrl 1); (findDisplay 700) closeDisplay 1;";
					shortcuts[] = {};
				};
				class ButtonCancel: RscButtonMenuCancel
				{
					default = 1;
					idc = 101;
					colorBackground[] = {0,0,0,1};
					x = "12.6 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					y = "2.9 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					w = "6.2 * 					(			((safezoneW / safezoneH) min 1.2) / 40)";
					h = "1 * 					(			(			((safezoneW / safezoneH) min 1.2) / 1.2) / 25)";
					text = "No";
					action = "(findDisplay 700) closeDisplay 1;";
					shortcuts[] = {"0x00050000 + 0",28,57,156};
				};
			};
		};
	};
};
