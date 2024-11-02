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
 * [] call afitweaks_engine_delay_fnc_serverEngineStart
 */
#include "script_component.hpp"
params ["_vehicle", "_isEngineOn"];

private _startupDelay = _vehicle getVariable ["ace_vehicles_engineStartDelay", getNumber (configOf _vehicle >> "ace_vehicles_engineStartDelay")];
private _configDelay = getNumber (configOf _vehicle >> "ace_vehicles_engineStartDelay");
private _engineFullStart = _vehicle getVariable [QGVAR(engineFullStart), false];
private _engineStopTime = _vehicle getVariable [QGVAR(engineStopTime), 0];
// TRACE_5("delays",_isEngineOn,_startupDelay,_configDelay,_engineFullStart,_engineStopTime);

if (_startupDelay <= 0 ) exitWith { };

if (!_isEngineOn) exitWith {
	if (!(_vehicle getVariable [QGVAR(engineStarting), false]) && 0 <_configDelay) then {
		diag_log "run stop engine1";
		[_vehicle] call FUNC(serverEngineStop);
	};
};

if (!isServer || {floor abs speed _vehicle > 0} || {!isNull isVehicleCargo _vehicle} || {(surfaceIsWater (getPos _vehicle))}) exitWith {};

_vehicle setVariable [QGVAR(engineStopping), false];
_vehicle setVariable [QGVAR(engineStarting), true];
private _engineStopTime = cba_missionTime;
_vehicle setVariable [QGVAR(engineStartTime), cba_missionTime];
//perframe handle
[{
	params ["_args", "_handle"];
	_args params ["_vehicle", "_delay", "_startupDelay", "_engineStartTime", "_configDelay"];
	TUN_SKIP_PAUSED;

	if (GVAR(pfhUpdateTime) == cba_missiontime) exitWith { };
	GVAR(pfhUpdateTime) = cba_missiontime;
	// Wait and remove eh
	if ( (cba_missionTime > _delay) || {!(alive _vehicle)} || {!isEngineOn _vehicle} ) exitWith {
		//make sure it is alive and engine is running.
		if (alive _vehicle) then {
			//Update delay
			private _newStartupDelay = _delay - cba_missiontime;
			if (_newStartupDelay <= 0) then {
				_newStartupDelay = nil;
			};
			_vehicle setVariable ["ace_vehicles_engineStartDelay", _newStartupDelay, true];	

			if (isEngineOn _vehicle) then {
				_vehicle setVariable [QGVAR(engineFullStart), true];
				_vehicle setVariable [QGVAR(engineStarting), false];
				
			} else {
				[_vehicle] call FUNC(serverEngineStop);
			};
		};

		//delete this pfh
		TUN_DELETE_PAUSE_SKIP;
		_handle call CBA_fnc_removePerFrameHandler;
	};
}, 0.1, [_vehicle, (_startupDelay + cba_missionTime), _startupDelay, cba_missionTime, _configDelay]] call CBA_fnc_addPerFrameHandler;

