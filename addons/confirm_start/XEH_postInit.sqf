#include "script_component.hpp"

if (isMultiplayer && !isServer) then {
	[{!isNull player}, {
		if (time isEqualTo 0) then {
			[{(!isNull findDisplay 53)}, {
				((findDisplay 53) displayCtrl 1) ctrlEnable false;
			}, []] call CBA_fnc_waitUntilAndExecute;
		};
	}, []] call CBA_fnc_waitUntilAndExecute;
};