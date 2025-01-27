#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_prep.hpp"
PREP_RECOMPILE_END;


//WorldGrid
GVAR(grid) = -1;

// grid settings

{
	private _world = _x select 0;
	private _worldDesc = _x select 1;

	if (_world == worldName) then {
		[format["afi_grid_w_%1", _world], "SLIDER", format["%1", _worldDesc], "AFI - Terrain Grid", [-1, 50, -1, 2], 1, {GVAR(grid) = _this}, true] call CBA_fnc_addSetting;
	} else {
		[format["afi_grid_w_%1", _world], "SLIDER", format["%1", _worldDesc], "AFI - Terrain Grid", [-1, 50, -1, 2]] call CBA_fnc_addSetting;
	};
} forEach ([] call FUNC(listWorlds));


ADDON = true;