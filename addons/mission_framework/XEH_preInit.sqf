#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_prep.hpp"
PREP_RECOMPILE_END;

[
	QGVAR(addRules),
	"CHECKBOX",
	"Add general rules",
	["AFI - Mission framework", "Briefing"],
	true,
	0,
	{},
	true
] call CBA_fnc_addSetting;

[
	QGVAR(addGeneralInfo),
	"CHECKBOX",
	"Add general info",
	["AFI - Mission framework", "Briefing"],
	true,
	0,
	{},
	true
] call CBA_fnc_addSetting;

ADDON = true;
