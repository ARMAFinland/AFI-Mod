#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR,"A3_Ui_F","A3_Data_F_Enoch_Loadorder"};
		author = "Tuntematon";
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
	};
};
// configs go here
//#include "CfgEventHandlers.hpp"

class RscPictureKeepAspect;
class RscStandardDisplay;
class RscControlsGroup;
class RscDisplayStart: RscStandardDisplay
{
	class controls
	{
		class LoadingStart: RscControlsGroup
		{
			class controls
			{
				class Logo: RscPictureKeepAspect
				{
					//onLoad = QUOTE((_this select 0) ctrlsettext PATHTOF(afilogo.paa););
					onLoad = "_this select 0 ctrlsettext '\x\afitweaks\addons\logo\afilogo.paa';";
					
				};
			};
		};
	};
};
class RscDisplayLoadMission: RscStandardDisplay
{
	class controls
	{
		class LoadingStart: RscControlsGroup
		{
			class controls
			{
				class Logo: RscPictureKeepAspect
				{
					//onLoad = QUOTE(_this select 0 ctrlsettext PATHTOF(afilogo.paa););
					onLoad = "_this select 0 ctrlsettext '\x\afitweaks\addons\logo\afilogo.paa';";
				};
			};
		};
	};
};
class RscDisplayNotFreeze: RscStandardDisplay
{
	class controls
	{
		class LoadingStart: RscControlsGroup
		{
			class controls
			{
				class Logo: RscPictureKeepAspect
				{
					//onLoad = QUOTE(_this select 0 ctrlsettext "\x\afitweaks\addons\logo\afilogo.paa";);
					onLoad = "_this select 0 ctrlsettext '\x\afitweaks\addons\logo\afilogo.paa';";
				};
			};
		};
	};
};
class RscActivePictureKeepAspect;
class RscButton;
class RscDisplayMain: RscStandardDisplay
{
	class Controls
	{
		// This would change the arma logo at top
		// class Logo: RscActivePictureKeepAspect
		// {
		// 	tooltip = "Connect to AFI event server";
		// 	text = QPATHTOF(afilogo.paa);
		// 	onButtonClick = "connectToServer ['65.21.188.102', 2202, 'kotka'];";
		// };
		// class LogoApex: Logo
		// {
		// 	tooltip = "Connect to AFI event server";
		// 	text = QPATHTOF(afilogo.paa);
		// 	onButtonClick = "connectToServer ['65.21.188.102', 2202, 'kotka'];";
		// };
		class GVAR(serveriLeftText): RscButton
		{
			text = "Join AFI weekly games server";
			tooltip = "This is afi weekly game server";
			style = QUOTE(2 + 192);
			SizeEx = QUOTE(GUI_TEXT_SIZE_LARGE);
			onButtonClick = "connectToServer ['65.21.188.102', 2302, 'kotka'];";
			x = "0.5 - (1.5 * 	10) * 	(pixelW * pixelGridNoUIScale * 2) - 	(2 * pixelW)";
			y = "0.37 - (	10 / 2) * 	(pixelH * pixelGridNoUIScale * 2)";
			w = "10 * 	(pixelW * pixelGridNoUIScale * 2)";
			h = "1 * 	(pixelH * pixelGridNoUIScale * 2)";
			//color[] = {1,1,1,1};
			colorBackground[] = {0,0,0,1};
			background = 1;
		};
		class GVAR(serveriCenterText): GVAR(serveriLeftText)
		{
			text = "Join AFI main event server";
			tooltip = "This is main afi event server, all our events use this if not told otherwise.";
			onButtonClick = "connectToServer ['65.21.188.102', 2202, 'kotka'];";
			x = "0.5 - (0.5 * 	10) * 	(pixelW * pixelGridNoUIScale * 2)";

		};
		class GVAR(serveriRightText): GVAR(serveriLeftText)
		{
			text = "Join AFI secondary event server";
			tooltip = "Almost never used, just in case as backup here.";
			onButtonClick = "connectToServer ['65.21.188.102', 2502, 'kotka'];";
			x = "0.5 + (0.5 * 	10) * 	(pixelW * pixelGridNoUIScale * 2) + 	(2 * pixelW)";
		};
		class GVAR(serveriLeftImage): RscActivePictureKeepAspect
		{
			text = QPATHTOF(afilogo.paa);
			tooltip = "This is afi weekly game server";
			onButtonClick = "connectToServer ['65.21.188.102', 2302, 'kotka'];";
			x = "0.5 - (1.5 * 	10) * 	(pixelW * pixelGridNoUIScale * 2) - 	(2 * pixelW)";
			y = "0.01 - (	10 / 2) * 	(pixelH * pixelGridNoUIScale * 2)";
			w = "10 * 	(pixelW * pixelGridNoUIScale * 2)";
			h = "7 * 	(pixelH * pixelGridNoUIScale * 2)";
			color[] = {1,1,1,1};
		};

		class GVAR(serveriCenterImage): GVAR(serveriLeftImage)
		{
			text = QPATHTOF(afilogo.paa);
			tooltip = "This is main afi event server, all our events use this if not told otherwise.";
			onButtonClick = "connectToServer ['65.21.188.102', 2202, 'kotka'];";
			x = "0.5 - (0.5 * 	10) * 	(pixelW * pixelGridNoUIScale * 2)";
		};

		class GVAR(serveriRightImage): GVAR(serveriLeftImage)
		{
			text = QPATHTOF(afilogo.paa);
			tooltip = "Almost never used, just in case as backup here.";
			onButtonClick = "connectToServer ['65.21.188.102', 2502, 'kotka'];";
			x = "0.5 + (0.5 * 	10) * 	(pixelW * pixelGridNoUIScale * 2) + 	(2 * pixelW)";
		};
	};
};


//This would add the spotlight thing, it was bit buggy.
// class CfgMainMenuSpotlight
// {
// 	class GVAR(eventServer)
// 	{
// 		text = "AFI Event server";
// 		textIsQuote = 0;
// 		picture = QPATHTOF(afilogo.paa);
// 		video = "";
// 		action = "connectToServer ['65.21.188.102', 2202, 'kotka'];";
// 		actionText = "Connect to Session";
// 		condition = "true";
// 	};
// 	class GVAR(weeklyGameServer)
// 	{
// 		text = "AFI weekly game server";
// 		textIsQuote = 0;
// 		picture = QPATHTOF(afilogo.paa);
// 		video = "";
// 		action = "connectToServer ['65.21.188.102', 2302, 'kotka'];";
// 		actionText = "Connect to Session";
// 		condition = "true";
// 	};
// };