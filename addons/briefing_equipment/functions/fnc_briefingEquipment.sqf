//Briefing gear v2.4 - by Raimo @ https://armafinland.fi/
//TODO: better layout


///////////////////////////////////////////////
///////			FUNCTIONS				///////
///////////////////////////////////////////////

_fnc_sanitizeString = {
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
   
   _return;
};

_fnc_massToKg = {
	//Convert arma item mass to kilograms
	params ["_mass"];

	_mass = _mass * 0.045359237;

	_mass;
};

_fnc_nameObject = {
	//Get name for object from its config
	params ["_object"];
	private ["_name"];

	//Nimen haku conffista
	_name = getText(configFile >> "CfgVehicles" >> typeOf _object >> "displayName");
	//Nimen haku descriptionista jos se on määritelty
	
	if(roleDescription _object != "" && _object isKindOf "man") then {_name = roleDescription _object;};

	_name;
};

_fnc_roundDecimals = {
	//Rounds value into given max decimal count
	params ["_value","_decimals"];
	private ["_return"];
	//_return = round (_value * (10 ^ _decimals)) / 10 ^ _decimals;
	_return = parseNumber (_value toFixed _decimals);
	_return;
};

_fnc_cargoMassKg = {
	//Get carried mass of a unit in kilograms
	params ["_object"];
	private ["_mass"];

	_mass = [(loadAbs _object) call _fnc_massToKg, 1] call _fnc_roundDecimals;
	
	_mass;
};

_fnc_confMassKg = {
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
	
	_mass;
};

_fnc_confName = {
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
	
	//sanitize names to not break script
	_name = (_name call _fnc_sanitizeString);
	_name;
};

_fnc_confImage = {
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
	
	//default image if no configured image found
	if(_image == "") then {_image = "\A3\ui_f\data\map\markers\military\unknown_CA.paa";};
	
	//if image is missing its filename extension add it
	if((_image find ".paa") == -1) then {_image = _image + ".paa";};
	
	_image;
};

_fnc_confType = {
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
	
	_type;
};

_fnc_formatItemInfo = {
	//format item info link into given string, names are turned into array and again into string on execution to not break execute expression
	params ["_linkText","_name","_mass",["_containerInfo",""]];
	private ["_return"];
	
	if (_containerInfo != "") then {
		_return = format ["<execute expression='call {%5 sideChat (""Item: "" + str (parseText (toString %1))); %5 sideChat ""- Weight: %2kg""; %5 sideChat ""- Free: %4"";}'>%3</execute>",toArray _name, _mass, _linkText, player];
	} else {
		_return = format ["<execute expression='call {%4 sideChat (""Item: "" + str (parseText (toString %1))); %4 sideChat ""- Weight: %2kg"";}'>%3</execute>",toArray _name, _mass, player];
	};
	
	_return;
};

_fnc_formatWeapon = {
	//format weapon name, image and weapon attachments
	params ["_weaponClass","_weaponItems"];
	private ["_name","_image","_mass","_info","_return"];
	
	_return = "";

	if(_weaponClass != "") then {
		_return = "";
		_name = _weaponClass call _fnc_confName;
		_image = _weaponClass call _fnc_confImage;
		_mass = _weaponClass call _fnc_confMassKg;
		_info = [_name, _name, _mass] call _fnc_formatItemInfo;
		
		_return = _return + format [_font0 + _info + _fontEnd];
		_return = _return + format ["<br/><img image='%1' width='100' height='50'/>	", _image];
		
		_weaponItems = _weaponItems - [""];
		{
			_name = _x call _fnc_confName;
			_image = _x call _fnc_confImage;
			_mass = _x call _fnc_confMassKg;
			_info = ["*", _name, _mass] call _fnc_formatItemInfo;
			
			_return = _return + format ["<img image='%1' width='40' height='40'/>", _image];
			_return = _return + format [_font0 + _info + _fontEnd];
			
			//add comma and empty space if more items
			if (_forEachIndex + 1 < (count _weaponItems)) then {_return = _return + ",	";};
		} forEach _weaponItems;
		
		_return = _return + "<br/>";
	};
	
	_return;
};

