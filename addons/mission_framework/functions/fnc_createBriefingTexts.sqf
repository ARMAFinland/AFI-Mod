/*
 * Author: [Tuntematon]
 * [Description]
 * 
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


if (GVAR(addRules)) then {
	player createDiaryRecord ["Diary",["General AFI Rules",
	"1. Be polite, kind and consider others in all situations
	<br/>2. Play fair. Do not cheat, hack or ghost.
	<br/>3. Follow instructions from event hosts and admins
	<br/>4. Act according to your leader`s intent and stick with your squad
	<br/>5. Do not use enemy vehicles or equipment (hats, vests, weapons) unless the mission allows it or sides use the same gear. Common items (bandages, etc.) are allowed.	
	<br/>6. Do not misuse markers (e.g., false enemy positions, trolling)
	<br/>7. Do not solo. Stay with friendly forces. If separated, regroup ASAP.
	<br/>8. Do not loot bodies for extra gear at mission start unless instructed
	<br/>9. Do not intentionally ram vehicles, objects, or structures with any vehicle (land, air, water or spacecraft)
	<br/>*Note: These are generic rules. Missions may override them.*"
	]];
};

if (GVAR(addGeneralInfo)) then {
	player createDiaryRecord ["Diary",["Mod and Game Mechanic Info",
	"--Volume and View Distance Adjustments--  
	<br/>Use F1-F4 keys to adjust audio volume and view distance (within mission limits).  
	<br/>  
	<br/>--Suppression and Weapon Sway--  
	<br/>AFI uses suppression and sway mods. Near misses cause vision effects and increased sway. Rapid fire also increases sway.  
	<br/>  
	<br/>--Wave Respawn--  
	<br/>If the mission uses wave respawn, players respawn in groups. During downtime, you can talk with others waiting to respawn.  
	<br/>  
	<br/>--Markers--  
	<br/>We use Sweet Markers System. You cannot place markers during play.  
	<br/>  
	<br/>--ACE3 A-Medical--  
	<br/>Wounds can reopen. Splints heal limb damage. Epinephrine wakes up unconscious patients quickly if vitals are stable. Everyone can use epinephrine.  
	<br/>  
	<br/>--Safestart Time--  
	<br/>Missions start with a timer where units cannot take damage or fire. Additional rules may be listed in briefing notes.  
	<br/>  
	<br/>--Admin Call--  
	<br/>Use the “Call Admin” action in the ESC menu during a mission.  
	<br/>  
	<br/>--JIP (Join In Progress)--  
	<br/>JIP is enabled in respawn missions. Behavior depends on mission settings.  
	<br/>  
	<br/>--Radios--  
	<br/>You cannot pick up enemy radios. Change channels via self-interaction or briefing notes.  
	<br/>  
	<br/>--Friendly Forces--  
	<br/>See your side`s equipment, vehicles, and troop positions in briefing notes and on the map.  
	<br/>  
	<br/>--ACE Hearing--  
	<br/>ACE Hearing is disabled.  
	<br/>  
	<br/>*Note: These are generic infos. Missions may change them.*"
	]];	
};
