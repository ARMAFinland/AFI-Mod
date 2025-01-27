#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_prep.hpp"
PREP_RECOMPILE_END;

[
	QGVAR(disableKnockingOnEnemy),
	"CHECKBOX",
	"Disable knocking on enemy vehicle",
	["AFI - Main", "Knocking"],
	false,
	1,
	{},
	false
] call CBA_fnc_addSetting;

[
	QGVAR(notifyIfEnemy),
	"CHECKBOX",
	["Enable notifying crew that enemy is knocking", "Enabling this notifies crew that it is enemy who is knoking"],
	["AFI - Main", "Knocking"],
	true,
	1,
	{},
	false
] call CBA_fnc_addSetting;


ADDON = true;