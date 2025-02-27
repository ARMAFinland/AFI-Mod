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
 * [] call afi_event_system_fnc_getSideVehicles
 */
#include "script_component.hpp"
params [["_side",nil,[west]], "_allVehicles"];
private _sideVehicles = [];
private _sideNumber = [west,east,resistance,civilian] find _side;

{
    private _vehicle = _x;
    private _sideAtributeNumber = (_vehicle get3DENAttribute QGVAR(vehicleSide)) select 0;

    if (_vehicle isKindOf "AllVehicles" && {_sideAtributeNumber < 0}) then {
        REM(_allVehicles,_vehicle);
        continue
    };

    if (_sideNumber isEqualTo _sideAtributeNumber) then {
        REM(_allVehicles,_vehicle);
        private _vehicleName = (_vehicle get3DENAttribute "description") select 0;

        if (_vehicleName isEqualTo "") then { 
            _vehicleName = getText (configFile >> "CfgVehicles" >> typeOf _vehicle >> "displayName");
        }; 

        private _vehicleDescription = (_vehicle get3DENAttribute QGVAR(unitAdditionalDescription)) select 0;

        private _vehicleCategory = getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "vehicleClass");
        _vehicleCategory = getText(configFile >> "CfgVehicleClasses" >> _vehicleCategory >> "displayName");
        if (_vehicleCategory == "") then {_vehicleCategory = "Misc";};

        _sideVehicles pushBack createHashMapFromArray [ 
                ["VehicleName", _vehicleName],
                ["VehicleDescription", _vehicleDescription],
                ["VehicleCategory", _vehicleCategory]
            ];
    };
    
} forEach _allVehicles;

[_sideVehicles,_allVehicles]
