/*
 * Author: [Tuntematon]
 * [Description]
 * Do very bad mission debug thing from 30.10.2018
 * Arguments:
 * None
 *
 * Return Value:
 * None
 *
 * Example:
 * [] call afi_missiondebug_fnc_missiondebug
 */
#include "script_component.hpp"

// if (isServer) then {
// 	publicVariable "afi_jip_allowed";
// 	publicVariable "afi_jip_time";
// };

player createDiarySubject ["DebugScript","Mission Debug"];

private _radioCountEast = 0;
private _radioCountWest = 0;
private _radioCountResistance = 0;
private _radioCountCiv = 0;


private _Tun_fnc_DebugVari = {
	params ["_numero"];
	private _vari = switch (true) do {
		case ( 5 >= _numero && 4 < _numero ): {'#E30000'};
		case ( 4 >= _numero && 3 < _numero ): {'#E46F00'};
		case ( 3 >= _numero && 2 < _numero ): {'#E6DE00'};
		case ( 2 >= _numero && 1 < _numero ): {'#7ED200'};
		default {'#17C700'};
	};
	_vari
};



//INFANTRY///
{
	private _unit = _x;
	if (side _unit != sideLogic && !(_unit getVariable ["Skip_Debug",false])) then {
		
		private _unitErrorList = [];
		private _hasLR = false;

		private _primaryWeapon = primaryWeapon _unit;
		private _secondaryWeapon = secondaryWeapon _unit;
		private _handgunWeapon= handgunWeapon _unit;

		private _compatible_primary_mags = [_primaryWeapon] call CBA_fnc_compatibleMagazines;
		private _compatible_primary_secondary_mags = [_primaryWeapon, true] call CBA_fnc_compatibleMagazines;
		_compatible_primary_secondary_mags = _compatible_primary_secondary_mags - _compatible_primary_mags - ["rhs_mag_fold_stock"];
		private _compatible_secondary_mags = [_secondaryWeapon] call CBA_fnc_compatibleMagazines;
		private _compatible_handgun_mags = [_handgunWeapon] call CBA_fnc_compatibleMagazines;

		private _allMagazines = magazines _unit + primaryWeaponMagazine _unit + secondaryWeaponMagazine _unit + handgunMagazine _unit;

		private _primary_mag_count = { _x in _compatible_primary_mags } count _allMagazines;
		private _primary_secondary_mag_count = { _x in _compatible_primary_secondary_mags } count _allMagazines;
		private _secondary_mag_count = { _x in _compatible_secondary_mags } count _allMagazines;
		private _handgun_mag_count = { _x in _compatible_handgun_mags } count _allMagazines;

		private _noWeapons = false;
		private _noPrimary = (_primaryWeapon == "");
		private _noHandgun = (_handgunWeapon == "");
		private _noSecondary = (_secondaryWeapon == "");


		if ( _noPrimary && _noHandgun && _noSecondary ) then {

			private _color = [5] call _Tun_fnc_DebugVari;

			_unitErrorList pushBack format ["<br/>--  <font color='%1'> Unit dont have any weapons!</font>",_color ];
			_noWeapons = true;
		};

		//primary weapon stuff

		if (_noPrimary && { !_noHandgun } ) then {

			private _color = [1] call _Tun_fnc_DebugVari;

			_unitErrorList pushBack format ["<br/>--  <font color='%1'> Unit have handgun but no primary weapon </font>", _color ];
		};

		if (!_noPrimary && { _primary_mag_count <= 5  }) then {

			private _color = [(5 - _primary_mag_count)] call _Tun_fnc_DebugVari;

			_unitErrorList pushBack format ["<br/>--  <font color='%1'> Unit has only %2 magazines for its primary weapon(%3)</font>",_color, _primary_mag_count, _primaryweapon ];
		};


		if (!_noPrimary && { _primary_secondary_mag_count <= 5 } && { count _compatible_primary_secondary_mags > 0 } ) then {

			private _color = [(5 - _primary_secondary_mag_count)] call _Tun_fnc_DebugVari;

			_unitErrorList pushBack format ["<br/>--  <font color='%1'> Unit only have %2 secondary muzzle magazines (UGL etc.) for its primary weapon(%3)</font>",_color, _primary_secondary_mag_count, _primaryweapon ];
		};

		
		//Handgun
		if ( _handgun_mag_count <= 0 && { !_noHandgun } ) then {

			private _color = [0] call _Tun_fnc_DebugVari;

			_unitErrorList pushBack format ["<br/>--  <font color='%1'> Unit have no magazines for its hadngun weapon(%2)</font>",_color, _handgunWeapon];
		};

		//Secondary/launcher
		if ( !_noSecondary ) then {
			private _isDisposable = (
				(getText (configFile >> "CFGWeapons" >> _secondaryWeapon >> "displayName") != "") && 
				getNumber (configFile >> "CFGWeapons" >> _secondaryWeapon >> "rhs_disposable") == 0 && 
				getText (configFile >> "CFGWeapons" >> _secondaryWeapon >> "ACE_UsedTube") == "" && 
				(getText (configFile >> "CFGWeapons" >> _secondaryWeapon >> "author") != "FinMod"));
				
			if ( _isDisposable  && { _secondary_mag_count < 2 } ) then {

				private _color = [(5 - _secondary_mag_count)] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'> Unit only have %2 magazines for its secondary/launcher weapon(%3)</font>", _color, _secondary_mag_count, _secondaryWeapon ];
			};
		};


		//Medical 

		private _allItems = items _unit;

		private _isAceMedic = [_unit] call ace_medical_treatment_fnc_isMedic;
		private _bloodBagCount =  { _x in ["ACE_bloodIV", "ACE_bloodIV_500", "ACE_bloodIV_250"] } count _allItems;
		private _medicBandageCount =  { _x in ["ACE_elasticBandage", "ACE_quikclot"] } count _allItems;
		private _bandageCount =  { _x == "ACE_packingBandage" } count _allItems;
		private _epinephrineCount =  { _x ==  "ACE_epinephrine" } count _allItems;
		private _morphineCount =  { _x ==  "ACE_morphine" } count _allItems;
		private _painkillersCount =  { _x ==  "ACE_painkillers" } count _allItems;
		private _adenosineCount =  { _x ==  "ACE_adenosine" } count _allItems;
		private _tourniquetCount =  { _x ==  "ACE_tourniquet" } count _allItems;
		private _splintCount =  { _x in  ["ACE_splint", "adv_aceSplint_splint"] } count _allItems;
		private _fakeSplintCount =  { _x ==  "adv_aceSplint_splint" } count _allItems;
		private _haveSurgigaclKit = "ACE_surgicalKit" in _allItems;

		if (_isAceMedic) then {
			
			if (_bloodBagCount < 10) then {

				private _color = [5 - round(_bloodBagCount / 2)] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'> ACE Medic Unit only have %2 bloodBags  (CLS needs none)</font>", _color, _bloodBagCount];
			};

			if ( (_medicBandageCount + _bandageCount) <= 15) then {
				private _color = [ceil (15 / 2) - ceil (15 / 2)] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'> ACE Medic Unit only have %2 Bandages</font>", _color,_medicBandageCount];
			};

			if (_epinephrineCount <= 5) then {
				private _color = [5 - _epinephrineCount + 2] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'> ACE Medic Unit only have %2 Epinephrine auto injector (CLS need only about 2-3)</font>", _color, _epinephrineCount];
			};
			
			if (_morphineCount <= 5) then {
				private _color = [7 - _morphineCount + 2] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'> ACE Medic Unit only have %2 Morphine auto injector (CLS need only about 2-3)</font>", _color, _morphineCount];
			};
			
			if (_adenosineCount <= 2) then {
				private _color = [5 - _adenosineCount + 2] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'> ACE Medic Unit only have %2 Adenosine auto injector (CLS needs less)</font>", _color, _adenosineCount];
			};
			
			if (_tourniquetCount <= 3) then {
				private _color = [5 - _tourniquetCount] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'> ACE Medic Unit only have %2 Tourniquet (CAT)</font>", _color, _tourniquetCount];
			};
			
			if (_splintCount <= 3) then {
				private _color = [5 - _splintCount] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'> ACE Medic Unit only have %2 Splints</font>", _color, _splintCount];
			};
			
			if !(_haveSurgigaclKit) then {
				private _color = [5] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'> ACE Medic Unit dont have Surgical Kit (CLS dont need it)</font>", _color];
			};

		} else {
			if (_bloodBagCount > 0) then {

				private _color = [1] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'> Unit is not ACE medic, but have bloodbags</font>", _color];
			};

			if (_medicBandageCount  > 0 && _bandageCount == 0) then {
				private _color = [1] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'>Unit is not ACE medic, but only have medic bandages (ACE_elasticBandage, ACE_quikclot)</font>", _color];
			};
			
			if (_bandageCount < 6) then {
				private _color = [5 - _bandageCount] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'>Unit only have %2 regular bandages (ACE_packingBandage)</font>", _color, _bandageCount];
			};

			// if (_epinephrineCount  > 0) then {
			// 	private _color = [1] call _Tun_fnc_DebugVari;

			// 	_unitErrorList pushBack format ["<br/>--  <font color='%1'>Unit is not ACE medic, but have epipherin</font>", _color];
			// };
			
			if ((_morphineCount + _painkillersCount) < 1) then {
				private _color = [4] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'>Unit dont have any Morphine or painkillers</font>", _color];
			};
			
			// if (_adenosineCount  > 0) then {
			// 	private _color = [1] call _Tun_fnc_DebugVari;

			// 	_unitErrorList pushBack format ["<br/>--  <font color='%1'>Unit is not ACE medic, but have Adenosine auto injector</font>", _color];
			// };
			
			if (_tourniquetCount < 1) then {
				private _color = [2] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'>Unit only have %2 Tourniquet (CAT)</font>", _color, _tourniquetCount];
			};
			
			if (_splintCount  < 1) then {
				private _color = [4] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'>Unit dont have any Tourniquets (CAT)</font>", _color];
			};
			
			if (_haveSurgigaclKit) then {
				private _color = [1] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'>Unit is not ACE medic, but have Surgical Kit</font>", _color];
			};
		};

		//Right radio codec
		if (backpack _unit != "" ) then {
			if (isMultiplayer) then {
				private _sideCodec = switch (side _unit) do {
					case east: {
						"tf_east_radio_code"
					};

					case west: {
						"tf_west_radio_code"
					};

					case independent: {
						"tf_independent_radio_code"
					};

					case civilian: {
						"tf_independent_radio_code"
					};

					default {
						/* STATEMENT */
					};
				};

				private _radioCodec = toLower getText (configFile >> "CfgVehicles" >> backpack _unit >> "tf_encryptionCode");
				
				if (_radioCodec != "") then {
					_hasLR = true;
					if ( _radioCodec !=  _sideCodec ) then {
						private _color = [5] call _Tun_fnc_DebugVari;

						_unitErrorList pushBack format ["<br/>--  <font color='%1'>Unit have wrong codec for LR radio (Side Codec = %2, LR codec = %3)</font>", _color, _sideCodec, _radioCodec];
					};
				};
			};
		};

		if ((damage _unit != 0)) then {
			private _color = [5] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'>Unit has taken damage</font>", _color];
		};

		if ( isMultiplayer &&
			{ leader group _unit == _unit } &&
			{ (str(group _unit) select [2] != roleDescription _unit select [((roleDescription _unit find "@")+1)]) } 
			) then {
				private _color = [3] call _Tun_fnc_DebugVari;
			
			switch (((roleDescription _unit find "@")+1)) do {
				case "0": { 
					_unitErrorList pushBack format ["<br/>--  <font color='%1'>CBA slotting groupID is not set. (Add group leaders descriptin @ and group id. ie. @Alpha 1)</font>", _color];
				};
				default { 
					_unitErrorList pushBack format ["<br/>--  <font color='%1'>GroupID is not same as CBA slotting groupID</font>", _color];
				};
			};
			
		};
		
		if ( isMultiplayer ) then {
			if !(count (_unit call TFAR_fnc_radiosListSorted) == 0 && assignedItems _unit find "ItemRadio" == -1) then {
				switch (side _unit) do {
					case east: {
						INC(_radioCountEast);
					};

					case west: {
						INC(_radioCountWest);
					};

					case resistance: {
						INC(_radioCountResistance);
					};

					default {
						INC(_radioCountCiv);
					};
				};
			};
		};
		
		if (_unitErrorList isNotEqualTo []) then {

			private _roleDescription = roleDescription _unit;
			if (_roleDescription == "") then {
				_roleDescription = getText ((configOf _unit) >> "displayName");
			};
			private _finalText = "";

			{
				_finalText = format["%1%2", _finalText, _x];
				//player createDiaryRecord ["DebugScript", ["Infantry Errors", _x ]];
			} forEach _unitErrorList;

			//player createDiaryRecord ["DebugScript", ["Infantry Errors", _finalText ]];
			player createDiaryRecord ["DebugScript", ["Infantry Errors", format ["<br/><br/>%1 (%3)<br/>%2%4", group _unit, _roleDescription, side _unit, _finalText] ]];
		};



		private _isAceEOD = [_unit] call ace_common_fnc_isEOD;
		private _isAceEngineer = [_unit] call ace_repair_fnc_isEngineer;

		private _displayname = format["%1  %2", getText ((configOf _unit) >> "displayName"), roleDescription _unit];

		private _primaryMagText = _primary_mag_count;
		if (_primary_secondary_mag_count > 0) then {
			_primaryMagText = format ["%1 - (UGL %2)",_primary_mag_count, _primary_secondary_mag_count ];
		};

		private _haveSquadRadio = "not supported in SP";
		if ( isMultiplayer ) then {
			_haveSquadRadio = (count (_unit call TFAR_fnc_radiosListSorted) != 0 || assignedItems _unit find "ItemRadio" != -1);
		};
		



		//luodaan yksikön yhteenveto

	// 	player createDiaryRecord ["DebugScript", [ str(group _unit), format ["<font color='#66FF33'>%1</font>:
	// 	<br/><font color='#CCFFFF'>Primary Weapon</font>: (%2 %3)
	// 	<br/><font color='#CCFFFF'>Handgun Weapon</font>: (%4 %5)
	// 	<br/><font color='#CCFFFF'>Secondary Weapon</font>: (%6 %7)
	// 	<br/><font color='#CCFFFF'>Is ACE Medic</font>: %8
	// 	<br/><font color='#CCFFFF'>Is ACE Engineer</font>: %9
	// 	<br/><font color='#CCFFFF'>Is ACE EOD</font>: %10
	// 	<br/><font color='#CCFFFF'>Basic Bandages</font>: %11
	// 	<br/><font color='#CCFFFF'>Medic Bandages</font>: %17
	// 	<br/><font color='#CCFFFF'>Morphine</font>: %12
	// 	<br/><font color='#CCFFFF'>Epinephrine</font>: %13
	// 	<br/><font color='#CCFFFF'>Adenosine</font>: %18
	// 	<br/><font color='#CCFFFF'>Blood Bags</font>: %14
	// 	<br/><font color='#CCFFFF'>SR radio</font>: %15
	// 	<br/><font color='#CCFFFF'>LR radio</font>: %16
	// 	",
	// 		_displayname,
	// 		_primaryWeapon,
	// 		_primaryMagText,
	// 		_handgunWeapon,
	// 		_handgun_mag_count,
	// 		_secondaryWeapon,
	// 		_secondary_mag_count,
	// 		_isAceMedic,
	// 		_isAceEngineer,
	// 		_isAceEOD,
	// 		_bandageCount,
	// 		_morphineCount,
	// 		_epinephrineCount,
	// 		_bloodBagCount,
	// 		_haveSquadRadio,
	// 		_hasLR,
	// 		_medicBandageCount,
	// 		_adenosineCount
	// 		]]];

	};
} forEach ( [switchableUnits, playableUnits] select isMultiplayer );



