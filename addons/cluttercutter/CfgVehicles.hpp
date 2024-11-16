class CfgVehicles {
	class Man;
	class CAManBase: Man {
		class ACE_SelfActions {
			class ACE_Equipment {
				class AFI_CutterAction {
					displayName = "Remove clutter";
					condition = "isNull objectParent player";
					exceptions[] = {};
					statement = "ace_player playActionNow 'medic'; [4, [], {_obj = createVehicle ['Land_ClutterCutter_medium_F', ace_player, [], 0, 'CAN_COLLIDE'];}, {ace_player playActionNow 'medicstop';}, 'Removing clutter...'] call ace_common_fnc_progressBar";
					icon = QPATHTOF(cutterIcon.paa);
				};
			};
		};
	};
};