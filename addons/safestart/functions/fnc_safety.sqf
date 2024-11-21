#include "script_component.hpp"

params ["_bool", "_unit"];

switch (_bool) do {
	//safestart on
	case true: {
		if(isNil QGVAR(firedIdx)) then {
			//Delete bullets from fired weapons
			
			GVAR(pfeh) = [{ player setVariable ["ace_advanced_throwing_lastThrownTime", 99999999];}] call CBA_fnc_addPerFrameHandler;
			
			GVAR(firedIdx) = _unit addEventHandler["FiredMan", {deleteVehicle (_this select 6);}];
			_unit allowDamage false;
		};
	};
	
	//safestart off
	case false: {
		if (!(isNil QGVAR(firedIdx))) then {
			//Allow unit to fire weapons
			[GVAR(pfeh)] call CBA_fnc_removePerFrameHandler;
			
			player setVariable ["ace_advanced_throwing_lastThrownTime", -1];
			
			_unit removeEventHandler ["FiredMan", GVAR(firedIdx)];
			_unit allowDamage true;
	
			GVAR(firedIdx) = nil;
		};
	};
};

GVAR(safetyEnabled) = _bool;