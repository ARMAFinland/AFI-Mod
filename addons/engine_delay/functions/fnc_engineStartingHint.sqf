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
 * [] call afi_engine_delay_fnc_engineStartingHint
 */
#include "script_component.hpp"
params [["_type", 0],["_time", false]];

_text = switch (_type) do {
	case 1: {  
		format["Engine starting in ~%1s", ceil _time]
	};
	case 2: { 
		"The engine has fully started"
	};
	case 3: { 
		"The engine did not fully start"
	};
	case 4: { 

	};
	default { };
};

[_text, false, _time] call ace_common_fnc_displayText;
