#include "script_component.hpp"
ADDON = false;

PREP_RECOMPILE_START;
#include "XEH_PREP.hpp"
PREP_RECOMPILE_END;

//DEFINE global VARIABLES

afi_aiSettings_mainClasses = ["Aircrew","Crew","Veteran","Regular","Irregular"]; //To add new ones first add them here and then create new eden editor attributes for them in the config. They are ordered alphabethically in cba setting menu.

afi_aiSettings_skillClasses = [
    "aimingShake",
    "aimingSpeed",
    "aimingAccuracy",
    "commanding",
    "courage",
    "general",
    "reloadSpeed",
    "spotDistance",
    "spotTime",
    "allowFleeing"
];

afi_aiSettings_skillClassTooltips = [
    "Affects how steadily the AI can hold a weapon (Higher value = less weapon sway).",
    "Affects how quickly the AI can rotate and stabilize its aim (Higher value = faster, less error).",
    "Affects how well the AI can lead a target. Affects how accurately the AI estimate range and calculates bullet drop. Affects how well the AI compensates for weapon dispersion and recoil. Affects how certain the AI must be about its aim on target before opening fire.",
    "Affects how quickly recognized targets are shared with the group (Higher value = faster reporting)",
    "Affects AI supression recovery. AI with final skill close to 1.0 does not suffer suppression. Just a few shots around a 0.2 skilled AI should disturb it's aiming for longer period (up to ~ 12s).",
    "Raw skill. Affects the AI's decision making",
    "Affects the delay between switching or reloading a weapon (Higher value = less delay).",
    "Affects the AI ability to spot targets within it's visual or audible range (Higher value = more likely to spot). Affects the accuracy of the information (Higher value = more accurate information).",
    "Affects how quick the AI react to death, damage or observing an enemy (Higher value = quicker reaction).",
    "1 - will flee constantly. 0.5 - will flee once group health has been halfway destroyed. 0 - will never flee. Units will flee to vehicles/initial waypoint/randomly."
];

//DEFINE CBA SETTINGS

{
    private _mainClass = _x;
    private _prettySubCategoryName = _mainClass; //Foreach main AI type, create a new subcategory
    {
        private _settingName = ["afi_aiSkillPreset",_mainClass,_x] joinString "_";
        private _prettyName = _x;
        private _tooltip = afi_aiSettings_skillClassTooltips select _forEachIndex;
        [
            _settingName, // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
            "SLIDER", // setting type
            [_prettyName,_tooltip], // Pretty name shown inside the ingame settings menu. Can be stringtable entry. Also tooltip.
            ["AFI Tweak - AI Skill Presets",_prettySubCategoryName], // Category for the settings menu + optional sub-category <STRING, ARRAY>
            [0, 1, 0.5, 2], // data for this setting: [min, max, default, number of shown trailing decimals]
            1 //all clients share the same setting
        ] call CBA_Settings_fnc_init;
    } forEach afi_aiSettings_skillClasses;
} forEach afi_aiSettings_mainClasses;

[
    "afi_aiSkillPreset_defaultBehaviour", // Internal setting name, should always contain a tag! This will be the global variable which takes the value of the setting.
    "CHECKBOX", // setting type
    ["Use 'regular' as default preset","If true, then every AI with no assigned AI preset will use the 'regular' preset. If false, then units with undefined preset will not be edited."], // Setting name shown, tooltip
    ["AFI Tweak - AI Skill Presets","-Default Behaviour-"], // Category for the settings menu + optional sub-category <STRING, ARRAY>
    false, //Default value of the setting.
    1 //all clients share the same setting
] call CBA_Settings_fnc_init;

ADDON = true;