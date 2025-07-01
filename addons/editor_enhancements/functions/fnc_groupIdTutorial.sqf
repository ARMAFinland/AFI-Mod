#include "script_component.hpp"

params [["_part",nil,[0]]];

private _groupArray = if (GVAR(unitIdInInitArray) isEqualTo []) then {
	allGroups
} else {
	GVAR(unitIdInInitArray)
};

if (_groupArray isEqualTo []) exitWith {
	["Zero units selected",1,9] call BIS_fnc_3DENNotification;
};

private _group = _groupArray select 0;
private _leader = leader _group;
private _entityID = -1;


switch (_part) do {
	case 1: {
		_entityID = get3DENEntityID _leader;
	};
	case 2: {
		_entityID = get3DENEntityID _group;
	};
};

do3DENAction "ClearSelections";
set3DENSelected [_entityID];
do3DENAction "OpenAttributes";

true
