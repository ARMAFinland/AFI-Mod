/*
	Author: Bummeri <@Armafinland.fi>

	Description:
	Update a single units AI sub skills. Also applies fleeing setting. Unit must be local or this has to be ran from the server. Respects Default behaviour setting in CBA settings menu.

	Parameter(s):
	0: Unit - The unit whose subskills should be updated.
	1: Skill preset (optional) - You can use this parameter to override the skill preset previously assigned to the unit.

	Returns:
	Bool - True when done
*/
params [["_unit",objNull,[objNull]],["_skillPreset","",[""]]];
private _skillClasses = afi_aiSettings_skillClasses;
private _updateEveryUnit = afi_aiSkillPreset_defaultBehaviour;

if (_skillPreset == "") then {
	if (_updateEveryUnit) then {
			_skillPreset = _unit getVariable ["afi_aiSkillPreset", "Regular"];
		} else {
			_skillPreset = _unit getVariable ["afi_aiSkillPreset", "NA"];
		};
};

if (_skillPreset != "NA" && {!isPlayer [_unit]}) then {
	{
		private _skillname = _x;
		private _skillVariableName = ["afi_aiSkillPreset",_skillPreset,_skillname] joinString "_";
		private _skillVariableValue = call compile _skillVariableName;

		if (_skillname == "allowFleeing") then {
			[{cba_missiontime > 1}, {
				_this remoteExecCall ["allowFleeing", _this select 0]
			}, [_unit,_skillVariableValue]] call CBA_fnc_waitUntilAndExecute;
		} else {
			if (local _unit) then {
				_unit setSkill [_skillname,_skillVariableValue];
			} else {
				[_unit,[_skillname,_skillVariableValue]] remoteExecCall ["setSkill", _unit];
			};
		};
		//diag_log format ["aiSettings debug _unit=%1 _skillPreset=%2 _skillname:%3 _skillVariableName:%4 _skillVariableValue:%5",_unit, _skillPreset, _skillname, _skillVariableName, _skillVariableValue];

	} forEach _skillClasses;
	_unit setVariable ["afi_aiSkillPreset",_skillPreset];
	true
} else {
	false
};
