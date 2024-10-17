#include "script_component.hpp"
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {MAIN_ADDON_STR};
        author = "Tuntematon";
        authorUrl = GITHUBLINK;
        VERSION_CONFIG;
    };
};
// configs go here
#include "CfgEventHandlers.hpp"

class GVAR(baseAceKnocking) {
	displayName = "Knock";
	condition = QUOTE(_this call FUNC(knockingConditio));
	statement = QUOTE(_this call FUNC(knockOnTank));
	priority = 1;
	distance = 4.5;
	icon = QPATHTOF(ui\knock.paa);
};

class CfgVehicles {
	class LandVehicle;
	class Air;
	class Tank: LandVehicle {
		class ACE_Actions {
			class ACE_MainActions {
				class GVAR(knockOnVehicle) : GVAR(baseAceKnocking) {

				};
			};
		};
	};
	class Car: LandVehicle {
		class ACE_Actions {
			class ACE_MainActions {
				class GVAR(knockOnVehicle) : GVAR(baseAceKnocking) {

				};
			};
		};
	};
	class Helicopter: Air {
		class ACE_Actions {
			class ACE_MainActions {
				class GVAR(knockOnVehicle) : GVAR(baseAceKnocking) {
					
				};
			};
		};
	};
	class Plane: Air {
		class ACE_Actions {
			class ACE_MainActions {
				class GVAR(knockOnVehicle) : GVAR(baseAceKnocking) {
					
				};
			};
		};
	};
};

class CfgSounds {
	sounds[] = {QGVAR(knockMetal),QGVAR(knockMetalInside)};
	class GVAR(knockMetal) {
		name = QGVAR(knockMetal);
		sound[] = {QPATHTOF(sounds\knockMetal.ogg),25,1,25};
		titles[] = {};
	};
	class GVAR(knockMetalInside) {
		name = QGVAR(knockMetalInside);
		sound[] = {QPATHTOF(sounds\knockMetal.ogg),2,1};
		titles[] = {};
	};
};
