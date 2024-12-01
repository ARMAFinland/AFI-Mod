#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR,"3DEN","A3_Data_F"};
		author[] = {"Bummeri", "Tuntematon"};
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
	};
};
// configs go here
#include "\a3\3DEN\UI\resincl.inc"
#include "CfgEventHandlers.hpp"

class CfgMarkers {
	class Flag {// Your entity class
		class Attributes {// Entity attributes have no categories, they are all defined directly in class Attributes
			class hideMarkerWest {
				//--- Mandatory properties
				displayName = "Hide marker from West"; // Name assigned to UI control class Title
				tooltip = "Hides marker from certain sided players. Does not hide the marker in editor(SinglePlayer).Does hide it in editor(MP) and in other MP."; // Tooltip assigned to UI control class Title
				property = "afi_editorEnhancements_hideMarkerWest"; // Unique config property name saved in SQM
				control = "Checkbox"; // UI control base class displayed in Edit Attributes window, points to Cfg3DEN >> Attributes

				// Expression called when applying the attribute in Eden and at the scenario start
				// The expression is called twice - first for data validation, and second for actual saving
				// Entity is passed as _this, value is passed as _value
				// %s is replaced by attribute config name. It can be used only once in the expression
				// In MP scenario, the expression is called only on server.
				expression = "if (_value) then {[_this,0] remoteExecCall ['setMarkerAlphaLocal',west,true];};";

				// Expression called when custom property is undefined yet (i.e., when setting the attribute for the first time)
				// Entity is passed as _this
				// Returned value is the default value
				// Used when no value is returned, or when it's of other type than NUMBER, STRING or ARRAY
				// Custom attributes of logic entities (e.g., modules) are saved always, even when they have default value
				defaultValue = "False";

				//--- Optional properties
				unique = 0; // When 1, only one entity of the type can have the value in the mission (used for example for variable names or player control)
			};
			class hideMarkerEast: hideMarkerWest {
				displayName = "Hide marker from East";
				property = "afi_editorEnhancements_hideMarkerEast";
				expression = "if (_value) then {[_this,0] remoteExecCall ['setMarkerAlphaLocal',east,true];};";
			};
			class hideMarkerIndependent: hideMarkerWest {
				displayName = "Hide marker from Independent";
				property = "afi_editorEnhancements_hideMarkerIndependent";
				expression = "if (_value) then {[_this,0] remoteExecCall ['setMarkerAlphaLocal',Independent,true];};";
			};
			class hideMarkerCivilian: hideMarkerWest {
				displayName = "Hide marker from Civilians";
				property = "afi_editorEnhancements_hideMarkerCivilian";
				expression = "if (_value) then {[_this,0] remoteExecCall ['setMarkerAlphaLocal',Civilian,true];};";
			};
			class hideMarkerEveryone: hideMarkerWest {
				displayName = "Hide marker from every side";
				property = "afi_editorEnhancements_hideMarkerEveryone";
				expression = "if (_value) then {[_this,0] remoteExecCall ['setMarkerAlphaLocal',-2,true];};";
			};
		};
	};
};


