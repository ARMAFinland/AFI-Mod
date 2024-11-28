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
 * [] call afi_engine_delay_fnc_serverEngineStop
 */
#include "script_component.hpp"
params ["_vehicle"];

//should not be stopping twice, but i trust Arma like i trust soviet union.
private _engineStopping = _vehicle getVariable [QGVAR(engineStopping), false];
if (_engineStopping) exitWith { diag_log "engine was already stopping"};
_vehicle setVariable [QGVAR(engineStopping), true];
_vehicle setVariable [QGVAR(engineStarting), false];

private _engineFullStart = _vehicle getVariable [QGVAR(engineFullStart), false];
_vehicle setVariable [QGVAR(engineFullStart), false];

private _configDelay = getNumber (configOf _vehicle >> "ace_vehicles_engineStartDelay");
private _cooldownMultiplier = GVAR(cooldownMultiplier);
private _engineStartTime = _vehicle getVariable [QGVAR(engineStartTime),0];

if (_engineFullStart || (_engineStartTime + _configDelay * _cooldownMultiplier) > cba_missiontime ) then {

	private _initialDelay = _vehicle getVariable ["ace_vehicles_engineStartDelay", 0.01];
	[{
		params ["_args", "_handle"];
		_args params ["_vehicle", "_configDelay", "_engineStopTime", "_cooldownMultiplier", "_initialDelay"];
		TUN_SKIP_PAUSED;
		
		private _maxFrom = (_engineStopTime + _configDelay * _cooldownMultiplier);
		private _newStartupDelay = linearConversion [_engineStopTime, _maxFrom, cba_missionTime, _initialDelay, _configDelay, true];

		if (driver _vehicle isNotEqualTo objNull) then {
			_vehicle setVariable ["ace_vehicles_engineStartDelay", _newStartupDelay, true];	
		};

		private _engineStopping = _vehicle getVariable [QGVAR(engineStopping), false];
		if !(_engineStopping) exitWith {
			_vehicle setVariable ["ace_vehicles_engineStartDelay", _newStartupDelay, true];
			TUN_DELETE_PAUSE_SKIP;
			_handle call CBA_fnc_removePerFrameHandler;
		};

		if ( _newStartupDelay >= _configDelay ) exitWith {
			_vehicle setVariable ["ace_vehicles_engineStartDelay", nil, true];
			TUN_DELETE_PAUSE_SKIP;
			_handle call CBA_fnc_removePerFrameHandler;
		};

	}, 0.1, [_vehicle, _configDelay, cba_missionTime, _cooldownMultiplier, _initialDelay]] call CBA_fnc_addPerFrameHandler;
} else {
	_vehicle setVariable ["ace_vehicles_engineStartDelay", nil, true];
};