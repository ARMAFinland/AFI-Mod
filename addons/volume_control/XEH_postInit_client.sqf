#include "\a3\editor_f\Data\Scripts\dikCodes.h"
#include "script_component.hpp"

GVAR(volumeArray) = [0.001, 0.0035, 0.005, 0.01, 0.02, 0.038, 0.05, 0.1, 0.2, 0.3, 0.5, 0.6, 0.8, 0.9, 1];
GVAR(volumeIndex) = profileNamespace getVariable [QGVAR(volumeIndex), count GVAR(volumeArray) - 1];

GVAR(volume) = GVAR(volumeArray) select GVAR(volumeIndex);
GVAR(timeToHideHint) = 0;


[{!isNull player && cba_missionTime > 0}, {
	["AFI Volume Control", QGVAR(decSoundVolume_key), "Decrease Volume [-]", {[-1] call FUNC(changeSoundVolume)}, {}, [DIK_F3, [false, false, false]]] call CBA_fnc_addKeybind;
	["AFI Volume Control", QGVAR(incSoundVolume_key), "Increase Volume [+]", {[1] call FUNC(changeSoundVolume)}, {}, [DIK_F4, [false, false, false]]] call CBA_fnc_addKeybind;

	ace_hearing_disableVolumeUpdate = true;
	[FUNC(updateVolume), 1, [false]] call CBA_fnc_addPerFrameHandler;
}, []] call CBA_fnc_waitUntilAndExecute;
