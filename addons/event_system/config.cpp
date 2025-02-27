#include "script_component.hpp"

// information on this addon specifically
class CfgPatches {
	class ADDON {
		name = COMPONENT_NAME;
		units[] = {};
		weapons[] = {};
		requiredVersion = REQUIRED_VERSION;
		requiredAddons[] = {MAIN_ADDON_STR,"afi_editor_enhancements"};
		author[] = {"Raimo","Tikka","Cultti","Tuntematon"};
		authorUrl = GITHUBLINK;
		VERSION_CONFIG;
	};
};
// configs go here
#include "\a3\3den\UI\resincl.inc"
#include "CfgEventHandlers.hpp"


class Cfg3DEN {
	// Configuration of all objects
	class Object {
		// Categories collapsible in "Edit Attributes" window
		class AttributeCategories {
			// Category class, can be anything
			class Control {
				class Attributes {
					class GVAR(unitAdditionalDescription) {
						displayName = "AFI event unit description";
						tooltip = "Only used in the export JSON tool.";
						property = QGVAR(unitAdditionalDescription) ;
						control = "Edit";
						defaultValue = """""";
						unique = 0;
						condition = "objectControllable + objectVehicle";
                    };
					class GVAR(vehicleSide) {
						displayName = "AFI event vehicle side";
						tooltip = "Only used in the export JSON tool.";
						property = QGVAR(vehicleSide) ;
						control = "combo";
						defaultValue = -1;
						unique = 0;
						condition = "objectVehicle";
						typeName = "NUMBER";

						class Values {
							class Blufor {
								name = "Blufor";
								value = 0;
							};

							class Opfor {
								name = "Opfor";
								value = 1;
							};

							class Indfor {
								name = "Indfor";
								value = 2;
							};

							class Civilian {
								name = "Civilian";
								value = 3;
							};

							class None {
								name = "None";
								value = -1;
							};
						};
                    };
                };
            };
        };
    };

	class Group {
		class AttributeCategories {
			class Init {
				class Attributes {
					class GVAR(groupAdditionalDescription) {
						displayName = "AFI event group description";
						tooltip = "Only used in the export JSON tool.";
						property = QGVAR(groupAdditionalDescription);
						control = "Edit";
						defaultValue = """""";
						unique = 0;
					};

					class GVAR(platoonAdditionalDescription) : GVAR(groupAdditionalDescription) {
						displayName = "AFI event platoon description";
						tooltip = "Only the first group platoon description is used for each platoon. Only used in the export JSON tool.";
						property = QGVAR(platoonAdditionalDescription);
					};
				};
			};
		};
	};
	class Mission {
		class EGVAR(editor_enhancements,missionAttributes) { // Custom section class, everything inside will be opened in one window
			displayName = "AFI Mission Attributes"; // Text visible in the window title as "Edit: <displayName>"
			class AttributeCategories {
				// The following structure is the same as the one used for entity attributes
				class GVAR(OrbatSideDataWest) {
					displayName = "Blufor orbat info";
					class Attributes {
						class GVAR(enableSideDataWest) {
							displayName = "Enable export";
							tooltip = "When enabled, the export JSON tool will export this side.";
							property = QGVAR(enableSideDataWest);
							control = "CheckboxState";
							//expression = "%s = _value;";
							defaultValue = "false";
							unique = 0;
						};
						class GVAR(sideNameWest) {
							displayName = "Side name";
							tooltip = "Leave empty to use the default. Only used in the export JSON tool.";
							property = QGVAR(sideNameWest);
							control = "Edit";
							//expression = "%s = _value;";
							defaultValue = QUOTE(QUOTE("Blufor"));
							unique = 0;
							//validate = "string";
							typeName = "STRING";
						};
						class GVAR(sideDescriptionWest) : GVAR(sideNameWest) {
							displayName = "Side description";
							tooltip = "Additional info you want to be shown for this side on the AFI event page. Only used in the export JSON tool.";
							property = QGVAR(sideDescriptionWest);
							//expression = "%s = _value;";
							defaultValue = """""";
						};
					};
				};
				
				class GVAR(OrbatSideDataEast) : GVAR(OrbatSideDataWest) {
					displayName = "Opfor orbat info";
					class Attributes : Attributes {
						class GVAR(enableSideDataEast) : GVAR(enableSideDataWest) {
							property = QGVAR(enableSideDataEast);
							control = "CheckboxState";
						};
						class GVAR(sideNameEast) : GVAR(sideNameWest) {
							property = QGVAR(sideNameEast);
							defaultValue = QUOTE(QUOTE("Opfor"));
						};
						class GVAR(sideDescriptionEast) : GVAR(sideDescriptionWest) {
							property = QGVAR(sideDescriptionEast);
						};
					};
				};
				
				class GVAR(OrbatSideDataResistance) : GVAR(OrbatSideDataWest) {
					displayName = "Indfor orbat info";
					class Attributes : Attributes {
						class GVAR(enableSideDataResistance) : GVAR(enableSideDataWest) {
							property = QGVAR(enableSideDataResistance);
							control = "CheckboxState";
						};
						class GVAR(sideNameResistance) : GVAR(sideNameWest) {
							property = QGVAR(sideNameResistance);
							defaultValue = QUOTE(QUOTE("Indfor"));
						};
						class GVAR(sideDescriptionResistance) : GVAR(sideDescriptionWest) {
							property = QGVAR(sideDescriptionResistance);
						};
					};
				};
				
				class GVAR(OrbatSideDataCivilian) : GVAR(OrbatSideDataWest) {
					displayName = "Civilian orbat info";
					class Attributes : Attributes {
						class GVAR(enableSideDataCivilian) : GVAR(enableSideDataWest) {
							property = QGVAR(enableSideDataCivilian);
							control = "CheckboxState";
						};
						class GVAR(sideNameCivilian) : GVAR(sideNameWest) {
							property = QGVAR(sideNameCivilian);
							defaultValue = QUOTE(QUOTE("Civilian"));
						};
						class GVAR(sideDescriptionCivilian) : GVAR(sideDescriptionWest) {
							property = QGVAR(sideDescriptionCivilian);
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
				class EGVAR(editor_enhancements,commonToolFolder) {
					text = "AFI Common Tools";
					items[] += {QGVAR(rosterExport)}; // ADD ALL TOOLS HERE
				};
				class GVAR(rosterExport) {
					text = "Export orbat to JSON";
					action = QUOTE([] call FUNC(rosterExport););
				};
			};
		};
	};
};