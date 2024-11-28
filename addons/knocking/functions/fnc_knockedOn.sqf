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
 * [] call afi_knocking_fnc_knockedOn 
 */
#include "script_component.hpp"
params ["_tank", "_knocker"];

if (vehicle ace_player isNotEqualTo _tank) exitWith {};

playSound QGVAR(knockMetalInside);

private _text = "Someone is knocking on the vehicle";

if (GVAR(notifyIfEnemy)) then {
	if ([playerSide, side _knocker] call BIS_fnc_sideIsFriendly) then {
		_text = "You have feeling that friendly is knocking on the vehicle";
	} else {
		_text = "You have feeling that ENEMY is knocking on the vehicle";
	};
};

[_text, false, 10] call ace_common_fnc_displayText;