class Cfg3DEN {
    // Configuration of all objects
    class Object {
        // Categories collapsible in "Edit Attributes" window
        class AttributeCategories {
            // Category class, can be anything
            class afi_editorEnhancements {
                displayName = "AFI Editor Enhancements"; // Category name visible in Edit Attributes window
                collapsed = 1; // When 1, the category is collapsed by default
                class Attributes {
                    class afi_editorEnhancements_skipDebug {
                        displayName = "Skip Debug for this object";
                        tooltip = "Dont run any debug on this object";
                        property = "afi_editorEnhancements_skipDebug";
                        control = "Checkbox";
                        expression = "_this setVariable ['Skip_Debug',_value,true];";
                        defaultValue = "false";
                        unique = 0;
                        condition = "objectSimulated";
                    };
                    class afi_editorEnhancements_brieffingEquipmentSideWest: afi_editorEnhancements_skipDebug {
                        displayName = "Show equipment to West";
                        tooltip = "Shows this vehicle/box and its inventory and weapon loadout at the brieffing for certain sided players. Only pick one side per object.";
                        property = "afi_editorEnhancements_brieffingEquipmentSideWest";
                        control = "Checkbox";
                        expression = "if (_value) then{_this setVariable ['AFI_vehicle_gear','west',true]};";
                        condition = "objectHasInventoryCargo + objectVehicle";
                    };
                    class afi_editorEnhancements_brieffingEquipmentSideEast: afi_editorEnhancements_brieffingEquipmentSideWest {
                        displayName = "Show equipment to East";
                        property = "afi_editorEnhancements_brieffingEquipmentSideEast";
                        expression = "if (_value) then{_this setVariable ['AFI_vehicle_gear','east',true]};";
                    };
                    class afi_editorEnhancements_brieffingEquipmentSideInd: afi_editorEnhancements_brieffingEquipmentSideWest {
                        displayName = "Show equipment to Independent";
                        property = "afi_editorEnhancements_brieffingEquipmentSideInd";
                        expression = "if (_value) then{_this setVariable ['AFI_vehicle_gear','guer',true]};";
                    };
                    class afi_editorEnhancements_brieffingEquipmentSideCivilian: afi_editorEnhancements_brieffingEquipmentSideWest {
                        displayName = "Show equipment to Civilian";
                        property = "afi_editorEnhancements_brieffingEquipmentSideCivilian";
                        expression = "if (_value) then{_this setVariable ['AFI_vehicle_gear','civ',true]};";
                    };
                };
            };
        };
    };
    class Mission {
		class GVAR(missionAttributes) { // Custom section class, everything inside will be opened in one window
			displayName = "AFI Mission Attributes"; // Text visible in the window title as "Edit: <displayName>"
			class AttributeCategories {
				// The following structure is the same as the one used for entity attributes
				class GVAR(viewDistance) {
					displayName = "Viewdistance";
                	collapsed = 0;
					class Attributes {
						class GVAR(enableViewdistance) {
							displayName = "Enable viewdistance change";
                        	tooltip = "Dont enable this if you set the viewdistance settings elsewhere";
							property = QGVAR(enableViewdistance);
	                        control = "CheckboxState";
	                        expression = "%s = _value;";
	                        defaultValue = "false";
	                        unique = 0;
						};
						class GVAR(viewdistance) {
							displayName = "Maximum viewdistance for players";
                        	tooltip = "User can adjust viewdistance up to this value while ingame. Min: 500, Max:12000.";
							property = QGVAR(viewdistance);
	                        control = "Edit";
							expression = "%s = _value;";
	                        defaultValue = "3000";
	                        unique = 0;
	                        validate = "number";
	                        typeName = "NUMBER";
						};
					};
				};
				class GVAR(safeStart) {
					displayName = "Safestart";
                	collapsed = 0;
					class Attributes {
						class GVAR(enableSafeStart) {
							displayName = "Enable safestart";
                        	tooltip = "Don't enable this if you start SafeStart elsewhere.";
							property = QGVAR(enableSafeStart);
	                        control = "CheckboxState";
							expression = "%s = _value;";
	                        defaultValue = "false";
	                        unique = 0;
						};
						class GVAR(safeStartLength) {
							displayName = "Safestart duration";
                        	tooltip = "Safestart duration";
							property = QGVAR(safeStartLength);
	                        control = "Edit";
	                        expression = "%s = _value;";
	                        defaultValue = "15";
	                        unique = 0;
	                        validate = "number";
	                        typeName = "NUMBER";
						};
					};
				};
				class GVAR(viewDistanceServer) {
					displayName = "Server viewdistance";
                	collapsed = 0;
					class Attributes {
						class GVAR(enableViewdistanceServer) {
							displayName = "Set server viewdistance";
                        	tooltip = "This will run only for dedicated. Basicly used to increase AI viewdistance";
							property = QGVAR(enableViewdistanceServer);
	                        control = "CheckboxState";
	                        expression = "%s = _value;";
	                        defaultValue = "false";
	                        unique = 0;
						};
						class GVAR(viewdistanceServer) {
							displayName = "Server viewdistance";
                        	tooltip = "This will run only for dedicated. Basicly used to increase AI viewdistance";
							property = QGVAR(viewdistanceServer);
	                        control = "Edit";
	                        expression = "%s = _value;";
	                        defaultValue = "3000";
	                        unique = 0;
	                        validate = "number";
	                        typeName = "NUMBER";
						};
					};
				};
			};
		};
	};
	class Groups {
		class AttributeCategories {
            class Init {
                class Attributes {
                    class Callsign {
                        unique = 0;
                    };
                };
            };
        };
	};

