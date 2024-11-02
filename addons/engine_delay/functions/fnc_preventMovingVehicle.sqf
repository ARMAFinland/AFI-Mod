/*
 * Author: [Tuntematon]
 * [Description]
 * 
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call afitweaks_engine_delay_fnc_preventMovingVehicle
 */
#include "script_component.hpp"
params ["_vehicle", "_isEngineOn"];

if (!_isEngineOn || {floor abs speed _vehicle > 0} || {!isNull isVehicleCargo _vehicle} || {(surfaceIsWater (getPos _vehicle))} || {!hasInterface}) exitWith {};

private _startupDelay = _vehicle getVariable ["ace_vehicles_engineStartDelay", getNumber (configOf _vehicle >> "ace_vehicles_engineStartDelay")];
if (_startupDelay <= 0) exitWith {};

[1, _startupDelay] call FUNC(engineStartingHint);

//Add eh to prevent moving
private _keyDownEventHandler = -1;
if ((driver _vehicle) isEqualTo ace_player) then {
	_keyDownEventHandler = ["KeyDown", {
		private _key = param [1];
		private _overideEngine = false;

		private _movementActionKey = [];
		{
			_movementActionKey append _x;
			
		} forEach [(actionKeys "carForward"),(actionKeys "carBack"),(actionKeys "CarLeft"),(actionKeys "CarRight")];

		// block moving vehicle
		if (_key in _movementActionKey) then {
			if (ace_player isEqualTo (driver objectParent ace_player)) then {
				_overideEngine = true;
			};
		};

		// if (isNull objectParent ace_player) then {
		// 	(findDisplay 46) displayRemoveEventHandler ["KeyDown", _thisEventHandler];
		// };

		_overideEngine
	}] call CBA_fnc_addDisplayHandler;
};

//perframe handle
[{
	params ["_args", "_handle"];
	_args params ["_vehicle", "_keyDownEventHandler", "_delay"];

	if ((typeOf _vehicle) isKindOf "plane") then {
		_vehicle setAirplaneThrottle 0
	};

	// Wait and remove key eh
	if ( (cba_missionTime >= _delay) || {!(alive _vehicle)} || {(driver _vehicle) isNotEqualTo ace_player} || {!isEngineOn _vehicle} ) then {
		if (_keyDownEventHandler >= 0) then {
			["KeyDown", _keyDownEventHandler] call CBA_fnc_removeDisplayHandler;
		};

		private _text = [3,2] select (_vehicle isEqualTo (objectParent ace_player) && (cba_missionTime >= _delay));
		[_text, 5] call FUNC(engineStartingHint);
		_handle call CBA_fnc_removePerFrameHandler;
	};
}, 0, [_vehicle, _keyDownEventHandler, (_startupDelay + cba_missionTime)]] call CBA_fnc_addPerFrameHandler;