/////////////
//VEHICLES!//
/////////////
{
	private _unit = _x;
	private _unitErrorList = [];
	if (
		!(_unit getVariable ["Skip_Debug",false]) &&
		_unit isKindOf "LandVehicle" ||
		_unit isKindOf "Air" ||
		_unit isKindOf "Ship" ||
		_unit isKindOf "Static" ||
		(_unit isKindOf "thing") &&
		( getNumber ((configOf _unit) >> "transportMaxMagazines") != 0) && 
		!(typeOf _x in ["ACE_friesAnchorBar","WeaponHolderSimulated"])
	) then {
		private _isLocked = (2 <= locked _unit);
		private _vehicleGearVarSet = (_unit getVariable ["AFI_vehicle_gear","nope"] != "nope");
		if (!_isLocked && _vehicleGearVarSet) then {

			if !(_vehicleGearVarSet) then {
				private _color = [5] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'>AFI_vehicle_gear is not defined. (it is not going to show in AFI Equipment in briefing)</font>", _color];
			};

			if (_isLocked) then {
				private _color = [2] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'>Vehicle is locked</font>", _color];
			};

			private _tfarVehSide = toLower str ((vehicle _unit) call TFAR_fnc_getVehicleSide);
			if (!_vehicleGearVarSet && isMultiplayer) then {
					private _side = toLower (_unit getVariable "AFI_vehicle_gear");
					if (
						((vehicle _unit) call TFAR_fnc_hasVehicleRadio) &&
						{(_side != _tfarVehSide)}
						) then {

							private _color = [5] call _Tun_fnc_DebugVari;

							_unitErrorList pushBack format ["<br/>--  <font color='%1'>Vehicle radio codec is wrong (Vehicle radio side = %2, Vehicle side = %3)</font>",_color, _tfarVehSide, _side];
					};
				};

			if (damage _unit != 0) then {

				private _color = [4] call _Tun_fnc_DebugVari;

				_unitErrorList pushBack format ["<br/>--  <font color='%1'>Vehicle has taken damage</font>", _tfarVehSide];
			};
		} else {
			private _color = [0] call _Tun_fnc_DebugVari;

			_unitErrorList pushBack format ["<br/>--  <font color='%1'>Vehicle is locked and AFI_vehicle_gear not defined. Asuming vehicle is not important and not running full debug for it. </font>", _color];
		};

	};
	
	if (_unitErrorList isNotEqualTo []) then {

		private _debugMarker = "Debugmerkki_" + str(_forEachIndex);
		private _marker = createMarkerLocal [_debugMarker, (position _unit)];

		private _vehicleSide = _unit getVariable ["AFI_vehicle_gear", "Side not set"];

		private _vehicleName = getText ((configOf _unit) >> "displayName");

		

		{
			player createDiaryRecord ["DebugScript", ["Vehicle Errors", _x]];
		} forEach _unitErrorList;

		player createDiaryRecord ["DebugScript", ["Vehicle Errors", format ["<br/><br/><marker name='%2'>%1 (%3)</marker>", _vehicleName, _marker, _vehicleSide] ]];
	};		

} forEach vehicles;


