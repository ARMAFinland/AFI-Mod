#include "script_component.hpp"

params ["_id", "_setting", ["_add", true]];

private _lowestVolume = 1;

_id = toLowerANSI _id;

// Save setting
if (_add) then {
    ace_common_setHearingCapabilityMap set [_id, _setting];
} else {
    ace_common_setHearingCapabilityMap deleteAt _id;
};

private _lowestVolume = selectMin values ace_common_setHearingCapabilityMap;

ISNILS(GVAR(volume),1);

0 fadeSound (_lowestVolume * GVAR(volume) * ace_hearing_volumeAttenuation);
0 fadeRadio (_lowestVolume * GVAR(volume) * ace_hearing_volumeAttenuation);
0 fadeMusic (_lowestVolume * GVAR(volume) * ace_hearing_volumeAttenuation);


// Set radio mod variables
ACE_player setVariable ["tf_globalVolume", _lowestVolume];
if (!isNil "acre_api_fnc_setGlobalVolume") then {
	[_lowestVolume^0.33] call acre_api_fnc_setGlobalVolume;
};