_fnc_containerInfo = {
	//calculate uniform/vest/backpack free and used capacity in kilograms
	params ["_containerClass",["_load",0]];
	private ["_loadMax","_loadFree","_loadFreePercent","_return"];

	_loadFreePercent = (1 - _load) * 100;
	//_loadMax = getnumber(configFile >> "CfgVehicles" >> _containerClass >> "maximumLoad"); - vest containers max load
	_loadMax = getContainerMaxLoad _containerClass;
	_loadFree = [((1 - _load) * _loadMax) call _fnc_massToKg, 2] call _fnc_roundDecimals;
	_loadMax = [_loadMax call _fnc_massToKg, 2] call _fnc_roundDecimals;

	_return = format ["%1kg/%2kg", _loadFree, _loadMax];

	_return;
};

_fnc_compatibleMagazines = {
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
	
	_return;
};

_fnc_formatTurret = {
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
				_return = _return + format ["  %1 - " + _font6 + "%2" + _fontEnd + " rnds", _name, _ammoCount];
				if (_magazineCount > 0) then {_return = _return + format [" | " + _font6 + "%1" + _fontEnd + " mags<br/>", _magazineCount];} else {_return = _return + "<br/>";};
			};
			
			_magazines = _magazines - [_magazineClass];
		};
	} forEach _weapons;
	
	_return;
};

_fnc_formatItems = {
	params ["_itemsArr","_imageW","_imageH",["_unit",objNull]];
	private ["_count","_name","_image","_mass","_info","_i","_return"];
	_return = "";
	
	{	
		_name = _x call _fnc_confName;
		_image = _x call _fnc_confImage;
		_mass = _x call _fnc_confMassKg;
		_count = (_itemsArr select 1) select _forEachIndex;
		
		//if item has a container, include its capacity in item info
		if ((_x isKindOf ["Vest_Camo_Base", configFile >> "CfgWeapons"]) || (_x isKindOf ["Uniform_Base", configFile >> "CfgWeapons"]) || (_x isKindOf ["Bag_Base", configFile >> "CfgVehicles"])) then {
			_info = [("x" + (str _count)), _name, _mass, [_x] call _fnc_containerInfo] call _fnc_formatItemInfo;
		} else {
			_info = [("x" + (str _count)), _name, _mass] call _fnc_formatItemInfo;
		};
		
		//if item is container worn by given unit, include its free and used capacity in item info
		if (!isNull _unit) then {
			if(uniform _unit == _x) then {
				_info = [("x" + (str _count)), _name, _mass, [_x, (loadUniform _unit)] call _fnc_containerInfo] call _fnc_formatItemInfo;
			};
			if(vest _unit == _x) then {
				_info = [("x" + (str _count)), _name, _mass, [_x, (loadVest _unit)] call _fnc_containerInfo] call _fnc_formatItemInfo;
			};
			if(backpack _unit == _x) then {
				_info = [("x" + (str _count)), _name, _mass, [_x, (loadBackpack _unit)] call _fnc_containerInfo] call _fnc_formatItemInfo;
			};
		};
		
		_return = _return + format ["<img image='%1' width='%2' height='%3'/>", _image, _imageW, _imageH];
		_return = _return + format [_font0 + _info + _fontEnd];
		
		if((_forEachIndex + 1) < count (_itemsArr select 0)) then {
			_return = _return + ", ";
			if((_forEachIndex + 1) mod _rows == 0) then {_return = _return + "<br/>";};
		};
	} forEach (_itemsArr select 0);
	
	_return;
};

_fnc_arrayCountEquals = {
	//counts equal elements in an array and returns two arrays [[item1,item2...],[count1,count2...]]
	private ["_item","_count","_return"];
	_return = [[],[]];
	
	_inputArray = _this;
	while {(count _inputArray) > 0} do {
		_item = _inputArray select 0;
		_count = {_x == _item} count _inputArray;
		
		(_return select 0) pushBack _item;
		(_return select 1) pushBack _count;
		
		_inputArray = _inputArray - [_item];
	};
	
	_return;
};

