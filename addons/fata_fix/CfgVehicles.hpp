class CBA_Extended_EventHandlers;
class CfgVehicles {
	class House;
	class Logic;
	class PRAA_module_tunnels: Logic
	{
		displayName = "PR: Tunnels module";
		icon = "\ca\ui\data\icon_HC_ca.paa";
		picture = "\ca\ui\data\icon_HC_ca.paa";
		vehicleClass = "Modules";
		class Eventhandlers
		{
			init = "if (isNil 'PRAA_tunnels_init') then {PRAA_tunnels_init = true; _this execVM '\praa\praa_tunnels\scripts\init.sqf';};";
			class CBA_Extended_EventHandlers: CBA_Extended_EventHandlers {};
		};
	};
};