	// Container with all tutorials
	class Tutorials {
		// Category class. You can use one of the existing ones, or create a new one
		class GVAR(Editor_Tutorials) {
			displayName = "AFI Missions making"; // Name visible in the list. Don't define when you're using existing category!
			// Category sections
			class Sections {
				// Section class
				class GVAR(setGroupID) {
					displayName = "Set group ID"; // Name visible in the list
					// Individual tutorial steps (shown as post-it notes), sorted in-game as they appear here
					class Steps {
						// Classname can be anything
						class part1 {
							text = "In this window, you'll find the category OBJECT: INIT. Expand it if it's not already open. You'll likely see the following line: (group this) setGroupId ['xxxx']; We need to move this line to the group's init field. Copy and remove it from here, then close the attributes window and continue with this tutorial. If your init field is empty, you're likely following this tutorial manually, or you haven't set it yet. Just imagine the line being there as an example."; // Step text
							//highlight = IDC_DISPLAY3DEN_TOOLBAR_MISSION_MAP; // IDC of highlighted UI control (none by default)
							expression = QUOTE([1] call FUNC(groupIdTutorial)); // Code called when the step is displayed (before highlight)
							x = "safeZoneX + 0.1"; // Custom X coordinate (centered when undefined)
							y = "safeZoneY + 0.9"; // Custom Y coordinate (centered when undefined)
						};
						class part2: part1 {
							text = "Do the same here: open the composition's init field if it's not open already. Now, paste your code here, but modify it slightly. Replace (group this) with just this. Example: this setGroupId ['xxxx'];";
							expression = QUOTE([2] call FUNC(groupIdTutorial));
						};
						class part3 {
							text = "After fixing all the init fields, run Check Group IDs again. This will ensure you didn't miss any.";
						};
					};
				};
			};
		};
	};
};

class ctrlMenuStrip;
class display3DEN {
	class Controls {
		class MenuStrip: ctrlMenuStrip {
			class Items {
				class Tools {
					items[] += {QGVAR(commonToolFolder)};
				};
				class GVAR(commonToolFolder) {
					text = "AFI Common Tools";
					items[] = {QGVAR(commonSettingsSingleLife),QGVAR(commonSettingsRespawn),QGVAR(createSpectatorSlots),QGVAR(updateRoledescriptions),QGVAR(updateMinMaxPlayerCount),QGVAR(updateGroupIds)}; // ADD ALL TOOLS HERE
				};
				class GVAR(commonSettingsSingleLife) {
					text = "Update Mission Settings for single life";
					action = QUOTE([1] call FUNC(updateCommonSettings););
				};
				class GVAR(commonSettingsRespawn) {
					text = "Update Mission Settings for respawn";
					action = QUOTE([2] call FUNC(updateCommonSettings););
				};
				class GVAR(createSpectatorSlots) {
					text = "Create 50 spectator slots";
					action = QUOTE([] call FUNC(createSpectatorSlots););
				};
				class GVAR(updateRoledescriptions) {
					text = "Update Roledescriptions for selected units";
					action = QUOTE([] call FUNC(startUpdateRoleDescription););
				};
				class GVAR(updateMinMaxPlayerCount) {
					text = "Update MinMax playercount for mission";
					action = QUOTE([] call FUNC(updateMinMaxPlayers););
				};
				class GVAR(updateGroupIds) {
					text = "Check group IDs for selected units";
					action = QUOTE([get3DENSelected 'object'] call FUNC(updateGroupId););
				};
				class Attributes {
					items[] += {QGVAR(missionAttributes)};
				};
				class GVAR(missionAttributes) {
					text = "AFI Mission Attributes";
					action = QUOTE(edit3DENMissionAttributes QQGVAR(missionAttributes););
				};
			};
		};
	};
};