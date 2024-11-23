#include "script_component.hpp"

if (!alive ACE_player) exitWith {
	["ace_hearing", 1, true] call FUNC(setHearingCapability);
};

private _volume = ace_hearing_volume;

// Reduce volume if player is unconscious
if (ACE_player getVariable ["ACE_isUnconscious", false]) then {
	_volume = _volume min ace_hearing_UnconsciousnessVolume;
};

["ace_hearing", _volume, true] call FUNC(setHearingCapability);