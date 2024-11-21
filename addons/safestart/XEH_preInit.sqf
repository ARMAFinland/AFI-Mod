#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

if (hasInterface) then {	
	GVAR(safetyEnabled) = false;

	["eh_afi_safestart", {
		_this call FUNC(message);
		
		if ((_this select 0) < 1) then {
			[false, player] call FUNC(safety);
		} else {
			if (!GVAR(safetyEnabled)) then {
				[true, player] call FUNC(safety);
			};
		};
	}] call CBA_fnc_addEventHandler;
};

if (isServer) then {
	GVAR(ehJipID) = "";
	GVAR(pfeh_handle) = -1;
	GVAR(timeLeft) = 0;
	
	["eh_afi_safestart_edit", {
		_this call FUNC(editSafestartDuration);
	}] call CBA_fnc_addEventHandler;
};


//backward comp
afi_safestart = {
	if (!isMultiplayer) then {
		systemChat "Warning - Deprecated function: afi_safestart, call afi_safestart_fnc_start instead on server";
		diag_log "Warning - Deprecated function: afi_safestart, call afi_safestart_fnc_start instead on server";
	};
	
	_this call FUNC(start);
};

ADDON = true;