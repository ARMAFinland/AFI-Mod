#include "script_component.hpp"
/*
	Author: Bummeri <@Armafinland.fi>

	Description:
	Will create 50 virtual spectator slots on the middle of the screen.

	Parameter(s):
	none

	Returns:
	Bool - True when done
*/
collect3DENHistory {
	for "_i" from 1 to 50 step 1 do
	{
		private _screenCords = [random [0.3,0.5,0.7],random [0.3,0.5,0.7]];
		private _spectator = create3DENEntity ["Logic","ace_spectator_virtual",screenToWorld _screenCords];
		_spectator set3DENAttribute ["ControlMP",true];
	};
};


["50 virtual spectator slots were created on the middle of the screen. Undo changes with Ctrl+Z.",0,9] call BIS_fnc_3DENNotification;

true