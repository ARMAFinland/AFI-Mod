#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

RHS_ENGINE_STARTUP_OFF = true;



[
	QGVAR(cooldownMultiplier),
	"SLIDER",
	["Multiplier on vehicle startup delay cooldown", "Multiplier for the linear conversion of engine cooldown duration. This determines how long it takes for the engine to cool down enough to reset the startup delay fully. The delay is calculated as startupDelay * this multiplier. For example, if the default delay is 10 seconds and the multiplier is set to 2, it will take 20 seconds to reset to the full delay.. "],
	["AFI - Main", "Engine Start Delay"],
	[0.1, 10, 2, 1],
	1,
	{},
	false
] call CBA_fnc_addSetting;

ADDON = true;