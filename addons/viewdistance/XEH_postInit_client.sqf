#include "script_component.hpp"
#include "\a3\editor_f\Data\Scripts\dikCodes.h"

GVAR(min) = 250;
ISNILS(GVAR(max),12000);

if (GVAR(max) < GVAR(min)) then {
	diag_log format["AFI VIEWDISTANCE - afi_viewdistance_max is less than minimum value (%1)", GVAR(min)];
	GVAR(max) = GVAR(min);
};

GVAR(current) = (profileNamespace getVariable [QGVAR(current), viewDistance]) min GVAR(max);
GVAR(keyDown) = false;

[GVAR(current)] call FUNC(updateVD);

["AFI View Distance", "dec_viewdistance", "Decrease view distance", {[0] call FUNC(onKeyDown)}, "", [DIK_F1, [false, false, false]], true] call CBA_fnc_addKeybind;
["AFI View Distance", "inc_viewdistance", "Increase view distance", {[1] call FUNC(onKeyDown)}, "", [DIK_F2, [false, false, false]], true] call CBA_fnc_addKeybind;