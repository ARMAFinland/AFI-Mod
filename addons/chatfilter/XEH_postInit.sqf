#include "script_component.hpp"

addMissionEventHandler ["HandleChatMessage", {
	params ["_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", "_forcedDisplay", "_isPlayerMessage", "_sentenceType", "_chatMessageType", "_params"];
	private _block = false;

	if ((_chatMessageType isEqualTo 2 || _channel isEqualTo 16) && {cba_missionTime > 0} && {GVAR(disableSystemChat)} && {isMultiplayer}) then {
		_block = true;
		private _text = "Message blocked: " + _text;
		LOG(_text);
		TRACE_2("",_chatMessageType,_channel);
	};

	_block
}];


["toggleChat", {
    GVAR(disableSystemChat) = !GVAR(disableSystemChat);

	switch (GVAR(disableSystemChat)) do {
		case true: { 
			player sideChat "Chat filter is ON";
		};
		case false: { 
			player sideChat "Chat filter is OFF";
		};
	};
}, "admin"] call CBA_fnc_registerChatCommand;