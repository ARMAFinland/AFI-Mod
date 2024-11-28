#define COMPONENT engine_delay
#define COMPONENT_BEAUTIFIED engine_delay
#include "\x\afi\addons\main\script_mod.hpp"

#define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_MAIN
	#define DEBUG_MODE_FULL
#endif

#include "\x\afi\addons\main\script_macros.hpp"


#define TUN_SKIP_PAUSED		private _hashMap = GVAR(pfhUpdateTimes); \
							private _value = _hashMap getOrDefault [_handle, 0, true]; \
							if (_value isEqualTo cba_missiontime) exitWith { }; \
							_hashMap set [_handle, cba_missiontime]


#define TUN_DELETE_PAUSE_SKIP	GVAR(pfhUpdateTimes) deleteAt _handle