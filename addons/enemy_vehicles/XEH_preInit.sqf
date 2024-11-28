#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;


[
	QGVAR(allowed),
	"CHECKBOX", 
	["Allow enemy vehicles", "Allow enemy vehicles; this setting does not affect cars or static weapons"],
	["AFI - Main", "Allow enemy vehicles"],
	false, 
	1, 
	{}
] call CBA_fnc_addSetting;

[
	QGVAR(allowCars),
	"CHECKBOX", 
	["Allow enemy cars", "Allow the usage of enemy cars"],
	["AFI - Main", "Allow enemy vehicles"],
	true, 
	1, 
	{}
] call CBA_fnc_addSetting;

ADDON = true; 