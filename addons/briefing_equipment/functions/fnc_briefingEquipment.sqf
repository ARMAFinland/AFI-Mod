#include "script_component.hpp"
//Briefing gear v2.4 - by Raimo @ https://armafinland.fi/
//TODO: better layout

///////////////////////////////////////////////
///////			FUNCTIONS				///////
///////////////////////////////////////////////

private _fnc_sanitizeString = {
	//Replaces markup sensitive characters from given string with XML entities
	//& < > " ' >>into>> &amp; &lt; &gt; &quot; &apos;
   params ["_text"];
   private ["_specialsArray","_convertsArray","_i","_return"];
   
   //& < > " '
   _specialsArray = [38, 60, 62, 34, 39];
   //&amp; &lt; &gt; &quot; &apos;
   _convertsArray = [[38,97,109,112,59], [38,108,116,59], [38,103,116,59], [38,113,117,111,116,59], [38,97,112,111,115,59]];
   _return = [];
   
   {
		_i = _specialsArray find _x;
		if (_i isEqualTo -1) then {_return pushBack _x;} else {_return append (_convertsArray select _i);};
   } forEach (toArray _text);
   _return = toString _return;
   
   _return
};

private _fnc_massToKg = {
	//Convert arma item mass to kilograms
	params ["_mass"];

	_mass = _mass * 0.045359237;

	_mass;
};

private _fnc_nameObject = {
	//Get name for object from its config
	params ["_object"];
	private ["_name"];

	//Nimen haku conffista
	_name = getText((configOf _object) >> "displayName");
	//Nimen haku descriptionista jos se on määritelty
	
	if(roleDescription _object != "" && _object isKindOf "man") then {_name = roleDescription _object;};

	_name;
};

private _fnc_roundDecimals = {
	//Rounds value into given max decimal count
	params ["_value","_decimals"];
	private ["_return"];
	//_return = round (_value * (10 ^ _decimals)) / 10 ^ _decimals;
	_return = parseNumber (_value toFixed _decimals);
	_return
};

private _fnc_cargoMassKg = {
	//Get carried mass of a unit in kilograms
	params ["_object"];
	private ["_mass"];

	_mass = [(loadAbs _object) call _fnc_massToKg, 1] call _fnc_roundDecimals;
	
	_mass;
};

private _fnc_confMassKg = {
	//Get items/vehicles configured mass in kilograms
	params ["_class"];
	private ["_mass","_found"];
	
	_found = false;
	
	//Items
	if (_class isKindOf ["itemCore", configFile >> "CfgWeapons"] && !_found) then {_found = true; _mass = [(getNumber(configFile >> "CfgWeapons" >> _class >> "ItemInfo" >> "mass")) call _fnc_massToKg, 2] call _fnc_roundDecimals;};
	//Weapons
	if (_class isKindOf ["default", configFile >> "CfgWeapons"] && !_found) then {_found = true; _mass = [(getNumber(configFile >> "CfgWeapons" >> _class >> "WeaponSlotsInfo" >> "mass")) call _fnc_massToKg, 2] call _fnc_roundDecimals;};
	//Magazines
	if (_class isKindOf ["default", configFile >> "CfgMagazines"] && !_found) then {_found = true; _mass = [(getNumber(configFile >> "CfgMagazines" >> _class >> "mass")) call _fnc_massToKg, 2] call _fnc_roundDecimals;};
	//Vehicles/backpacks
	if (_class isKindOf ["all", configFile >> "CfgVehicles"] && !_found) then {_found = true; _mass = [(getNumber(configFile >> "CfgVehicles" >> _class >> "mass")) call _fnc_massToKg, 2] call _fnc_roundDecimals;};
	//Goggles
	if (_class isKindOf ["None", configFile >> "CfgGlasses"] && !_found) then {_found = true; _mass = [(getNumber(configFile >> "CfgGlasses" >> _class >> "mass")) call _fnc_massToKg, 2] call _fnc_roundDecimals;};
	
	_mass;
};

private _fnc_confName = {
	//Get configured display name
	params ["_class"];
	private ["_name","_found"];

	_found = false;
	
	//Weapons and items
	if (_class isKindOf ["default", configFile >> "CfgWeapons"] && !_found) then {_found = true; _name = getText(configFile >> "CfgWeapons" >> _class >> "displayName");};
	//Magazines
	if (_class isKindOf ["default", configFile >> "CfgMagazines"] && !_found) then {_found = true; _name = getText(configFile >> "CfgMagazines" >> _class >> "displayName");};
	//Vehicles/backpacks
	if (_class isKindOf ["all", configFile >> "CfgVehicles"] && !_found) then {_found = true; _name = getText(configFile >> "CfgVehicles" >> _class >> "displayName");};
	//Goggles
	if (_class isKindOf ["None", configFile >> "CfgGlasses"] && !_found) then {_found = true; _name = getText(configFile >> "CfgGlasses" >> _class >> "displayName");};
	
	//sanitize names to not break script
	_name = (_name call _fnc_sanitizeString);
	_name;
};

