#include "script_component.hpp"

params ["_changeType"];

private _roundPercent = {
	params ["_min", "_max"];
	
	private _output = ((_min / _max) * 10);
	
	if (ceil(_output) - 0.5 > _output) exitWith {(ceil(_output) - 0.5) * 0.1};
	
	(ceil (_output) * 0.1)
};

private _updateValue = if (_changeType == 0) then {GVAR(max) * -0.05} else {GVAR(max) * 0.05};

private _newViewDistance = GVAR(current) + _updateValue;

if (_newViewDistance < GVAR(min)) then {
	_newViewDistance = GVAR(min);
} else {
	if (_newViewDistance > GVAR(max)) then {
		_newViewDistance = GVAR(max);
	}
};

if (GVAR(current) == GVAR(min)) then {
	if (_newViewDistance > GVAR(current)) then {
		private _roundedVD = GVAR(max) * ([GVAR(min), GVAR(max)] call _roundPercent);

		if (_roundedVD != GVAR(current)) then {
			_newViewDistance = _roundedVD;
		}
	};
};

[_newViewDistance] call FUNC(updateVD);
