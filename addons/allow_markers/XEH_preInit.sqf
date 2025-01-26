#include "script_component.hpp"
ADDON = false;

// PREP_RECOMPILE_START;
// #include "XEH_prep.hpp"
// PREP_RECOMPILE_END;

[
	QGVAR(global),
	"CHECKBOX",
	["Global Channel Enabled", "Enable this channel for markers"],
	["AFI - Main", "Markers"],
	false,
	1
] call CBA_fnc_addSetting;

[
	QGVAR(side),
	"CHECKBOX",
	["Side Channel Enabled", "Enable this channel for markers"],
	["AFI - Main", "Markers"],
	false,
	1
] call CBA_fnc_addSetting;

[
	QGVAR(command),
	"CHECKBOX",
	["Command Channel Enabled", "Enable this channel for markers"],
	["AFI - Main", "Markers"],
	false,
	1
] call CBA_fnc_addSetting;

[
	QGVAR(group),
	"CHECKBOX",
	["Group Channel Enabled", "Enable this channel for markers"],
	["AFI - Main", "Markers"],
	false,
	1
] call CBA_fnc_addSetting;

[
	QGVAR(vehicle),
	"CHECKBOX",
	["Vehicle Channel Enabled", "Enable this channel for markers"],
	["AFI - Main", "Markers"],
	true,
	1
] call CBA_fnc_addSetting;

[
	QGVAR(direct),
	"CHECKBOX",
	["Direct Channel Enabled", "Enable this channel for markers"],
	["AFI - Main", "Markers"],
	true,
	1
] call CBA_fnc_addSetting;

ADDON = true;