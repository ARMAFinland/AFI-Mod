#include "script_component.hpp"
//[0] call afi_safestart_fnc_editSafestartDuration
params ["_duration"];

if (_duration > 0) then {
	GVAR(timeLeft) = _duration;

	[] call FUNC(timer);
} else { // end safestart
	[GVAR(pfeh_handle)] call CBA_fnc_removePerFrameHandler;
	GVAR(pfeh_handle) = -1;
	
	GVAR(timeLeft) = 0;
	
	if (GVAR(ehJipID) != "") then {
		["eh_afi_safestart", [GVAR(timeLeft)], GVAR(ehJipID)] call CBA_fnc_globalEvent;
		
		[GVAR(ehJipID)] call CBA_fnc_removeGlobalEventJIP;
		GVAR(ehJipID) = "";
	};
};
