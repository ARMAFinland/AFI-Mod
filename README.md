# Afi-mod

This mod adds AFI QOL improvements and tweaks/add some mechanics without altering damage values for weapons, ammo, or vehicles.  
Ace and cba are only mods that are required, others are optional.  
This mod is build using [HEMTT](https://github.com/BrettMayson/HEMTT)

## AI Skill Presets
- Add different presets for AI skils

## Allow markers
- Add cba setting to enable/disable ability to place markers in specific channels using SWT after briefing.
- Hides vanilla marker system.

## Briefing equipment
- Adds briefing tab with equipment of each side.

## CBA settings whitelist
-  Whitelist who can change cba settings

## Chat filter
- Filters all systemChat messages out. Should prevent connected, killed etc. messages

## Clutter cutter
- Adds ace action to remove clutter around player


## Confirm start
- During briefing screen, require admin to confirm starting game. Prevents acidental clicking it.

## Disable gamme
- Disables players ability to change gamma settings during MP mission.

## Enemy radio
-  Add cba setting to enable/disable ability to take enemy sides radios

## Enemy vehicles
-  Add cba setting to enable/disable ability to use enemy vehicles.
-  Defaulty allows usage of cars, but that can be also toggled from settings.
-  Static vehicles are never locked.

## Engine start (Engine delay) 
- Expands ace engine start delay system.
  - Disables drivers ability to use vehicle movement keys, should prvent tyres and tracks moving but vehicle staying in position.
  - onEngineOff, it will do linearConversion on the next vehicle start up delay. It will take 3x time of the default startup delayt to get back to that. This allows vehicles to start moving faster soon after shutting engine down. 
- Adds different delay times to at least all land vehicles.
- Add hint to the driver that shows how long starting engine takse.
- Splitted both RHS RU, US and 3cb factions to seperate mods that only loads if those mods are present. Minor nano secod savings due to not creating config classes to these.

## Make snow maps not sound like raining
- add missing config entry
- TODO: add automatic script to force update that, as it is currenlty broken due to arma

## Knocking
- vehicle knocking

## Logo
- Add afi logo on splash screen
- Add buttons to join servers to main menu

## Main
- Disables profile glasses.
- Add cba setting to disable [ambient animals](https://community.bistudio.com/wiki/enableEnvironment)
- Add cba setting to disable [remoteSensors](https://community.bistudio.com/wiki/disableRemoteSensors)

## Mission debug
- Some basic AFI mission debug features 

## Repair
- Tweak repair times to be higher. Aim is to prevent 1min repair after mobility kill.

## Safestart
- Add AFI safestart system

## World grid
-  Add CBA setting to specify  [terrain resolution](https://community.bistudio.com/wiki/setTerrainGrid) for each map individually.
