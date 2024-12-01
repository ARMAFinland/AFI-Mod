#include "script_component.hpp"
/*
	Author: Bummeri <@Armafinland.fi>

	Description:
	Will assign common settings to the mission in eden editor.

	Parameter(s):
	none

	Returns:
	Bool - True when done
*/
params["_type"];

switch (_type) do {
	case 1: {//Single life
		collect3DENHistory {
			"Multiplayer" set3DENMissionAttribute ["DisabledAI",true];
			"Multiplayer" set3DENMissionAttribute ["JoinUnassigned",true];
			"Multiplayer" set3DENMissionAttribute ["Respawn",1];
			"Multiplayer" set3DENMissionAttribute ["RespawnDelay",0];
			"Multiplayer" set3DENMissionAttribute ["RespawnDialog",false];
			"Multiplayer" set3DENMissionAttribute ["EnableTeamSwitch",true];
			"Multiplayer" set3DENMissionAttribute ["AIKills",false];
			"Multiplayer" set3DENMissionAttribute ["RespawnButton",1];
			"Multiplayer" set3DENMissionAttribute ["RespawnTemplates",["ace_spectator"]];
			"Multiplayer" set3DENMissionAttribute ["SharedObjectives",0];
			"Multiplayer" set3DENMissionAttribute ["ReviveMode",0];
			"Scenario" set3DENMissionAttribute ["Briefing",true];
			"Scenario" set3DENMissionAttribute ["Debriefing",true];
			"Scenario" set3DENMissionAttribute ["Saving",false];
			"Scenario" set3DENMissionAttribute ["ShowMap",true];
			"Scenario" set3DENMissionAttribute ["ShowCompass",true];
			"Scenario" set3DENMissionAttribute ["ShowWatch",true];
			"Scenario" set3DENMissionAttribute ["ShowGPS",true];
			"Scenario" set3DENMissionAttribute ["ShowHUD",true];
			"Scenario" set3DENMissionAttribute ["ShowUAVFeed",true];
			"Scenario" set3DENMissionAttribute ["ForceRotorLibSimulation",false];
			"Scenario" set3DENMissionAttribute ["EnableTargetDebug",1];
			"Scenario" set3DENMissionAttribute ["EnableDebugConsole", 1];
			"Scenario" set3DENMissionAttribute ["SaveBinarized",false];
			QGVAR(missionAttributes) set3DENMissionAttribute [QGVAR(viewdistance),3000];
			QGVAR(missionAttributes) set3DENMissionAttribute [QGVAR(enableViewdistance),true];
			QGVAR(missionAttributes) set3DENMissionAttribute [QGVAR(enableSafeStart),true];
			QGVAR(missionAttributes) set3DENMissionAttribute [QGVAR(safeStartLength),15];
			["Mission settings have been modified to basic single-life settings: 15-minute SafeStart enabled, 3 km view distance limit enabled.",0,9] call BIS_fnc_3DENNotification;
		};
	};
	case 2: {//Respawn
		collect3DENHistory {
			"Multiplayer" set3DENMissionAttribute ["DisabledAI",true];
			"Multiplayer" set3DENMissionAttribute ["JoinUnassigned",true];
			"Multiplayer" set3DENMissionAttribute ["Respawn",3];
			"Multiplayer" set3DENMissionAttribute ["RespawnDelay",9999999];
			"Multiplayer" set3DENMissionAttribute ["RespawnDialog",false];
			"Multiplayer" set3DENMissionAttribute ["EnableTeamSwitch",true];
			"Multiplayer" set3DENMissionAttribute ["AIKills",false];
			"Multiplayer" set3DENMissionAttribute ["RespawnButton",1];
			"Multiplayer" set3DENMissionAttribute ["RespawnTemplates",[]];
			"Multiplayer" set3DENMissionAttribute ["SharedObjectives",0];
			"Multiplayer" set3DENMissionAttribute ["ReviveMode",0];
			"Scenario" set3DENMissionAttribute ["Briefing",true];
			"Scenario" set3DENMissionAttribute ["Debriefing",true];
			"Scenario" set3DENMissionAttribute ["Saving",false];
			"Scenario" set3DENMissionAttribute ["ShowMap",true];
			"Scenario" set3DENMissionAttribute ["ShowCompass",true];
			"Scenario" set3DENMissionAttribute ["ShowWatch",true];
			"Scenario" set3DENMissionAttribute ["ShowGPS",true];
			"Scenario" set3DENMissionAttribute ["ShowHUD",true];
			"Scenario" set3DENMissionAttribute ["ShowUAVFeed",true];
			"Scenario" set3DENMissionAttribute ["ForceRotorLibSimulation",false];
			"Scenario" set3DENMissionAttribute ["EnableTargetDebug",1];
			"Scenario" set3DENMissionAttribute ["EnableDebugConsole", 1];
			"Scenario" set3DENMissionAttribute ["SaveBinarized",false];
			QGVAR(missionAttributes) set3DENMissionAttribute [QGVAR(viewdistance),3000];
			QGVAR(missionAttributes) set3DENMissionAttribute [QGVAR(enableViewdistance),true];
			QGVAR(missionAttributes) set3DENMissionAttribute [QGVAR(enableSafeStart),true];
			QGVAR(missionAttributes) set3DENMissionAttribute [QGVAR(safeStartLength),15];
			["Mission settings have been modified to basic respawn settings: 15-minute SafeStart enabled, 3 km view distance limit enabled.",0,9] call BIS_fnc_3DENNotification;
		};
	};
};

true
