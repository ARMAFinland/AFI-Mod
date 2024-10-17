#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
    class ADDON {
        name = COMPONENT_NAME;
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {MAIN_ADDON_STR,"tem_ihantalaw"};
        author = "Tuntematon";
        VERSION_CONFIG;
        skipWhenMissingDependencies = 1;
    };
};

class CfgWorlds {
    class CAWorld;
    class tem_ihantalaw: CAWorld {
        class RainParticles {
			snow = 1;
        };
    };
};