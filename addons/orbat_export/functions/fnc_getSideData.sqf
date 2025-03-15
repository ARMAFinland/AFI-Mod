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
 * [] call afi_event_system_fnc_getSideData
 */
#include "script_component.hpp"
params [["_side",nil,[west]]];

private _atributes = switch (_side) do {
    case west: { [QGVAR(sideNameWest),QGVAR(sideDescriptionWest),"#004C99"] };
    case east: { [QGVAR(sideNameEast),QGVAR(sideDescriptionEast),"#800000"] };
    case resistance: { [QGVAR(sideNameResistance),QGVAR(sideDescriptionResistance),"#008000"] };
    case civilian: { [QGVAR(sideNameCivilian),QGVAR(sideDescriptionCivilian),"#660080"] };
};

_atributes params["_sideName","_sideDescription","_color"];

_sideName = QEGVAR(editor_enhancements,missionAttributes) get3DENMissionAttribute _sideName;
_sideDescription = QEGVAR(editor_enhancements,missionAttributes) get3DENMissionAttribute _sideDescription;

if (_sideName isEqualTo "" || isNil "_sideName") then {
    _sideName = [_side] call BIS_fnc_sideName;
    if (_sideName isEqualTo "Independent") then {
        _sideName = "Indfor";
    };
};

[_side,_sideName,_sideDescription,_color]