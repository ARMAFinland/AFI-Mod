#include "script_component.hpp"

[
	{cba_missionTime > 0 && (!isNull player || isDedicated)}, {
		setTerrainGrid GVAR(grid);
	}
] call CBA_fnc_waitUntilAndExecute;