private _unitErrorList = [];
private _spectatorSlotCount = {typeOf _x == "ace_spectator_virtual"} count allMissionObjects "ALL";

if (_spectatorSlotCount < 40) then {
	private _color = [3] call _Tun_fnc_DebugVari;

	_unitErrorList pushBack format ["<br/>--  <font color='%1'>There is only %2 ACE spectator slots</font>", _color, _spectatorSlotCount];
};


private _respawnEnabled = !(getMissionConfigValue ["respawn",999] in [1]);

if (_respawnEnabled) then {
	private _color = [1] call _Tun_fnc_DebugVari;

	_unitErrorList pushBack format ["<br/>--  <font color='%1'>Respawn enabled in mission.</font>", _color];
};



if !("ace_spectator" in getMissionConfigValue ["respawnTemplates",["ei"]]) then {
	private _color = [5] call _Tun_fnc_DebugVari;

	_unitErrorList pushBack format ["<br/>--  <font color='%1'>Mission is not using ACE spectator</font>", _color];
};

if (getMissionConfigValue ["enableDebugConsole",999] != 1) then {
	private _color = [5] call _Tun_fnc_DebugVari;

	_unitErrorList pushBack format ["<br/>--  <font color='%1'>Mission is not using deubug console</font>", _color];
};

