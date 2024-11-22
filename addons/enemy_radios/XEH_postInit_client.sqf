#include "script_component.hpp"

[{cba_missionTime > 0 && (!isNull player || isDedicated)}, {
	if (!GVAR(allowed)) then {
		player addEventHandler ["take", {
			_this call FUNC(tfrDisallowEnemyRadios);
		}];
	};
}] call CBA_fnc_waitUntilAndExecute;