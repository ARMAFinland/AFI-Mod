#include "script_component.hpp"

params ["_id", "_setting", ["_add", true]];

private _exists = false;
private _lowestVolume = 1;

ace_common_setHearingCapabilityMap = ace_common_setHearingCapabilityMap select {
	_x params ["_xID", "_xSetting"];
	if (_id == _xID) then {
		_exists = true;
		if (_add) then {
			_x set [1, _setting];
			_lowestVolume = _lowestVolume min _setting;
			true
		} else {
			false
		};
	} else {
		_lowestVolume = _lowestVolume min _xSetting;
		true
	};
};

if (!_exists && _add) then {
	_lowestVolume = _lowestVolume min _setting;
	ace_common_setHearingCapabilityMap pushBack [_id, _setting];
};

ISNILS(GVAR(volume),1);

0 fadeSound (_lowestVolume * GVAR(volume) * ace_hearing_volumeAttenuation);
0 fadeRadio (_lowestVolume * GVAR(volume) * ace_hearing_volumeAttenuation);
0 fadeMusic (_lowestVolume * GVAR(volume) * ace_hearing_volumeAttenuation);


ACE_player setVariable ["tf_globalVolume", _lowestVolume];
if (!isNil "acre_api_fnc_setGlobalVolume") then {
	[_lowestVolume^0.33] call acre_api_fnc_setGlobalVolume;
};