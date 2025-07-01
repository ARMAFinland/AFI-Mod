#include "script_component.hpp"

[QGVAR(wakeUpCrew), {
	params ["_tank", "_player"];
	[_tank,_player] call FUNC(knockedOn);
}] call CBA_fnc_addEventHandler;


[QGVAR(doKnocking), {
	params ["_tank"];
	_tank say3D QGVAR(knockMetal);
}] call CBA_fnc_addEventHandler;
