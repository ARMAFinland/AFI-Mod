#include "script_component.hpp"


if (missionNamespace getVariable [QGVAR(enableViewdistance),false]) then {
	private _value = (missionNamespace getVariable [QGVAR(viewdistance),3000]);
	EGVAR(viewdistance,max) = _value;
	publicVariable QEGVAR(viewdistance,max);
	LOG("set view distance");
};

if (missionNamespace getVariable [QGVAR(enableSafeStart),false] && isMultiplayer) then {
	private _value = (missionNamespace getVariable [QGVAR(safeStartLength),15]);
	[_value] call EFUNC(safestart,start); 
	LOG("start safestart");
};

if (missionNamespace getVariable [QGVAR(enableViewdistanceServer),false] && isDedicated) then {
	private _value = (missionNamespace getVariable [QGVAR(viewdistanceServer),3000]);
	setViewDistance _value;
	LOG("set server view distance");
};