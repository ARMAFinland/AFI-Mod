#include "script_component.hpp"

[{cba_missionTime > 0 && (!isNull player || isDedicated)}, {
	{
		_x params ["_channel", "_markersEnabled"];
		
		// disabloi aina chat
		// enabloi voip jos markkerit on sallittu
		
		_channel enableChannel [false, _markersEnabled];
		
	} forEach [[0, GVAR(global)], [1, GVAR(side)], [2, GVAR(command)], [3, GVAR(group)], [4, GVAR(vehicle)], [5, GVAR(direct)]];

	if (isServer) then {
		if (GVAR(global)) then { // enableChat ei toimi globaliin servulla koska bis
			[[[0, localize "str_channel_global"], [1, localize "str_channel_side"], [2, localize "str_channel_command"], [3, localize "str_channel_group"], [4, localize "str_channel_vehicle"], [5, localize "str_channel_direct"]]] call swt_markers_updateAvailableChannels;
		} else {
			[[[1, localize "str_channel_side"], [2, localize "str_channel_command"], [3, localize "str_channel_group"], [4, localize "str_channel_vehicle"], [5, localize "str_channel_direct"]]] call swt_markers_updateAvailableChannels;
		};
	};
}] call CBA_fnc_waitUntilAndExecute;