if (getMissionConfigValue ["EnableTargetDebug",999] != 1) then {
	private _color = [5] call _Tun_fnc_DebugVari;

	_unitErrorList pushBack format ["<br/>--  <font color='%1'>Mission is not using CBA target deubug console</font>", _color];
};

if (getMissionConfigValue ["disabledAI",999] != 0 && !_respawnEnabled) then {
	private _color = [5] call _Tun_fnc_DebugVari;

	_unitErrorList pushBack format ["<br/>--  <font color='%1'>DisableAI is not set  false / 0</font>", _color];
};


if (!isMultiplayer) then {
	private _color = [5] call _Tun_fnc_DebugVari;
	_unitErrorList pushBack format ["<br/>--  <font color='%1'>TFAR debug doesnt work in SP</font>", _color];	
};


if (fileExists "briefing.sqf") then {
	private _briefing = str compile preprocessFileLineNumbers "briefing.sqf";

	if (_briefing find "side player" != -1) then {
		private _color = [5] call _Tun_fnc_DebugVari;
		_unitErrorList pushBack format ["<br/>--  <font color='%1'>Briefing.sqf is using (side player). this should be changed to (playerside) to avoid problems in JIP</font>", _color];	
	};
};


if (_unitErrorList isNotEqualTo []) then {
	{
		player createDiaryRecord ["DebugScript", ["Mission errors/notes", _x]];
	} forEach _unitErrorList;
};


