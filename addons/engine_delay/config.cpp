#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR,"ace_vehicles","A3_Data_F_Decade_Loadorder","A3_Data_F","A3_Armor_F_Beta","A3_Data_F_ParticleEffects","A3_Soft_F","ace_vehicles","A3_Soft_F_Gamma_Hatchback_01","A3_Soft_F_Exp_Offroad_02","A3_Soft_F_Beta_Truck_01","A3_Soft_F_Beta_Truck_02","A3_Soft_F_Gamma_Truck_01","A3_Soft_F_Gamma_Van_01","A3_Soft_F_EPC_Truck_03","A3_Soft_F_Orange_Van_02","A3_Soft_F_MRAP_01","A3_Soft_F_Exp_MRAP_01","A3_Soft_F_MRAP_02","A3_Soft_F_Beta_MRAP_03","A3_Soft_F_Quadbike_01","A3_Soft_F_Kart_Kart_01","A3_Armor_F_Beta_APC_Wheeled_01","A3_Armor_F_Beta_APC_Wheeled_02","A3_Armor_F_Gamma_APC_Wheeled_03","A3_Armor_F_Tank_AFV_Wheeled_01","A3_Soft_F_Enoch_Tractor_01","A3_Sounds_F_Enoch","A3_Armor_F_Beta_APC_Tracked_01","A3_Armor_F_Beta_APC_Tracked_02","A3_Armor_F_Gamma_MBT_01","A3_Armor_F_Gamma_MBT_02","A3_Armor_F_EPB_APC_Tracked_03","A3_Armor_F_EPB_MBT_03","A3_Armor_F_Tank_LT_01","A3_Armor_F_Tank_MBT_04","A3_Soft_F_Enoch_UGV_02"};
		author = "Tuntematon";
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
		skipWhenMissingDependencies = 1;
	};
};
// configs go here
#include "CfgEventHandlers.hpp"
#include "CfgVehicles.hpp"
