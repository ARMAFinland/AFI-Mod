#include "script_component.hpp"

[
	"This will override previous descriptions!",
	"Update unit descriptions",
	[
		"Run",
		{ [] call FUNC(updateRoleDescription); closeDialog 0; }
	],
	[
		"Exit",
		{ }
	]
] call BIS_fnc_3DENShowMessage;

true