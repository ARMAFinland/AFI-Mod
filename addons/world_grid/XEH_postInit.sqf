#include "script_component.hpp"

[{cba_missionTime > 0 && (!isNull player || isDedicated)}, {
	if (GVAR(grid) isEqualTo -1) then {
		GVAR(grid) = 12.5;
		
		if (IS_ADMIN && isMultiplayer) then {
			player groupChat format["afi terrain grid - missing setting for world: %1, defaulting to 12.5. Set value from CBA Addon settings", worldName];
		};

		diag_log format["afi terrain grid - missing setting for world: %1, defaulting to 12.5", worldName];
	};

	setTerrainGrid GVAR(grid);
}] call CBA_fnc_waitUntilAndExecute;