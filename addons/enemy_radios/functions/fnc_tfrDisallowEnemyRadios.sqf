#include "script_component.hpp"

params ["_unit", "_source", "_item"];

private _isRadioSameSide = {
	params ["_class", "_side"];

	private _conf = ((configFile >> "CfgWeapons" >> _class >> "tf_encryptionCode"));

	if ((getText(_conf) find _side) >= 0) exitWith{true};

	false
};

private _sidePlayer = toLower(str (side _unit));

if (_sidePlayer == "guer") then {
	_sidePlayer = "independent";
};

if ((_item call TFAR_fnc_isRadio)) then {
	if (!([_item, _sidePlayer] call _isRadioSameSide)) then {
		if (_item == backpack _unit) then {
			_unit action ["DropBag", _source, _item];
		} else {
			_unit unassignItem _item;
			_unit removeItem _item;
			_source addItemCargoGlobal [_item,1];
		};

		hint "You're not allowed to use enemy radios.";
	};
} else { 
	// check if item is backpack, uniform or vest. if yes, check if it contains radios

	if (_item == backpack _unit) exitWith {
		{
			if (_x call TFAR_fnc_isRadio) then {
				if (!([_x, _sidePlayer] call _isRadioSameSide)) then {
					_unit removeItem _x;
				};
			};
		} forEach (backpackItems _unit);
	};

	if (_item == uniform _unit) exitWith {
		{
			if (_x call TFAR_fnc_isRadio) then {
				if (!([_x, _sidePlayer] call _isRadioSameSide)) then {
					_unit removeItem _x;
				};
			};
		} forEach (uniformItems _unit);
	};

	if (_item == vest _unit) exitWith {
		{
			if (_x call TFAR_fnc_isRadio) then {
				if (!([_x, _sidePlayer] call _isRadioSameSide)) then {
					_unit removeItem _x;
				};
			};
		} forEach (vestItems _unit);
	};
};