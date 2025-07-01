#include "script_component.hpp"


["missiondebug", {
	remoteExecCall [QFUNC(missiondebug), 0 , true];
}, "admin"] call CBA_fnc_registerChatCommand;

//Run debug always on SP, if not disabled from settings
if !(isMultiplayer) then {
	if (GVAR(enableMissionDebug)) then {
		[{
			[] call FUNC(missiondebug);
		}, [], 5] call CBA_fnc_waitAndExecute;
	};
};
