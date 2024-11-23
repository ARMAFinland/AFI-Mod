#include "script_component.hpp"

[{cba_missionTime > 0 && (!isNull player || isDedicated)}, {
	if (!GVAR(allowed)) then {
		player addEventHandler ["Take", {
			_this call FUNC(tfrDisallowEnemyRadios);
		}];
	};
}] call CBA_fnc_waitUntilAndExecute;