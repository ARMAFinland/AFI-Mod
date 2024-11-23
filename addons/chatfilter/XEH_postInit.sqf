#include "script_component.hpp"

addMissionEventHandler ["HandleChatMessage", {
	params ["_channel", "_owner", "_from", "_text", "_person", "_name", "_strID", "_forcedDisplay", "_isPlayerMessage", "_sentenceType", "_chatMessageType", "_params"];
	// private _channel = param[0];
	// private _text = param[3];
	private _block = false;

	if ((_chatMessageType isEqualTo 2 || _channel isEqualTo 16) && {cba_missionTime > 0}) then {
		_block = true;
		private _text = "Message blocked: " + _text;
		LOG(_text);
	};

	TRACE_8("",_channel,_owner,_from,_text,_person,_name,_strID,_forcedDisplay);
	TRACE_4("",_isPlayerMessage,_sentenceType,_chatMessageType,_params);

	_block
}];