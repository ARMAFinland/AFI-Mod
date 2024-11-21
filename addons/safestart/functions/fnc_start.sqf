#include "script_component.hpp"

params [["_duration", 5]];

if(isServer) then {
	GVAR(timer) = ["afi_safestart_duration", -1] call BIS_fnc_getParamValue;
	
	if (GVAR(timer) == -1) then { // mission param not found, use script param
		GVAR(timer) = _duration;
	};
	
	GVAR(timeLeft) = GVAR(timer);

	[] spawn {
		waitUntil {time>0};

		[] call FUNC(timer);
	};
};