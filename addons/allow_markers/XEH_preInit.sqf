#include "script_component.hpp"
ADDON = false;

// PREP_RECOMPILE_START;
// #include "XEH_PREP.hpp"
// PREP_RECOMPILE_END;

[
	QGVAR(global),
	"CHECKBOX",
	["Global Channel Enabled", "Enable this channel for markers"],
	["AFI - Main", "Markers"],
	false,
	1
] call CBA_Settings_fnc_init;

[
	QGVAR(side),
	"CHECKBOX",
	["Side Channel Enabled", "Enable this channel for markers"],
	["AFI - Main", "Markers"],
	false,
	1
] call CBA_Settings_fnc_init;

[
	QGVAR(command),
	"CHECKBOX",
	["Command Channel Enabled", "Enable this channel for markers"],
	["AFI - Main", "Markers"],
	false,
	1
] call CBA_Settings_fnc_init;

[
	QGVAR(group),
	"CHECKBOX",
	["Group Channel Enabled", "Enable this channel for markers"],
	["AFI - Main", "Markers"],
	false,
	1
] call CBA_Settings_fnc_init;

[
	QGVAR(vehicle),
	"CHECKBOX",
	["Vehicle Channel Enabled", "Enable this channel for markers"],
	["AFI - Main", "Marker channels"],
	true,
	1
] call CBA_Settings_fnc_init;

[
	QGVAR(direct),
	"CHECKBOX",
	["Direct Channel Enabled", "Enable this channel for markers"],
	["AFI - Main", "Markers"],
	true,
	1
] call CBA_Settings_fnc_init;

ADDON = true;