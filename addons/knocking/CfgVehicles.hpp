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
