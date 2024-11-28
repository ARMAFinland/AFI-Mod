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
 * [] call afi_knocking_fnc_knockingConditio
 */
#include "script_component.hpp"
params ["_tank"];

private _return = true;

if (GVAR(disableKnockingOnEnemy)) then {
	if (crew _tank isNotEqualTo []) then {
		_return = side ace_player isEqualTo (side _tank);
	};
};

_return