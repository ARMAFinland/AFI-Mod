#include "\z\ace\addons\main\script_macros.hpp"

#ifdef DISABLE_COMPILE_CACHE
	#undef PREP
	#define PREP(fncName) DFUNC(fncName) = compile preprocessFileLineNumbers QPATHTOF(functions\DOUBLES(fnc,fncName).sqf)
#else
	#undef PREP
	#define PREP(fncName) [QPATHTOF(functions\DOUBLES(fnc,fncName).sqf), QFUNC(fncName)] call CBA_fnc_compileFunction
#endif

#define GITHUBLINK				"https://github.com/ARMAFinland/AFI-Mod"
#define MAIN_ADDON_STR			QUOTE(MAIN_ADDON)

//This forces debug on everything.
//#define DEBUG_ENABLED_MAIN
