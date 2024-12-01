#include "script_component.hpp"

[{!isNil QEGVAR(safeStart,timer)}, {
    [] call afi_safestart_fnc_start;
}] call CBA_fnc_waitUntilAndExecute;

true