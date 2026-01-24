#include "script_component.hpp"

params [["_part",nil,[0]]];
TRACE_2("",GVAR(unitIdInInitArray),(isNil QGVAR(unitIdInInitArray)));
private _groupArray = [GVAR(unitIdInInitArray), allGroups] select (GVAR(unitIdInInitArray) isEqualTo [] || isNil QGVAR(unitIdInInitArray));

TRACE_1("groupArray ",_groupArray);
if (_groupArray isEqualTo []) exitWith {
	["Zero units selected",1,9] call BIS_fnc_3DENNotification;
};

private _group = _groupArray select 0;
private _entityID = -1;
TRACE_3("group ",_groupArray,_part,_group);
switch (_part) do {
	case 1: {
		private _leader = leader _group;
		_entityID = get3DENEntityID _leader;
		TRACE_2("leader ",_leader,_entityID);
	};
	case 2: {
		_entityID = get3DENEntityID _group;
		TRACE_1("group ",_entityID);
	};
};

do3DENAction "ClearSelections";
set3DENSelected [_entityID];
do3DENAction "OpenAttributes";

true