private _fnc_confImage = {
	//Get configured image path
	params ["_class"];
	private ["_image","_found"];
	
	_found = false;

	//Weapons and items
	if (_class isKindOf ["default", configFile >> "CfgWeapons"] && !_found) then {_found = true; _image = getText(configFile >> "CfgWeapons" >> _class >> "picture");};
	//Magazines
	if (_class isKindOf ["default", configFile >> "CfgMagazines"] && !_found) then {_found = true; _image = getText(configFile >> "CfgMagazines" >> _class >> "picture");};
	//Vehicles/backpacks
	if (_class isKindOf ["all", configFile >> "CfgVehicles"] && !_found) then {_found = true; _image = getText(configFile >> "CfgVehicles" >> _class >> "picture");};
	//Goggles
	if (_class isKindOf ["None", configFile >> "CfgGlasses"] && !_found) then {_found = true; _image = getText(configFile >> "CfgGlasses" >> _class >> "picture");};
	
	//default image if no configured image found
	if(_image == "") then {_image = "\A3\ui_f\data\map\markers\military\unknown_CA.paa";};
	
	//if image is missing its filename extension add it
	if((_image find ".paa") == -1) then {_image = _image + ".paa";};
	
	_image;
};

private _fnc_confType = {
	//Get configured type number
	params ["_class"];
	private ["_type","_found"];
	
	_found = false;
	
	//Weapons and items
	if (_class isKindOf ["default", configFile >> "CfgWeapons"] && !_found) then {_found = true; _type = getNumber(configFile >> "CfgWeapons" >> _class >> "type");};
	//Magazines
	if (_class isKindOf ["default", configFile >> "CfgMagazines"] && !_found) then {_found = true; _type = getNumber(configFile >> "CfgMagazines" >> _class >> "type");};
	//Vehicles
	if (_class isKindOf ["all", configFile >> "CfgVehicles"] && !_found) then {_found = true; _type = getNumber(configFile >> "CfgVehicles" >> _class >> "type");};
	//Goggles
	if (_class isKindOf ["None", configFile >> "CfgGlasses"] && !_found) then {_found = true; _type = getNumber(configFile >> "CfgGlasses" >> _class >> "type");};
	
	_type;
};

private _fnc_containerInfo = {
	//calculate uniform/vest/backpack free and used capacity in kilograms
	params ["_containerClass",["_load",0]];

	private _loadFreePercent = (1 - _load) * 100;
	//_loadMax = getnumber(configFile >> "CfgVehicles" >> _containerClass >> "maximumLoad"); - vest containers max load
	private _loadMax = getContainerMaxLoad _containerClass;
	private _loadFree = [((1 - _load) * _loadMax) call _fnc_massToKg, 2] call _fnc_roundDecimals;
	_loadMax = [_loadMax call _fnc_massToKg, 2] call _fnc_roundDecimals;

	private _return = format ["%1kg/%2kg", _loadFree, _loadMax];
	_return
};

private _fnc_formatItemInfo = {

	//format item info link into given string, names are turned into array and again into string on execution to not break execute expression
	params ["_linkText","_name","_mass",["_containerInfo",""],["_count",0]];

	private _return = format ["<execute expression='[%5, [%1,%2,%4,%6]] call CBA_fnc_localEvent'>%3</execute>",
	(toArray _name), 
	_mass,
	_linkText,
	(toArray _containerInfo),
	str QGVAR(equipmentChatMessage),
	_count
	];
	//_1("Mitä vittua nyt taaas pt2",_return);
	_return
};

