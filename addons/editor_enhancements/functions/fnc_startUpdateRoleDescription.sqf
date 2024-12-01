#include "script_component.hpp"

[
	"Before running this, ensure the Check Group ID command does not report any errors. It will override previous descriptions!",
	"Update unit descriptions",
	[
		"Run",
		{ [] call FUNC(updateRoleDescription);}
	],
	[
		"Exit",
		{ }
	]
] call BIS_fnc_3DENShowMessage;

true