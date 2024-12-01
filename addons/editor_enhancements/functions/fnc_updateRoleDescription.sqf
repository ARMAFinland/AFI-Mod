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

if (_selectedUnits isEqualTo []) exitWith {
	["Zero units selected",1,9] call BIS_fnc_3DENNotification;
};

collect3DENHistory {
	{
		private _unit = _x;
		private _group = group _unit;
		private _roleDescription = (configFile >> "CfgVehicles" >> typeOf _unit >> "displayName") call BIS_fnc_getCfgData;//Get units role description or "displayname"
		if (_unit isEqualTo leader group _unit) then {
			_roleDescription =  [_roleDescription,"@",group _unit get3DENAttribute "groupID" select 0] joinString ""; // Join together the units display name, @ cba separator and the units callsign.
		};
		_unit set3DENAttribute ["description", _roleDescription]; //Set it to the unit
	} forEach _selectedUnits;
};

["Each selected units Role descriptions were updated to: Displayname@Groupid format. Displayname units config role, example: 'Machinegunner'. GroupID was taken from groups eden attributes. Undo changes with Ctrl+Z.",0,12] call BIS_fnc_3DENNotification;

true