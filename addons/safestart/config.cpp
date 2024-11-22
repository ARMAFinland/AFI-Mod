#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {"cba_main","cba_xeh","cba_settings",MAIN_ADDON_STR, "Extended_EventHandlers"};
		author[] = {"Tikka"};
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
	};
};
// configs go here
#include "CfgEventHandlers.hpp"


class cfgNotifications
{
	class Default;
	class SafeStart: Default
	{
		title = "SAFE START";
		description = "%1";
		iconPicture="\A3\UI_F\data\IGUI\Cfg\Actions\settimer_ca.paa";
		duration = 59;
	};
	class MissionStarting: SafeStart
	{
		color[] = {0,1,0,1};
		duration = 5;
	};
};

/*
class Params
{
    class afi_safeStart_duration
    {
            title = "SafeStart Timer";
            values[] = {0,3,5,8,10,12,15};
            texts[] = {"SafeStart Off","3","5","8","10","12","15"};
            default = 5;
            code = "afi_safeStart_timer = %1";
    };
};
*/

