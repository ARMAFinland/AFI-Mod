#include "script_component.hpp"

if (!GVAR(allowed)) then {
	params ["_vehicle", "_role", "_unit"];

	if (player == _unit) then {
		private _locked = _vehicle getVariable[QGVAR(locked), true];
		private _lockedSide = _vehicle getVariable QGVAR(lockedSide);

		if (_locked && (playerSide != civilian) && !(player getVariable ["ace_captives_isHandcuffed", false])) then {
			if (!isNil "_lockedSide") then {
				if ((_lockedSide getFriend playerSide) < 0.6) then {
					_unit action ["EngineOff", _vehicle];
					_unit action ["GetOut", _vehicle];
					hint "I don't have required qualification to operate that vehicle.";
				};
			} else { // lock vehicle to side
				if (((_vehicle isKindOf "Car") && GVAR(allowCars)) || (_vehicle isKindOf "StaticWeapon")) then {
					_vehicle setVariable[QGVAR(locked), false, true]; // don't lock cars or static weapons
				} else {
					_vehicle setVariable [QGVAR(lockedSide), playerSide, true];
				};
			};
		};
	};
};
