#include "script_component.hpp"
/*
	Author: Bummeri & Tuntematon

	Description:
	Update min/max player count for the mission file. Max is all non virtual playable units. Min is 90% of that, rounded down. Use in 3den.

	Parameter(s):
	none

	Returns:
	Bool - True when done
*/

collect3DENHistory {
	"Multiplayer" set3DENMissionAttribute ["MaxPlayers", count playableUnits];
	"Multiplayer" set3DENMissionAttribute ["MinPlayers", floor(count playableUnits * 0.9)];
};

["The missions Min/Max player were updated. Max is set to the count of all non-virtual playable units. Min is 90% of that, rounded down. Update them if needed.",0,9] call BIS_fnc_3DENNotification;

true