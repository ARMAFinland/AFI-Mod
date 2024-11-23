class Extended_PreStart_EventHandlers {
	class ADDON {
		clientInit = QUOTE(call COMPILE_FILE(XEH_preStart_client));
	};
};

class Extended_PreInit_EventHandlers {
	class ADDON {
		clientInit = QUOTE(call COMPILE_FILE(XEH_preInit_client));
	};
};

class Extended_PostInit_EventHandlers {
	class ADDON {
		clientInit = QUOTE(call COMPILE_FILE(XEH_postInit_client));
	};
};