private _fnc_formatWeapon = {
	//format weapon name, image and weapon attachments
	params [["_weaponClass","", [""]],["_weaponItems",nil, [[]]],["_count",0]];
	private ["_name","_image","_mass","_info","_return"];
	
	_return = "";
	if(_weaponClass isNotEqualTo "") then {
		_name = _weaponClass call _fnc_confName;
		_image = _weaponClass call _fnc_confImage;
		_mass = _weaponClass call _fnc_confMassKg;

		if (_count > 1) then {
			_name = format ["%1 (x%2)", _name, _count];
		};
		_info = [_name, _name, _mass, "", _count] call _fnc_formatItemInfo;
		
		_return = _return + format [FONT_0 + _info + FONT_END];
		_return = _return + format ["<br/><img image='%1' width='100' height='50' title='%2'/>	", _image, _name];

		FILTER(_weaponItems,_x isNotEqualTo "");
		FILTER(_weaponItems,_x isNotEqualTo []);
		{
			_name = _x call _fnc_confName;
			_image = _x call _fnc_confImage;
			_mass = _x call _fnc_confMassKg;
			_info = ["*", _name, _mass, "", _count] call _fnc_formatItemInfo;
			
			_return = _return + format ["<img image='%1' width='40' height='40' title='%2'/>", _image, _name];
			_return = _return + format [FONT_0 + _info + FONT_END];
			
			//add comma and empty space if more items
			if (_forEachIndex + 1 < (count _weaponItems)) then {_return = _return + ",	";};
		} forEach _weaponItems;
		
		_return = _return + "<br/>";
	};
	
	_return
};

private _fnc_formatUniform = {
	//format uniform name, image and mass
	params ["_uniformClass",["_unit",objNull]];
	private ["_name","_image","_mass","_info","_return"];
	
	_return = "";
	_info = "";
	if(_uniformClass isNotEqualTo "") then {
		_name = _uniformClass call _fnc_confName;
		_image = _uniformClass call _fnc_confImage;
		_mass = _uniformClass call _fnc_confMassKg;

		
		//if item is container worn by given unit, include its free and used capacity in item info
		if (!isNull _unit) then {
			if(uniform _unit == _uniformClass) then {
				_info = [ _name, _name, _mass, [_uniformClass, (loadUniform _unit)] call _fnc_containerInfo] call _fnc_formatItemInfo;
			};
			if(vest _unit == _uniformClass) then {
				_info = [_name, _name, _mass, [_uniformClass, (loadVest _unit)] call _fnc_containerInfo] call _fnc_formatItemInfo;
			};
			if(backpack _unit == _uniformClass) then {
				_info = [_name, _name, _mass, [_uniformClass, (loadBackpack _unit)] call _fnc_containerInfo] call _fnc_formatItemInfo;
			};
		};
		
		_return = _return + format [FONT_0 + _info + FONT_END];
		_return = _return + format ["<br/><img image='%1' width='50' height='50' title='%2'/>	", _image, _name];
		
		_return = _return + "<br/>";
	};
	
	_return
};

private _fnc_compatibleMagazines = {
	//returns array of compatible magazines for given cfgWeapons class
	params ["_class"];
	private ["_subClasses","_return"];
	
	//add compatible magazines of weapon class
	_return = getArray (configFile >> "CfgWeapons" >> _class >> "magazines");
	
	//get weapon subclasses that have configured magazines
	_subClasses = "count (getArray (_x >> 'magazines')) > 0" configClasses (configFile >> "CfgWeapons" >> _class);

	//add compatible magazines of weapon subclasses
	{
		_return append (getArray (_x >> "magazines"));
	} forEach _subClasses;
	
	_return
};

private _fnc_formatTurret = {
	//format given turret weapons and their ammo
	params ["_vehicle","_turret"];
	private ["_weapons","_magazines","_ammoCount","_magazineCount","_validMagazines","_return","_magazineClass","_name"];
	_return = "";

	_weapons = _vehicle weaponsTurret _turret;
	
	{
		//weapon name or use classname if its empty
		_name = _x call _fnc_confName;
		if (_name == "") then {_name = _x;};
		
		_return = _return + format ["%1<br/>",_name];
		
		//get array of magazines that can be used for given weapon class
		_validMagazines = _x call _fnc_compatibleMagazines;
		//make sure everything is in lowercase, we need this because comparing is cASeseNsitIvE
		_validMagazines = (_validMagazines apply {toLower _x;});
		//current magazines in turret
		_magazines = _vehicle magazinesTurret _turret;
		
		while {count _magazines > 0} do {
			//again make sure everything is in lowercase
			_magazineClass = (_magazines select 0);
			
			if ((toLower _magazineClass) in _validMagazines) then {
				//magazine name or use classname if its empty
				_name = _magazineClass call _fnc_confName;
				if (_name == "") then {_name = _magazineClass;};
				
				_ammoCount = _vehicle magazineTurretAmmo [_magazineClass, _turret];
				_magazineCount = ({_x == _magazineClass} count _magazines) - 1;
				_return = _return + format ["  %1 - " + FONT_6 + "%2" + FONT_END + " rnds", _name, _ammoCount];
				if (_magazineCount > 0) then {_return = _return + format [" | " + FONT_6 + "%1" + FONT_END + " mags<br/>", _magazineCount];} else {_return = _return + "<br/>";};
			};
			
			_magazines = _magazines - [_magazineClass];
		};
	} forEach _weapons;
	
	_return
};

