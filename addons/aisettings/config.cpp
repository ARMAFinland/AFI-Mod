#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR,"3DEN","cba_main","cba_xeh","cba_settings"};
		author[] = {"Bummeri","Tuntematon"};
		authorUrl = GITHUBLINK;
		skipWhenMissingDependencies = 1;
		VERSION_CONFIG;
	};
};
// configs go here
#include "CfgEventHandlers.hpp"

class Cfg3DEN
{
	// Configuration of all objects
	class Object
	{
		// Categories collapsible in "Edit Attributes" window
		class AttributeCategories
		{
			// Category class, can be anything
			class afi_aiSkills
			{
				displayName = "AFI AI Skills"; // Category name visible in Edit Attributes window
				collapsed = 1; // When 1, the category is collapsed by default
				class Attributes
				{
					// Attribute class, can be anything
					class afi_aiSkillPresets_Irregular
					{
						//--- Mandatory properties
						displayName = "AI Skill Preset: Irregular"; // Name assigned to UI control class Title
						tooltip = "Set AI skills to the level of irregular fighters. Select only one of these for each unit!"; // Tooltip assigned to UI control class Title
						property = "afi_aiSkillPresets_Irregular"; // Unique config property name saved in SQM
						control = "Checkbox"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes

						// Expression called when applying the attribute in Eden and at the scenario start
						// The expression is called twice - first for data validation, and second for actual saving
						// Entity is passed as _this, value is passed as _value
						// %s is replaced by attribute config name. It can be used only once in the expression
						// In MP scenario, the expression is called only on server.
						expression = "if (_value) then {_this setvariable ['afi_aiSkillPreset','Irregular'];};";

						// Expression called when custom property is undefined yet (i.e., when setting the attribute for the first time)
						// Entity is passed as _this
						// Returned value is the default value
						// Used when no value is returned, or when it's of other type than NUMBER, STRING or ARRAY
						// Custom attributes of logic entities (e.g., modules) are saved always, even when they have default value
						defaultValue = "false";

						//--- Optional properties
						unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
						condition = "objectBrain"; // Condition for attribute to appear (see the table below)
					};

					class afi_aiSkillPresets_Regular : afi_aiSkillPresets_Irregular
					{
						displayName = "AI Skill Preset: Regular";
						tooltip = "Set AI skills to the level of regular fighters. Select only one of these for each unit!";
						property = "afi_aiSkillPresets_Regular";
						expression = "if (_value) then {_this setvariable ['afi_aiSkillPreset','Regular'];};";
					};

					class afi_aiSkillPresets_Veteran : afi_aiSkillPresets_Irregular
					{
						displayName = "AI Skill Preset: Veteran";
						tooltip = "Set AI skills to the level of veteran fighters. Select only one of these for each unit!";
						property = "afi_aiSkillPresets_Veteran";
						expression = "if (_value) then {_this setvariable ['afi_aiSkillPreset','Veteran'];};";
					};

					class afi_aiSkillPresets_Crew : afi_aiSkillPresets_Irregular
					{
						displayName = "AI Skill Preset: Crew";
						tooltip = "Set AI skills to levels appropriate for vehicle operators. Select only one of these for each unit!";
						property = "afi_aiSkillPresets_Crew";
						expression = "if (_value) then {_this setvariable ['afi_aiSkillPreset','Crew'];};";
					};

					class afi_aiSkillPresets_Aircrew : afi_aiSkillPresets_Irregular
					{
						displayName = "AI Skill Preset: Aircrew";
						tooltip = "Set AI skills to levels appropriate for Airvehicle operators. Select only one of these for each unit!";
						property = "afi_aiSkillPresets_Aircrew";
						expression = "if (_value) then {_this setvariable ['afi_aiSkillPreset','Aircrew'];};";
					};

					class afi_aiSkills_CrewInImmobile : afi_aiSkillPresets_Irregular //Might not work anymore if the units are not on careless permanently.
					{
						displayName = "Stay In Immobile";
						tooltip = "Usually AI disembark from mobility kills. Enable this to make AI continue operate this vehicle even if it is made immobile.";
						property = "afi_aiSkills_AllowInImmobile";
						expression = "_this allowCrewInImmobile true;";
						condition = "objectVehicle";
					};
				};
			};
		};
	};
};