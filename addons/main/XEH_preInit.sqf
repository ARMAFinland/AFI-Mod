#include "script_component.hpp"
ADDON = false;

// PREP_RECOMPILE_START;
// #include "XEH_prep.hpp"
// PREP_RECOMPILE_END;

RHS_WP_Managment_Disabled = true;

[
	QGVAR(enableEnvironment),
	"CHECKBOX", 
	["Enable enviroment", "enable/disable ambient life (bees, rabbits, birds, snakes, fish)"],
	["AFI - Main", "Main"],
	false, 
	1, 
	{
		enableEnvironment [_this, true];
	}
] call CBA_fnc_addSetting;

[
	QGVAR(disableRemoteSensors),
	"CHECKBOX", 
	["Disable Remote Sensors", "This should be true on pure TvT missions. Might affect missions with AI"],
	["AFI - Main", "Main"],
	true, 
	1, 
	{
		disableRemoteSensors _this;
	}
] call CBA_fnc_addSetting;


ADDON = true;