private _fnc_formatItems = {
	params ["_itemsArrHash","_imageW","_imageH",["_unit",objNull]];
	private ["_count","_name","_image","_mass","_info","_i","_return"];
	_return = "";

	private _itemsArr = keys _itemsArrHash;
	{
		_x params ["_itemClass"];
		private _count = _itemsArrHash getOrDefault [_itemClass, 0];
		_name = _itemClass call _fnc_confName;
		_image = _itemClass call _fnc_confImage;
		_mass = _itemClass call _fnc_confMassKg;
		
		//if item has a container, include its capacity in item info
		if ((_itemClass isKindOf ["Vest_Camo_Base", configFile >> "CfgWeapons"]) || (_itemClass isKindOf ["Uniform_Base", configFile >> "CfgWeapons"]) || (_itemClass isKindOf ["Bag_Base", configFile >> "CfgVehicles"])) then {
			_info = [("x" + (str _count)), _name, _mass, [_itemClass] call _fnc_containerInfo, _count] call _fnc_formatItemInfo;
		} else {
			_info = [("x" + (str _count)), _name, _mass, "", _count] call _fnc_formatItemInfo;
		};
		
		//if item is container worn by given unit, include its free and used capacity in item info
		if (!isNull _unit) then {
			if(uniform _unit == _itemClass) then {
				_info = [("x" + (str _count)), _name, _mass, [_itemClass, (loadUniform _unit)] call _fnc_containerInfo, _count] call _fnc_formatItemInfo;
			};
			if(vest _unit == _itemClass) then {
				_info = [("x" + (str _count)), _name, _mass, [_itemClass, (loadVest _unit)] call _fnc_containerInfo, _count] call _fnc_formatItemInfo;
			};
			if(backpack _unit == _itemClass) then {
				_info = [("x" + (str _count)), _name, _mass, [_itemClass, (loadBackpack _unit)] call _fnc_containerInfo, _count] call _fnc_formatItemInfo;
			};
		};

		_return = _return + format ["<img image='%1' width='%2' height='%3' title='%4'/>", _image, _imageW, _imageH, _name];
		_return = _return + format [FONT_0 + _info + FONT_END];
		
		if((_forEachIndex + 1) < count (_itemsArr)) then {
			_return = _return + ", ";
			if((_forEachIndex + 1) mod _rows == 0) then {_return = _return + "<br/>";};
		};
	} forEach _itemsArr;
	
	_return
};

private _fnc_arrayCountEquals = {
	//counts equal elements in an array and returns two arrays [[item1,item2...],[count1,count2...]]
	private ["_item","_count","_return"];
	_return = createHashMap;
	
	private _inputArray = _this;
	while {(count _inputArray) > 0} do {
		_item = _inputArray select 0;
		_count = {_x == _item} count _inputArray;
		
		_return set [_item, _count];
		_inputArray = _inputArray - [_item];
	};
	
	_return
};

private _fnc_compatibleMagazinesSmallArmas = {
	params ["_primaryWeaponClass", "_allItems"];
	private _compatibleMagazines = compatibleMagazines _primaryWeaponClass;
	private _mags = createHashMap;
	{
		private _mag = _x;
		private _count = _allItems getOrDefault [_mag, 0];
		if (_count > 0) then {
			_mags set [_mag, _count];
			_allItems deleteAt _mag;
		};

	} forEach _compatibleMagazines;

	_mags
};

///////////////////////////////////////////////
///////			VARIABLES				///////
///////////////////////////////////////////////
private ["_name","_image","_briefingEntry","_locationMarker","_stringList","_turrets","_turretRole","_vehicle","_info","_rows"];

//_font = "<font face='EtelkaMonospacePro' color='#FFFFFF' size='14'>"; //monospace font for itemcounts if you ever want to play with spacing
_rows = 6; //items listed per line
_stringList = [];
private _groups = [];
private _groupsTemp = [];
_groupsTemp = allGroups select {side _x == side player};

//add all groups with playable units from side if "AFI_gear_allGroups" variable is not false
if (missionNamespace getVariable ["AFI_gear_allGroups", true]) then {
	{
		{
			if (_x in playableUnits) exitWith {_groups pushBackUnique (group _x);};
		} forEach units _x;
	} forEach _groupsTemp;
	
	reverse _groups;
};
if (_groups isEqualTo []) then {_groups pushBack group player;};


