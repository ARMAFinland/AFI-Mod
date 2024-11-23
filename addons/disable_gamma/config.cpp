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

// gamma
class RscControlsGroup;
class CA_TextDisplayMode;
class RscText;

class RscDisplayOptionsVideo
{
	class Controls
	{
		class QualityGroup: RscControlsGroup
		{
			class controls
			{
				class CA_SliderGamma: CA_TextDisplayMode
				{
					x = "6 * (((safezoneW / safezoneH) min 1.2) / 40)";
					text = "Disabled";
				};
				class CA_SliderBrightness: CA_TextDisplayMode
				{
					x = "6 * (((safezoneW / safezoneH) min 1.2) / 40)";
					text = "Disabled";
				};
			};
		};
		class RenderingGroup: RscControlsGroup
		{
			class controls
			{				
				class SliderBrightnessPP: CA_TextDisplayMode 
				{
					style = 2;
					type = 0;
					colorBackground[] = {0, 0, 0, 1};
					colorText[] = {1, 1, 1, 1};
					sizeEx = 0.04;
					font = "RobotoCondensed";
					text = "DISABLE @AFI";
				};
				
				class ValueImageAdjustments: SliderBrightnessPP
				{
					text = "DISABLED";
				};
				// class ValueBrightnessPP: RscEdit
				
				class SliderContrast: SliderBrightnessPP
				{
					text = "TO CHANGE";
				};
				// class ValueContrast: RscEdit
				
				class SliderSaturation: SliderBrightnessPP
				{
					text = "POSTPROCESS SETTINGS";
				};
				// class ValueSaturation: RscEdit
			};
		};
	};
};