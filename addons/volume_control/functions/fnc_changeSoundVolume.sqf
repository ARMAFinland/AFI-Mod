#include "script_component.hpp"

params["_delta"];
private["_ind"];

GVAR(volumeIndex) = 0 max round(((count GVAR(volumeArray)) - 1) min (GVAR(volumeIndex) + _delta));
GVAR(volume) = 1 min (0.001 max (GVAR(volumeArray) select GVAR(volumeIndex)));

[true] call FUNC(updateVolume);

_ind = toArray ("-------------------------" select [0, (count GVAR(volumeArray))]);
_ind set [GVAR(volumeIndex), 124]; //"|" = 124

hintSilent parseText format ["Volume: %1<br /><t color='#00ff00' size='2'>%2</t>", GVAR(volumeIndex), toString _ind];
profileNamespace setVariable [QGVAR(volumeIndex), GVAR(volumeIndex)];

if (GVAR(timeToHideHint) == 0) then {
	GVAR(timeToHideHint) = CBA_MissionTime + 2;
	
	[{CBA_MissionTime > GVAR(timeToHideHint)}, {hintSilent ""; GVAR(timeToHideHint) = 0;}] call CBA_fnc_waitUntilAndExecute;
} else {
	GVAR(timeToHideHint) = CBA_MissionTime + 2;
};

true