///////////////////////////////////////////////
///////			VARIABLES				///////
///////////////////////////////////////////////
private ["_name","_image","_briefingEntry","_locationMarker","_stringList","_turrets","_turretRole","_vehicle","_info","_rows"];
_credits = format ["<br/>Click item count for more information.<br/><font color='#4F4F4F' size='8'>Script by Raimo @ ArmaFinland.fi</font><br/>"];
_subject = "Equipment";
_divider = "<br/>_________________________________________________________________________<br/>";
_fontEnd = "</font>";
_font0 = "<font color='#FFFFFF' size='14'>"; //default text - colors are #RRGGBB in hex
_font1 = "<font color='#FFFFFF' size='18'>"; //unit title
_font2 = "<font color='#FFFF00' size='14'>"; //unit armament title
_font3 = "<font color='#FFFFFF' size='18'>"; //vehicle title
_font4 = "<font color='#FFFF00' size='16'>"; //vehicle armament title
_font5 = "<font color='#FFFF00' size='12'>"; //turret role
_font6 = "<font color='#FFFFB2' size='14'>"; //turret weapon ammo count
_font7 = "<font color='#FFFFFF' size='12'>"; //crew/passenger names
//_font = "<font face='EtelkaMonospacePro' color='#FFFFFF' size='14'>"; //monospace font for itemcounts if you ever want to play with spacing
_rows = 6; //items listed per line
_stringList = [];
_groups = [];
_groupsTemp = [];
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
if (count _groups == 0) then {_groups pushBack group player;};


///////////////////////////////////////////////
///////				UNITS				///////
///////////////////////////////////////////////

if(!(player diarySubjectExists _subject)) then {player createDiarySubject [_subject, _subject];};

{
	_briefingEntry = "";
	
	{	
		//Add unit title in format: index/name/role/loadout weight
		_briefingEntry = _briefingEntry + format [_font1 + "%1. %2 - %3 - %4kg<br/>" + _fontEnd, (_forEachIndex + 1), (name _x), (_x call _fnc_nameObject), (_x call _fnc_cargoMassKg)];
		
		//PRIMARY WEAPON
		if (primaryWeapon _x != "") then {
			_briefingEntry = _briefingEntry + format [_font2 + "Primary: " + _fontEnd];
			_briefingEntry = _briefingEntry + ([primaryWeapon _x, primaryWeaponItems _x] call _fnc_formatWeapon);
		};
		
		//SECONDARY WEAPON
		if (secondaryWeapon _x != "") then {
			_briefingEntry = _briefingEntry + format [_font2 + "Secondary: " + _fontEnd];
			_briefingEntry = _briefingEntry + ([secondaryWeapon _x, secondaryWeaponItems _x] call _fnc_formatWeapon);
		};
		
		//SIDEARM
		if (handgunWeapon _x != "") then {
			_briefingEntry = _briefingEntry + format [_font2 + "Sidearm: " + _fontEnd];
			_briefingEntry = _briefingEntry + ([handgunWeapon _x, handgunItems _x] call _fnc_formatWeapon);
		};
		
		//EVERYTHING ELSE
		_briefingEntry = _briefingEntry + format [_font2 + "Magazines and items:<br/>" + _fontEnd];
		
		_allItems = [];
		_allItems append (magazines _x);
		_allItems append (primaryWeaponMagazine _x);
		_allItems append (secondaryWeaponMagazine _x);
		_allItems append (handgunMagazine _x);
		_allItems append (items _x);
		_allItems append (assignedItems _x);
		if(headgear _x != "") then {_allItems pushBack (headgear _x);};
		if(uniform _x != "") then {_allItems pushBack (uniform _x);};
		if(vest _x != "") then {_allItems pushBack (vest _x);};
		if(backpack _x != "") then {_allItems pushBack (backpack _x);};
		
		if (count _allItems > 0) then {
			_allItems = _allItems call _fnc_arrayCountEquals;
			_briefingEntry = _briefingEntry + ([_allItems,32,32,_x] call _fnc_formatItems);
			//_briefingEntry = _briefingEntry + "<br/>";
		};
		
		//All unit info added, finish with divider string
		_briefingEntry = _briefingEntry + _divider;
		
	} forEach units _x; //repeat for every unit in group
	
	//after all units in a group have been added create a briefing page
	_ownGroup = "";
	if (_x == group player) then {_ownGroup = " (You)";};
	player createDiaryRecord [_subject,[format ["GROUP: %1" + _ownGroup, groupId _x],(_briefingEntry + _credits)]];
	
} forEach _groups; //repeat for every given group


///////////////////////////////////////////////
///////				VEHICLES			///////
///////////////////////////////////////////////

