class Extended_PreStart_EventHandlers {
	class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_preStart));
	};
};

class Extended_PreInit_EventHandlers {
	class ADDON {
		init = QUOTE(call COMPILE_FILE(XEH_preInit));
		serverInit = QUOTE(call COMPILE_FILE(XEH_preInit_server));
	};
};

class Extended_Engine_EventHandlers {
	class AllVehicles {
		class ADDON {
			clientEngine = QUOTE(if (local driver (_this select 0)) then {_this call FUNC(preventMovingVehicle)};);
			serverEngine = QUOTE(_this call FUNC(serverEngineStart));
		};
	};
};