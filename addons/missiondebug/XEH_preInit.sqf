#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_prep.hpp"
PREP_RECOMPILE_END;

[
	QGVAR(enableMissionDebug),
	"CHECKBOX",
	"Enable mission debug",
	["AFI - Main", "Mission debug"],
	true,
	0,
	{},
	true
] call CBA_fnc_addSetting;

ADDON = true;