{
	_vehicle = _x;
	_briefingEntry = "";
	
	if ((_x getVariable "AFI_vehicle_gear") == str(side player)) then {
	
		//vehicle location linking on if "AFI_aloitus_merkit" variable isnt false
		if (missionNamespace getVariable ["AFI_Aloitus_Merkit", true]) then {
			_locationMarker = "RMO_locMarker_" + str(_forEachIndex);
			createMarkerLocal [_locationMarker, (position _x)];
		};
		
		//check if object is a container
		if (_x isKindOf "thing") then {
			_name = "Container";
			_image = "";
		} else {
			_name = _x call _fnc_nameObject;
			_image = format ["<img image='%1' width='100' height='50'/><br/>",(typeOf _x) call _fnc_confImage];
		};
		
		//add vehicle title and create map link to its location
		_briefingEntry = _briefingEntry + format [_font3 + "<marker name='%2'>%1</marker><br/>%3" + _fontEnd, _name, _locationMarker, _image];
		
		//add armament for vehicle positions
		if (count (fullCrew [_x, "", true]) > 0) then {
			_briefingEntry = _briefingEntry + format [_font4 + "Armament:" + _fontEnd + "<br/>"];
			
			//DRIVER TURRETS
			_turrets = fullCrew [_x, "driver", true]; 
			if (count _turrets > 0) then {
				{if (count (_x select 3) == 0) exitWith {_x set [3, [-1]];};} forEach _turrets;
				if (typeOf(_vehicle) isKindOf "Air") then {_turretRole = "Pilot:";} else {_turretRole = "Driver:";};
				_name = "";
				{if (!isNull (_x select 0)) then {_name = name (_x select 0);};} forEach _turrets;
				_briefingEntry = _briefingEntry + format [_font5 + "%1" + _fontEnd + _font7 + " %2" + _fontEnd + "<br/>",_turretRole,_name];
				_tempStr = "";
				
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
				_briefingEntry = _briefingEntry + format [_font5 + "%1" + _fontEnd + _font7 + " %2" + _fontEnd + "<br/>",_turretRole,_name];
				_tempStr = "";
				
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
				_briefingEntry = _briefingEntry + format [_font5 + "%1" + _fontEnd + _font7 + " %2" + _fontEnd + "<br/>",_turretRole,_name];
				_tempStr = "";
				
				
				{
					_tempStr = _tempStr + ([_vehicle, _x select 3] call _fnc_formatTurret);
				} forEach _turrets;
				
				if (_tempStr == "") then {_briefingEntry = _briefingEntry + format ["N/A<br/>"];} else {_briefingEntry = _briefingEntry + _tempStr;};
			};
			
			//CREW TURRETS - can contain more than 1 manned crew positions
			_turrets = (fullCrew [_x, "turret", true]) select {_x select 2 < 0};
			if (count _turrets > 0) then {
				_turretRole = "Crew:";
				_tempStr = "";
				
				{
					_name = "";
					if (!isNull (_x select 0)) then {_name = name (_x select 0);};
					
					_briefingEntry = _briefingEntry + format [_font5 + "%1" + _fontEnd + _font7 + " %2" + _fontEnd + "<br/>", _turretRole, _name];
					_tempStr = _tempStr + ([_vehicle, _x select 3] call _fnc_formatTurret);
					if (_tempStr == "") then {_briefingEntry = _briefingEntry + format ["N/A<br/>"];} else {_briefingEntry = _briefingEntry + _tempStr;};
					_tempStr = "";
				} forEach _turrets;
			};
		};

		//calculate used and total passenger seats
		_passengersMax = count ((fullCrew [_x, "", true]) select {_x select 2 > -1});
		_passengers = (fullCrew [_x, "", false]) select {_x select 2 > -1};
		_passengers = _passengers apply {_x select 0;};
		_passengers = _passengers apply {name _x;};
		//_passengersCurrent = count ((fullcrew [_x, "", false]) select {_x select 2 > -1});

		if (_passengersMax > 0) then {
			_briefingEntry = _briefingEntry + format [_font4 + "<br/>Passengers: " + _fontEnd + "<font size='16'>%1/%2</font><br/>",count _passengers, _passengersMax];
			{_briefingEntry = _briefingEntry + format [_font7 + "%1" + _fontEnd + "<br/>",_x];} forEach _passengers;
		};

		///////////////////////////////////////////////
		//CARGO
		///////////////////////////////////////////////
		
		_cargoItems = [[],[]];
		_cargoWeapons = [[],[]];
		_cargo = getWeaponCargo _x;
		
		//Separating weapons from binoculars etc
		{
			if (_x call _fnc_confType == 1 || _x call _fnc_confType == 2 || _x call _fnc_confType == 4 ) then {
				(_cargoWeapons select 0) pushBack _x;
				(_cargoWeapons select 1) pushBack ((_cargo select 1) select _forEachIndex);
			} else {
				(_cargoItems select 0) pushBack _x;
				(_cargoItems select 1) pushBack ((_cargo select 1) select _forEachIndex);
			};
		} forEach (_cargo select 0);
		
		//Adding the rest of the cargo items
		_cargo = getMagazineCargo _x;
		(_cargoItems select 0) append (_cargo select 0);
		(_cargoItems select 1) append (_cargo select 1);
		_cargo = getItemCargo _x;
		(_cargoItems select 0) append (_cargo select 0);
		(_cargoItems select 1) append (_cargo select 1);
		_cargo = getBackpackCargo _x;
		(_cargoItems select 0) append (_cargo select 0);
		(_cargoItems select 1) append (_cargo select 1);
		
		//add cargo title only if there is some cargo
		if((count (_cargoItems select 0) + count (_cargoWeapons select 0)) > 0) then {_briefingEntry = _briefingEntry + format [_font4 + "<br/>Cargo:" + _fontEnd];};

		//WEAPONS
		if(count (_cargoWeapons select 0) > 0) then {
			_briefingEntry = _briefingEntry + format ["<br/>Weapons:<br/>"];
			_briefingEntry = _briefingEntry + ([_cargoWeapons,80,40] call _fnc_formatItems);
		};

		//ITEMS
		if(count (_cargoItems select 0) > 0) then {
			_briefingEntry = _briefingEntry + format ["<br/>Magazines and items:<br/>"];
			_briefingEntry = _briefingEntry + ([_cargoItems,32,32] call _fnc_formatItems);
		};
		
		_briefingEntry = _briefingEntry + _divider;
		
		
		///////////////////////////////////////////////
		//Sort vehicles 
		///////////////////////////////////////////////
		
		_vehicleType = "";
		_vehicleType = getText(configFile >> "CfgVehicles" >> (typeOf _x) >> "vehicleClass");
		_vehicleType = toLower(getText(configFile >> "CfgVehicleClasses" >> _vehicleType >> "displayName"));
		_vehicleType = toArray(toUpper(_vehicleType select [0,1]) + _vehicleType);
		_vehicleType deleteAt 1;
		_vehicleType = toString(_vehicleType);
		if (_vehicleType == "") then {_vehicleType = "Misc";};
		
		//Stringien säilytys listaan luokittelun mukaan, muodossa [[STRING, LUOKITTELU, LUKUMÄÄRÄ], [..., ..., ...], ...]
		_found = false;	
		//Jos lista on tyhjä, lisätään uudeksi kohdaksi, muuten etsitään samammimistä kohtaa ja lisätään sen alle
		if (count _stringList == 0) then {_stringList pushBack [format [_font3 + "1. " + _fontEnd] + _briefingEntry, _vehicleType, 1];} else {
			{
				if ((_x select 1) == _vehicleType) then {
					_found = true;
					_x set [2,(_x select 2) + 1];
					_numStr = format [_font3 + "%1. " + _fontEnd,(_x select 2)];
					_x set [0,(_x select 0) + _numStr + _briefingEntry];
				};
			} forEach _stringList;
			
			//Jos samannimistä kohtaa ei löydy, lisätään uutena
			if (!_found) then {_stringList pushBack [format [_font3 + "1. " + _fontEnd] + _briefingEntry, _vehicleType, 1];};
		};
		
		_briefingEntry = "";
	};
} forEach vehicles;

if (count _stringList > 0) then {
	//Listan järjestäminen aakkosjärjestykseen
	_sorted = [];
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


	{player createDiaryRecord [_subject,[(_x select 1),(_x select 0) + _credits]];} forEach _sorted;
};