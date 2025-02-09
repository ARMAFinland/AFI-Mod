#include "script_component.hpp"
/*
	Author: Bummeri <@Armafinland.fi>

	Description:
	Will update each units roledescription to match the Displayname@Groupid. Displayname is assigned in units config. Forexample: "Machinegunner". GroupID needs to be assigned in the groups eden attributes.

	Parameter(s):
	0: Units - Units that are affected by the function. ARRAY.

	Returns:
	Bool - True when done
*/
private _selectedUnits = get3DENSelected 'object';
FILTER(_selectedUnits,private _unit = _x; (_unit get3DENAttribute "ControlMP") select 0 || (_unit get3DENAttribute "ControlSP") select 0);

if (_selectedUnits isEqualTo []) exitWith {
	["Zero playable units selected",1,9] call BIS_fnc_3DENNotification;
};

collect3DENHistory {
	{
		private _unit = _x;
		private _group = group _unit;
		private _roleDescriptionOld = (_unit get3DENAttribute "description") select 0;
		private _cbaGroupPos = _roleDescriptionOld find "@";
		private _roleDescription = (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName") call BIS_fnc_getCfgData;//Get units role description or "displayname"

		if (_cbaGroupPos isNotEqualTo -1) then {
			_roleDescription = (trim _roleDescription) + trim (_roleDescriptionOld select [_cbaGroupPos]);
		};
		_unit set3DENAttribute ["description", _roleDescription]; //Set it to the unit
	} forEach _selectedUnits;
};

["Each selected units Role descriptions were updated to: Displayname format. Displayname units config role, example: 'Machinegunner'. Undo changes with Ctrl+Z.",0,12] call BIS_fnc_3DENNotification;

true