//random shit
player createDiaryRecord ["DebugScript", ["Main",format ["Alliances:
<br/><font color='#0000CD'>West</font> - <font color='#8B0000'>East</font> = %1
<br/><font color='#0000CD'>West</font> - <font color='#228B22'>Resistance</font> = %2
<br/><font color='#228B22'>Resistance</font> - <font color='#8B0000'>East</font> = %3
<br/>
<br/>
<br/><font color='#CCFFFF'>West Radio Code</font>: %4
<br/><font color='#CCFFFF'>East Radio Code</font>: %5
<br/><font color='#CCFFFF'>Guer Radio Code</font>: %6
<br/>
<br/>%7%8%9
<br/><font color='#CCFFFF'>Enemy vehicles allowed</font>: %14
<br/><font color='#CCFFFF'>Enemy radios allowed</font>: %15
<br/>
<br/>
<br/>Units in sides (All|Player|AI):
<br/><font color='#CCFFFF'>West</font>: %10 - %26 - %30
<br/><font color='#CCFFFF'>East</font>: %11 - %27 - %31
<br/><font color='#CCFFFF'>Resistance</font>: %12 - %28 - %32
<br/><font color='#CCFFFF'>civilian</font>: %13 - %29 - %33
<br/><font color='#CCFFFF'>Spektaslotit</font>: %16
<br/>
<br/>
<br/>SR radio count:
<br/><font color='#CCFFFF'>West</font>: %22
<br/><font color='#CCFFFF'>East</font>: %23
<br/><font color='#CCFFFF'>Resistance</font>: %24
<br/><font color='#CCFFFF'>civilian</font>: %25
<br/>
<br/>
<br/><font color='#CCFFFF'>Respawn Type</font>: %17
<br/><font color='#CCFFFF'>Respawn Templates</font>: %18
<br/><font color='#CCFFFF'>Debug Console</font>: %19
<br/><font color='#CCFFFF'>Target Debug</font>: %20
<br/><font color='#CCFFFF'>disableAI</font>: %21
",
[west, east] call BIS_fnc_sideIsFriendly,
[west, resistance] call BIS_fnc_sideIsFriendly,
[resistance, east] call BIS_fnc_sideIsFriendly,
tf_west_radio_code,
tf_east_radio_code,
tf_guer_radio_code,
"",//old afi jipp
"",
"",
west countSide allUnits,
east countSide allUnits,
resistance countSide allUnits,
civilian countSide allUnits,
afi_enemy_vehicles_allowed,
afi_enemy_radios_allowed,
{typeOf _x == "ace_spectator_virtual"} count allMissionObjects "VirtualMan_F",
getMissionConfigValue ["respawn","!Ei määritetty!"],
getMissionConfigValue ["respawnTemplates","!Ei määritetty!"],
getMissionConfigValue ["enableDebugConsole","!Ei määritetty!"],
getMissionConfigValue ["EnableTargetDebug","!Ei määritetty!"],
getMissionConfigValue ["disabledAI","!Ei määritetty!"], //21
_radioCountWest,
_radioCountWest,
_radioCountResistance,
_radioCountCiv, //25,
west countSide (if (isDedicated) then {playableUnits} else {switchableUnits}),
east countSide (if (isDedicated) then {playableUnits} else {switchableUnits}),
resistance countSide (if (isDedicated) then {playableUnits} else {switchableUnits}),
civilian countSide (if (isDedicated) then {playableUnits} else {switchableUnits}),//29
(west countSide allUnits) - (west countSide (if (isDedicated) then {playableUnits} else {switchableUnits})),
(east countSide allUnits) - (east countSide (if (isDedicated) then {playableUnits} else {switchableUnits})),
(resistance countSide allUnits) - (resistance countSide (if (isDedicated) then {playableUnits} else {switchableUnits})),
(civilian countSide allUnits) - (civilian countSide (if (isDedicated) then {playableUnits} else {switchableUnits})) //33
]]];
