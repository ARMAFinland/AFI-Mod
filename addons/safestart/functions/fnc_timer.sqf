#include "script_component.hpp"

if (GVAR(pfeh_handle) == -1) then {	
	GVAR(timeLeft) = GVAR(timeLeft) + 1;
	
	GVAR(pfeh_handle) = [{
		GVAR(timeLeft) = GVAR(timeLeft) - 1;
		
		if (GVAR(ehJipID) == "") then {
			GVAR(ehJipID) = ["eh_afi_safestart", [GVAR(timeLeft)]] call CBA_fnc_globalEventJIP;
		} else {
			["eh_afi_safestart", [GVAR(timeLeft)], GVAR(ehJipID)] call CBA_fnc_globalEventJIP;
		};
			
		if (GVAR(timeLeft) < 1) then {
			[GVAR(ehJipID)] call CBA_fnc_removeGlobalEventJIP;
			GVAR(ehJipID) = "";
			
			[GVAR(pfeh_handle)] call CBA_fnc_removePerFrameHandler;
			GVAR(pfeh_handle) = -1;
		};
	}, 60] call CBA_fnc_addPerFrameHandler;
} else { // modify duration
	[GVAR(pfeh_handle)] call CBA_fnc_removePerFrameHandler;
	GVAR(pfeh_handle) = -1;
	[] call FUNC(timer);
};
