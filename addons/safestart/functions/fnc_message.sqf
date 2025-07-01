#include "script_component.hpp"

params ["_timer"];

if(_timer > 0) then {
	[format [ "<t size='0.8' color='#00ff00' shadow=2>Safestart remaining: %1 minute(s)</t>", _timer], 0, 0.1*safeZoneH+safeZoneY, 58, 0, 0, 38] spawn BIS_fnc_dynamicText;
} else {
	[format [ "<t size='0.8' color='#00ff00' shadow=2>%1</t>", "Mission starting now!"], 0, 0.1*safeZoneH+safeZoneY, 3, 0, 0, 38] spawn BIS_fnc_dynamicText;
};
