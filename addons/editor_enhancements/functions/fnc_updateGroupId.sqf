#include "script_component.hpp"
/*
	Author: Bummeri & Tuntematon

	Description:
	Will update each units roledescription to match the Displayname@Groupid. Displayname is assigned in units config. Forexample: "Machinegunner". GroupID needs to be assigned in the groups eden attributes.

	Parameter(s):
	0: Units - Units that are affected by the function. ARRAY.

	Returns:
	Bool - True when done
*/
params [["_selectedUnits",[],[]]];

FILTER(_selectedUnits,private _unit = _x; (_unit get3DENAttribute "ControlMP") select 0 || (_unit get3DENAttribute "ControlSP") select 0);
if (_selectedUnits isEqualTo []) exitWith {
	["Zero playable units selected",1,9] call BIS_fnc_3DENNotification;
};

GVAR(unitIdInInitArray) = [];
collect3DENHistory {
	{
		private _unit = _x;
		if (_unit isEqualTo leader group _unit) then {
			private _group = group _unit;
			private _initUnit = (_unit get3DENAttribute "init") select 0; 
			private _initGroup = (_group get3DENAttribute "init") select 0;
			private _groupIdInUnitInit = toLower _initUnit find "setgroupid";
			private _groupIdInUnitInitBool = _groupIdInUnitInit isNotEqualTo -1;
			private _groupIdInGroupInit = toLower _initGroup find "setgroupid";


			if (_groupIdInUnitInitBool || _groupIdInGroupInit isNotEqualTo -1) then {
				
				private _init = [_initGroup,_initUnit] select _groupIdInUnitInitBool;
				private _initPOS = [_groupIdInGroupInit,_groupIdInUnitInit] select _groupIdInUnitInitBool;

				
				private _idStart = (_init find ["[", _initPOS]) + 2;
				private _idEnd = ((_init find ["]", _idStart]) - 1) - _idStart;
				private _id = _init select [_idStart,_idEnd];
				TRACE_4("asd",_idStart,_idEnd,_id,_init);
				_group set3DENAttribute ["groupID", _id];
				if (_groupIdInUnitInitBool) then {
					GVAR(unitIdInInitArray) pushBack _group;
				};
			} else {
				private _id = _group get3DENAttribute "groupID" select 0;
				GVAR(unitIdInInitArray) pushBack _group;
			};
		};
	} forEach _selectedUnits;

	if (GVAR(unitIdInInitArray) isEqualTo []) then {
		{
			private _unit = _x;
			private _roleDescription = (_unit get3DENAttribute "description") select 0;
			private _cbaGroupPos = _roleDescription find "@";
			if (_cbaGroupPos isNotEqualTo -1) then {
				_roleDescription = _roleDescription select [0,_cbaGroupPos];
			};
			_roleDescription = trim _roleDescription;
			_roleDescription = [_roleDescription,"@",group _unit get3DENAttribute "groupID" select 0] joinString "";
			_unit set3DENAttribute ["description", _roleDescription];
		} forEach _selectedUnits;
	};
};


if (GVAR(unitIdInInitArray) isNotEqualTo []) then {
	private _text = "There are issues with either the unit's group ID not being set or being in the wrong place for the following groups:" + ((GVAR(unitIdInInitArray) joinString ", ")+ "." );
	[
		_text,
		"Update group IDs",
		[
			"Show guide",
			{ [[QGVAR(Editor_Tutorials), QGVAR(setGroupID)], 0, false] call BIS_fnc_3DENTutorial; }
		],
		[
			"Im big boy",
			{ }
		]
	] call BIS_fnc_3DENShowMessage;
	
} else {
	["Group IDs updated, no errors found",0,12] call BIS_fnc_3DENNotification;
}; 
true