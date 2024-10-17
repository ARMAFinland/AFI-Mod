/*
 * Author: [Tuntematon]
 * [Description]
 * 
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call afitweaks_knocking_fnc_knockOnTank
 */
#include "script_component.hpp"
params ["_tank", "_player"];

private _crew = crew _tank;

[QGVAR(wakeUpCrew), [_tank, _player], _crew] call CBA_fnc_targetEvent;

//Less networking
private _nearPlayers = allUnits inAreaArray [_tank, 50, 50, 0, false, 50];
_nearPlayers = _nearPlayers - _crew;
[QGVAR(doKnocking), [_player], _nearPlayers] call CBA_fnc_targetEvent;

["You knock on the vehicle", false, 5] call ace_common_fnc_displayText;