#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;


[
	QGVAR(allowed),
	"CHECKBOX", 
	"Allow enemy radios",
	["Afi - Main", "Allow enemy radios"],
	false, 
	nil, 
	{}
] call CBA_fnc_addSetting;

ADDON = true;