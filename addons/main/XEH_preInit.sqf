#include "script_component.hpp"
ADDON = false;

// PREP_RECOMPILE_START;
// #include "XEH_PREP.hpp"
// PREP_RECOMPILE_END;


[
    QGVAR(enableEnvironment),
    "CHECKBOX", 
    ["Enable enviroment", "enable/disable ambient life (bees, rabbits, birds, snakes, fish)"],
    "Afi - Main",
    false, 
    nil, 
    {
		enableEnvironment [_this, true];
	}
] call CBA_fnc_addSetting;


ADDON = true;