///////////////////////////////////////////////
///////				UNITS				///////
///////////////////////////////////////////////

if(!(player diarySubjectExists SUBJECT)) then {player createDiarySubject [SUBJECT, SUBJECT];};

{
	_briefingEntry = "";
	
	{	
		private _soldier = _x;
		private _assignedItems = assignedItems _soldier;
		private _allWeapons = weaponsItems [_soldier, false];
		private _allItems = (items _soldier) + (magazines _soldier);

		//Add unit title in format: index/name/role/loadout weight
		_briefingEntry = _briefingEntry + format [FONT_1 + "%1. %2 - %3 - %4kg<br/>" + FONT_END, (_forEachIndex + 1), (name _x), (_x call _fnc_nameObject), (_x call _fnc_cargoMassKg)];
		
		//WEAPONS
		private _primaryWeapon = [];
		private _secondaryWeapon = [];
		private _sidearm = [];
		private _additionalPrimaryWeapons = [];
		private _additionalSecondaryWeapons = [];
		private _additionalSidearms = [];
		{
			private _weaponData = _x;
			FILTER(_weaponData,_x isNotEqualTo "");
			FILTER(_weaponData,_x isNotEqualTo []);
			{ 
				if (_x isEqualType []) then {
					_weaponData set [_forEachIndex, _x select 0];
				};
			} forEach _weaponData;

			private _weapon = _weaponData select 0;
			private _weaponAttachments = _weaponData - [_weapon];
			private _weaponIndex = [_soldier, _weapon] call ace_common_fnc_getWeaponIndex;
			private _weaponType = [_weapon] call ace_common_fnc_getWeaponType;

			if (_weaponIndex isEqualTo -1) then {
				switch (_weaponType) do {
					case 1: {
						_additionalPrimaryWeapons append [_weapon, _weaponAttachments];
						_allItems = _allItems - [_weapon];
					};
					case 2: {
						_additionalSecondaryWeapons append [_weapon, _weaponAttachments];
						_allItems = _allItems - [_weapon];
					};
					case 3: {
						_additionalSidearms append [_weapon, _weaponAttachments];
						_allItems = _allItems - [_weapon];
					};
				};
			} else {
				switch (_weaponIndex) do {
					case 0: {
						_primaryWeapon append [_weapon, _weaponAttachments];
						_allItems = _allItems - [_weapon];
					};
					case 1: {
						_secondaryWeapon append [_weapon, _weaponAttachments];
						_allItems = _allItems - [_weapon];
					};
					case 2: {
						_sidearm append [_weapon, _weaponAttachments];
						_allItems = _allItems - [_weapon];
					};
				};
			};

		} forEach _allWeapons;


		_allItems = _allItems call _fnc_arrayCountEquals;

		{
			_x params ["_weapon","_additionalWeapons","_gunText","_additionalGunText"];
			if (_weapon isNotEqualTo [] || _additionalWeapons isNotEqualTo []) then {
				private _weaponBrief = "";
				if (_weapon isNotEqualTo []) then {
					_weaponBrief = _weaponBrief + format [FONT_2 + _gunText + FONT_END];
					_weapon params ["_weaponClass","_weaponItems"];
					private _count = {_weaponClass isEqualTo _x} count _weapon;

					_weaponBrief = _weaponBrief + ([_weaponClass, _weaponItems,_count] call _fnc_formatWeapon);

					private _mags = [_weaponClass, _allItems] call _fnc_compatibleMagazinesSmallArmas;
					
					if (keys _mags isNotEqualTo []) then {
						MAGS_TO_BRIEF("Additional mags:<br/>",_mags,_soldier);
					};
				};

				if (_additionalWeapons isNotEqualTo []) then {
					_weaponBrief = _weaponBrief + format [FONT_2 + _additionalGunText + FONT_END];
					while {_additionalWeapons isNotEqualTo []} do {
						private _weaponData = _additionalWeapons select 0;
						_weaponData params ["_weaponClass","_weaponItems"];
						private _count = {_weaponData isEqualTo _x} count _additionalWeapons;

						if (_count > 1) then {
							FILTER(_additionalWeapons,_x isNotEqualTo _weaponData);
						};
						
						_weaponBrief = _weaponBrief + ([_weaponClass, _weaponItems, _count] call _fnc_formatWeapon);

						private _mags = [_weaponClass, _allItems] call _fnc_compatibleMagazinesSmallArmas;

						if (keys _mags isNotEqualTo []) then {
							MAGS_TO_BRIEF("Mags:<br/>",_mags,_soldier);
						};
					};
				};
				_briefingEntry = _briefingEntry + _weaponBrief;
			};
		} forEach [[_primaryWeapon, _additionalPrimaryWeapons, "Primary: ", "Additional Primary:<br/>"],
					[_secondaryWeapon, _additionalSecondaryWeapons, "Secondary: ", "Additional Secondary:<br/>"],
					[_sidearm, _additionalSidearms, "Sidearm: ", "Additional Sidearm:<br/>"]];
		
		
		//UNIFORM/VEST/BACKPACK ITEMS 
		private _headgear = headgear _soldier;
		if(_headgear isNotEqualTo "") then {
			_briefingEntry = _briefingEntry + format [FONT_2 + "Helmet: " + FONT_END] + ([_headgear, _soldier] call _fnc_formatUniform);
		};

		//Raimon lasit talteen
		private _goggles = goggles _soldier;
		if(_goggles isNotEqualTo "") then {
			_briefingEntry = _briefingEntry + format [FONT_2 + "Facewear: " + FONT_END] + ([_goggles, _soldier] call _fnc_formatUniform);
		};

		private _uniform = uniform _soldier;
		if(_uniform isNotEqualTo "") then {
			_briefingEntry = _briefingEntry + format [FONT_2 + "Uniform: " + FONT_END] + ([_uniform, _soldier] call _fnc_formatUniform);
		};

		private _vest = vest _soldier;
		if(_vest isNotEqualTo "") then {
			_briefingEntry = _briefingEntry + format [FONT_2 + "Vest: " + FONT_END] + ([_vest, _soldier] call _fnc_formatUniform);
		};

		private _backpack = backpack _soldier;
		if (_backpack isNotEqualTo "") then {
			_briefingEntry = _briefingEntry + format [FONT_2 + "Backpack: " + FONT_END] + ([_backpack, _soldier] call _fnc_formatUniform);
		};


		if (_assignedItems isNotEqualTo []) then {
			//Linked items
			_assignedItems = _assignedItems call _fnc_arrayCountEquals;
			_briefingEntry = _briefingEntry + format [FONT_2 + "Linked items:<br/>" + FONT_END] + ([_assignedItems,32,32,_soldier] call _fnc_formatItems) + "<br/>";
		};

		//EVERYTHING ELSE
		_briefingEntry = _briefingEntry + format [FONT_2 + "Misc magazines and items:<br/>" + FONT_END];
		
		if (keys _allItems isNotEqualTo []) then {
			_briefingEntry = _briefingEntry + ([_allItems,32,32,_x] call _fnc_formatItems);
		};
		
		//All unit info added, finish with divider string
		_briefingEntry = _briefingEntry + DIVIDER;
		
	} forEach units _x; //repeat for every unit in group
	
	//after all units in a group have been added create a briefing page
	private _ownGroup = "";
	if (_x == group player) then {_ownGroup = " (You)";};
	player createDiaryRecord [SUBJECT,[format ["GROUP: %1" + _ownGroup, groupId _x],(_briefingEntry + CREDITS)]];
	
} forEach _groups; //repeat for every given group


