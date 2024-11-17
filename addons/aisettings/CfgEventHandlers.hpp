class Extended_PreStart_EventHandlers {
	class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_preStart));
	};
};

class Extended_PreInit_EventHandlers {
	class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
	};
};

class Extended_InitPost_EventHandlers {
    class CAManBase {
        class afi_aiSettings_initPost_serverEvent {
            serverinit = QUOTE([_this select 0] call FUNC(updateUnitsAiSkill);); //Update units skills after init.
        };
    };
};