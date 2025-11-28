#include "script_component.hpp"

[] call FUNC(briefingEquipment);

private _id = [QGVAR(equipmentChatMessage), {
    params ["_name","_mass",["_containerInfo",[]]];
    _name = str (parseText (toString _name));
    _containerInfo = toString _containerInfo;

    ace_player sideChat "==== Item Information ====";
    ace_player sideChat "- Item: " + _name;
    ace_player sideChat "- Weight: " + str _mass + "kg";
    if (_containerInfo isNotEqualTo "") then {
        ace_player sideChat "- Free: " + _containerInfo;
    };
    ace_player sideChat "========================";
}] call CBA_fnc_addEventHandler;
