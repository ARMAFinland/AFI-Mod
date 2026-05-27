#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {QGVARMAIN(main),"hellanmaaw"};
		author[] = {"Tuntematon"};
		VERSION_CONFIG;
		skipWhenMissingDependencies = 1;
	};
};

class CfgWorlds {
	class CAWorld;
	class hellanmaaw: CAWorld {
		class RainParticles {
			snow = 1;
		};
	};
};