///////////////////////////////////////////////
///////				VEHICLES			///////
///////////////////////////////////////////////

{
	_vehicle = _x;
	_briefingEntry = "";
	
	if ((_vehicle getVariable "AFI_vehicle_gear") == str(side player)) then {
	
		//vehicle location linking on if "AFI_aloitus_merkit" variable isnt false
		if (missionNamespace getVariable ["AFI_Aloitus_Merkit", true]) then {
			_locationMarker = "RMO_locMarker_" + str(_forEachIndex);
			createMarkerLocal [_locationMarker, (position _vehicle)];
		};
		
		//check if object is a container
		if (_vehicle isKindOf "thing") then {
			_name = "Container";
			_image = "";
		} else {
			_name = _vehicle call _fnc_nameObject;
			_image = format ["<img image='%1' width='100' height='50' title='%2'/><br/>",(typeOf _vehicle) call _fnc_confImage, _name];
		};
		
		//add vehicle title and create map link to its location
		_briefingEntry = _briefingEntry + format [FONT_3 + "<marker name='%2'>%1</marker><br/>%3" + FONT_END, _name, _locationMarker, _image];
		
		//add armament for vehicle positions
		if (count (fullCrew [_vehicle, "", true]) > 0) then {
			_briefingEntry = _briefingEntry + format [FONT_4 + "Armament:" + FONT_END + "<br/>"];
			
			//DRIVER TURRETS
			_turrets = fullCrew [_vehicle, "driver", true]; 
			if (count _turrets > 0) then {
				{if (count (_x select 3) == 0) exitWith {_x set [3, [-1]];};} forEach _turrets;
				if (typeOf(_vehicle) isKindOf "Air") then {_turretRole = "Pilot:";} else {_turretRole = "Driver:";};
				_name = "";
				{if (!isNull (_x select 0)) then {_name = name (_x select 0);};} forEach _turrets;
				_briefingEntry = _briefingEntry + format [FONT_5 + "%1" + FONT_END + FONT_7 + " %2" + FONT_END + "<br/>",_turretRole,_name];
				private _tempStr = "";
				
				{
					_tempStr = _tempStr + ([_vehicle, _x select 3] call _fnc_formatTurret);
				} forEach _turrets;
				
				if (_tempStr == "") then {_briefingEntry = _briefingEntry + format ["N/A<br/>"];} else {_briefingEntry = _briefingEntry + _tempStr;};
			};
			
			//GUNNER TURRETS
			_turrets = fullCrew [_x, "gunner", true];
			if (count _turrets > 0) then {
				//if (typeOf(_vehicle) isKindOf "Air") then {_turretRole = "Co-Pilot/Gunner:";} else {_turretRole = "Gunner:";};
				_turretRole = "Gunner:";
				_name = "";
				{if (!isNull (_x select 0)) then {_name = name (_x select 0);};} forEach _turrets;
				_briefingEntry = _briefingEntry + format [FONT_5 + "%1" + FONT_END + FONT_7 + " %2" + FONT_END + "<br/>",_turretRole,_name];
				private _tempStr = "";
				
				{
					_tempStr = _tempStr + ([_vehicle, _x select 3] call _fnc_formatTurret);
				} forEach _turrets;
				
				if (_tempStr == "") then {_briefingEntry = _briefingEntry + format ["N/A<br/>"];} else {_briefingEntry = _briefingEntry + _tempStr;};
			};
			
			//COMMANDER TURRETS
			_turrets = fullCrew [_x, "commander", true];
			if (count _turrets > 0) then {
				_turretRole = "Commander:";
				_name = "";
				{if (!isNull (_x select 0)) then {_name = name (_x select 0);};} forEach _turrets;
				_briefingEntry = _briefingEntry + format [FONT_5 + "%1" + FONT_END + FONT_7 + " %2" + FONT_END + "<br/>",_turretRole,_name];
				private _tempStr = "";
				
				{
					_tempStr = _tempStr + ([_vehicle, _x select 3] call _fnc_formatTurret);
				} forEach _turrets;
				
				if (_tempStr == "") then {_briefingEntry = _briefingEntry + format ["N/A<br/>"];} else {_briefingEntry = _briefingEntry + _tempStr;};
			};
			
			//CREW TURRETS - can contain more than 1 manned crew positions
			_turrets = (fullCrew [_vehicle, "turret", true]) select {_x select 2 < 0};
			if (count _turrets > 0) then {
				_turretRole = "Crew:";
				private _tempStr = "";
				
				{
					_name = "";
					if (!isNull (_x select 0)) then {_name = name (_x select 0);};
					
					_briefingEntry = _briefingEntry + format [FONT_5 + "%1" + FONT_END + FONT_7 + " %2" + FONT_END + "<br/>", _turretRole, _name];
					_tempStr = _tempStr + ([_vehicle, _x select 3] call _fnc_formatTurret);
					if (_tempStr == "") then {_briefingEntry = _briefingEntry + format ["N/A<br/>"];} else {_briefingEntry = _briefingEntry + _tempStr;};
					_tempStr = "";
				} forEach _turrets;
			};
		};

		//calculate used and total passenger seats
		private _passengersMax = count ((fullCrew [_vehicle, "", true]) select {_x select 2 > -1});
		private _passengers = (fullCrew [_vehicle, "", false]) select {_x select 2 > -1};
		_passengers = _passengers apply {_x select 0;};
		_passengers = _passengers apply {name _x;};
		//_passengersCurrent = count ((fullcrew [_vehicle, "", false]) select {_x select 2 > -1});
		if (_passengersMax > 0) then {
			_briefingEntry = _briefingEntry + format [FONT_4 + "<br/>Passengers: " + FONT_END + "<font size='16'>%1/%2</font><br/>",count _passengers, _passengersMax];
			{_briefingEntry = _briefingEntry + format [FONT_7 + "%1" + FONT_END + "<br/>",_x];} forEach _passengers;
		};

		///////////////////////////////////////////////
		//CARGO
		///////////////////////////////////////////////
		
		private _cargoItems = createHashMap;
		private _cargoWeapons = createHashMap;
		private _cargo = getWeaponCargo _x;
		
		//Separating weapons from binoculars etc
		{
			if (_x call _fnc_confType == 1 || _x call _fnc_confType == 2 || _x call _fnc_confType == 4 ) then {
				_cargoWeapons set [_x, ((_cargo select 1) select _forEachIndex)];
			} else {
				_cargoItems set [_x, ((_cargo select 1) select _forEachIndex)];
			};
		} forEach (_cargo select 0);
		
		//Adding the rest of the cargo items

		private _magazineCargo  = getMagazineCargo _x;
		_cargoItems insert [true, (_magazineCargo select 0), (_magazineCargo select 1)];

		private _itemCargo = getItemCargo _x;
		_cargoItems insert [true, (_itemCargo select 0), (_itemCargo select 1)];

		private _backpackCargo = getBackpackCargo _x;
		_cargoItems insert [true, (_backpackCargo select 0), (_backpackCargo select 1)];
		
		//add cargo title only if there is some cargo
		if((count (keys _cargoItems) + count (keys _cargoWeapons)) > 0) then {_briefingEntry = _briefingEntry + format [FONT_4 + "<br/>Cargo:" + FONT_END];};

		//WEAPONS
		if (keys _cargoWeapons isNotEqualTo []) then {
			_briefingEntry = _briefingEntry + format ["<br/>Weapons:<br/>"];
			_briefingEntry = _briefingEntry + ([_cargoWeapons,80,40] call _fnc_formatItems);
		};

		//ITEMS
		if (keys _cargoItems isNotEqualTo []) then {
			_briefingEntry = _briefingEntry + format ["<br/>Magazines and items:<br/>"];
			_briefingEntry = _briefingEntry + ([_cargoItems,32,32] call _fnc_formatItems);
		};
		
		_briefingEntry = _briefingEntry + DIVIDER;
		
		
		///////////////////////////////////////////////
		//Sort vehicles 
		///////////////////////////////////////////////
		
		private _vehicleType = "";
		_vehicleType = getText((configOf _vehicle) >> "vehicleClass");
		_vehicleType = toLower(getText(configFile >> "CfgVehicleClasses" >> _vehicleType >> "displayName"));
		_vehicleType = toArray(toUpper(_vehicleType select [0,1]) + _vehicleType);
		_vehicleType deleteAt 1;
		_vehicleType = toString(_vehicleType);
		if (_vehicleType == "") then {_vehicleType = "Misc";};
		
		//Stringien säilytys listaan luokittelun mukaan, muodossa [[STRING, LUOKITTELU, LUKUMÄÄRÄ], [..., ..., ...], ...]
		private _found = false;	
		//Jos lista on tyhjä, lisätään uudeksi kohdaksi, muuten etsitään samammimistä kohtaa ja lisätään sen alle
		if (count _stringList == 0) then {_stringList pushBack [format [FONT_3 + "1. " + FONT_END] + _briefingEntry, _vehicleType, 1];} else {
			{
				if ((_x select 1) == _vehicleType) then {
					_found = true;
					_x set [2,(_x select 2) + 1];
					private _numStr = format [FONT_3 + "%1. " + FONT_END,(_x select 2)];
					_x set [0,(_x select 0) + _numStr + _briefingEntry];
				};
			} forEach _stringList;
			
			//Jos samannimistä kohtaa ei löydy, lisätään uutena
			if (!_found) then {_stringList pushBack [format [FONT_3 + "1. " + FONT_END] + _briefingEntry, _vehicleType, 1];};
		};
		
		_briefingEntry = "";
	};
} forEach vehicles;

if (count _stringList > 0) then {
	//Listan järjestäminen aakkosjärjestykseen
	private _sorted = [];
	//Luokittelun perään lisätään lukumäärä ja siirretään järjestelylistaan
	{_x set [1,(_x select 1) + " (" + str(_x select 2) + ")"]; _sorted pushBack ["", (_x select 1)];} forEach _stringList;
	_sorted sort false;
	{
		for "_i" from 0 to ((count _sorted) - 1) do {
			if (_x select 1 == (_sorted select _i) select 1) then {
				_sorted set [_i, _x];
			};
		};
	} forEach _stringList;


	{player createDiaryRecord [SUBJECT,[(_x select 1),(_x select 0) + CREDITS]];} forEach _sorted;
};
