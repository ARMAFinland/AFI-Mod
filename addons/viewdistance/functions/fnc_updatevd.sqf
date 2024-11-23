#include "script_component.hpp"

params ["_viewDistance"];

GVAR(current) = _viewDistance;

setViewDistance _viewDistance;
setObjectViewDistance _viewDistance;

if (!isMultiplayer) then {
	hintSilent parseText format ["<t align='left'>View Distance: %1%2 (%3m)</t>", round (_viewDistance / GVAR(max) * 100), "%", _viewDistance];
} else {
	hintSilent parseText format ["<t align='left'>View Distance: %1%2</t>", round (_viewDistance / GVAR(max) * 100), "%"];
};

profileNamespace setVariable [QGVAR(current), _viewDistance];