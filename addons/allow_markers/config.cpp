#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"swt_markers",MAIN_ADDON_STR};
		author[] = {"Tikka","Tuntematon"};
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
		skipWhenMissingDependencies = 1;
	};
};
// configs go here
#include "CfgEventHandlers.hpp"

// Hide vanilla markers system
class RscMapControl
{
	class LineMarker
	{
		lineWidthThin = 0;
		lineWidthThick = 0;
		lineDistanceMin = 2147483647;
		lineLengthMin = 2147483647;
	};
};
class RscControlsGroup;
class RscDisplayMainMap
{
	class controlsBackground
	{
		class CA_Map: RscMapControl
		{
			idcMarkerColor = -1;
			idcMarkerIcon = -1;
		};
	};
	class controls
	{
		class TopRight: RscControlsGroup
		{
			class controls
			{
				delete MarkerColor;
				delete MarkerIcon;
			};
		};
	};
};

class RscDisplayGetReady: RscDisplayMainMap
{
	class controlsBackground 
	{
		class CA_Map: RscMapControl
		{
			idcMarkerColor = -1;
			idcMarkerIcon = -1;
		};
	};
	class controls
	{
		class TopRight: RscControlsGroup
		{
			class controls
			{
				delete MarkerColor;
				delete MarkerIcon;
			};
		};
	};
};

class RscDisplayClientGetReady: RscDisplayGetReady
{
	class controls
	{
		class TopRight: RscControlsGroup
		{
			class controls
			{
				delete MarkerColor;
				delete MarkerIcon;
			};
		};
	};
};
