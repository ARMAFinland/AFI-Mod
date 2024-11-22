private _worldList = configfile >> "CfgWorldList";
private _world = _worldList select 0;
private _i = 0;
private _worlds = [];

while {!isNull _world} do {
	if (isClass (_worldList select _i)) then {
		_world = _worldList select _i;
		private _worldName = str(_world) select [28];
	
		if (isClass (configfile >> "CfgWorlds" >> _worldName)) then {
			if (isNumber (configfile >> "CfgWorlds" >> _worldName >> "access")) then {
				_worlds pushBack [_worldName, getText(configfile >> "CfgWorlds" >> _worldName >> "description")];
			};
		};
	};
	
	_i = _i + 1;
	if (count (_worldList) == _i) exitWith {};
};

_worlds sort true;

_worlds