/*
 * Author: [Raimo & Tuntematon]
 * [Description]
 * 
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call afi_event_system_fnc_exportJSON
 */
#include "script_component.hpp"

private _sideAtributes = [];
private _sideData = []; 
private _lolFail = [];
private _allVehicles = vehicles;

{
    _x params ["_side","_atribute"];
    private _enabled = QEGVAR(editor_enhancements,missionAttributes) get3DENMissionAttribute _atribute;
    if (_enabled) then {
        _sideAtributes pushBack ([_side] call FUNC(getSideData));
    };
} forEach [[blufor,QGVAR(enableSideDataWest)], [opfor,QGVAR(enableSideDataEast)], [independent,QGVAR(enableSideDataResistance)], [civilian,QGVAR(enableSideDataCivilian)]];

if (_sideAtributes isEqualTo []) exitWith {
    ["All sides export disabled!<br/>Go Attributes -> AFI Mission atributes",1,12] call BIS_fnc_3DENNotification;
};

{
    _x params["_side","_sideName","_sideDescription","_color"];
    
    private _platoons = []; // Store as an array instead of a hashmap

    private _allGroups = groups _side; 
    {
        private _group = _x; 
        private _groupName = groupId _group; 
        private _groups = []; 
        private _slots = []; 
        private _firstUnit = (units _group) select 0; 
        private _firstUnitDescription = (_firstUnit get3DENAttribute "description") select 0;
        _firstUnitDescription splitString "@" params ["", ["_CBAGroupTag", ""]]; 

        if (_CBAGroupTag != "") then { 
            _groupName = _CBAGroupTag; 
        }; 

        private _platoonName = _groupName; // Default to group name
         
        // Extract platoon name (all characters before the number in the group name)
        private _platoonMatch = (_groupName regexFind ["^[^\d]+"]) select 0 select 0 select 0;
        _platoonName = toLower trim _platoonMatch; // Normalize platoon name

        if (_platoonName isEqualTo "") then { 
            _platoonName = "UnknownPlatoon"; 
        };

        private _units = playableUnits select {group _x == _group}; 
        {
            private _unit = _x; 
            private _role = (_unit get3DENAttribute "description") select 0; 
            private _unitEventDescription = (_unit get3DENAttribute QGVAR(unitAdditionalDescription)) select 0; 
            _role splitString "@" params [["_unitName", ""], ""]; 

            if (_unitName isEqualTo "") then { 
                _role = getText ((configOf _unit) >> "displayName"); 
                private _error = ("Error: " + str _side + " " + str _unit + " (" + _role + "), role description is empty"); 
                _lolFail pushBack _error; 
            }; 

            _slots pushBack createHashMapFromArray [ 
                ["SlotName", _unitName],
                ["SlotDescription", _unitEventDescription] 
            ];
        } forEach _units; 

        if (count _slots > 0) then {
            private _groupDescription = (_group get3DENAttribute QGVAR(groupAdditionalDescription)) select 0; 
            _groups pushBack createHashMapFromArray [ 
                ["GroupName", _groupName],
                ["GroupDescription", _groupDescription],
                ["Slots", _slots] 
            ];

            if (_CBAGroupTag == "") then { 
                private _error = ("Error: " + str _side + " " + _groupName + ", CBA group tag is missing"); 
                _lolFail pushBack _error; 
            }; 
        };

        if (count _groups > 0) then {
            private _existingPlatoon = _platoons select {_x get "PlatoonName" == _platoonName};
            if (count _existingPlatoon > 0) then {
                // Append groups to existing platoon
                private _existingGroups = (_existingPlatoon select 0) get "Groups";
                _existingGroups append _groups;
            } else {
                // Create new platoon entry
                private _platoonDescription = (_group get3DENAttribute QGVAR(platoonAdditionalDescription)) select 0; 
                _platoons pushBack createHashMapFromArray [
                    ["PlatoonName", _platoonName],
                    ["PlatoonDescription", _platoonName],
                    ["Groups", _groups]
                ];
            }
        };
    } forEach _allGroups; 

    if (count _platoons > 0) then {
        private _returnVehicles = [_side,_allVehicles] call FUNC(getSideVehicles);
        private _sideVehicles = _returnVehicles select 0;
        _allVehicles = _returnVehicles select 1;
        

        _sideData pushBack createHashMapFromArray [ 
            ["SideName", _sideName],
            ["SideDescription", _sideDescription],
            ["SideColor", _color],
            ["Platoons", _platoons],
            ["SideVehicles", _sideVehicles]
        ]; 
    }; 
} forEach _sideAtributes; 

if (count _lolFail > 0) then { 
    _sideData = _lolFail; 

    private _message = "ERRORS COPIED TO CLIPBOARD!<br/>"; 
    {_message = _message + _x + "<br/>";} forEach _lolFail; 
    [_message, 1, 12] call BIS_fnc_3DENNotification; 
} else {
    ["Orbat data copied to clipboard!",0,12] call BIS_fnc_3DENNotification;
}; 

private _json = toJSON _sideData; 
forceUnicode 1;
copyToClipboard _json;

true

