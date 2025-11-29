#include "script_component.hpp"

[] call FUNC(briefingEquipment);

private _id = [QGVAR(equipmentChatMessage), {
    params ["_name","_mass",["_containerInfo",[]],["_count",0]];
    _name = str (parseText (toString _name));
    _containerInfo = toString _containerInfo;

    ace_player sideChat "=====Item Information=====";
    ace_player sideChat "- Item: " + _name;
    if (_count > 0) then {
        ace_player sideChat "- Count: " + str _count;
    };
    ace_player sideChat "- Weight: " + str _mass + "kg";
    if (_containerInfo isNotEqualTo "") then {
        ace_player sideChat "- Free: " + _containerInfo;
    };

    ace_player sideChat "========================";
}] call CBA_fnc_addEventHandler;
