# AFI Mod

AFI Mod is a collection of Arma 3 quality-of-life improvements and mission support components for AFI gameplay. The mod focuses on usability, setup flow, and server-side consistency without changing core weapon, ammo, or vehicle damage values.

## Requirements

- Arma 3
- CBA_A3
- ACE3
- HEMTT for building the mod

Other dependencies listed in the project are optional and only used by specific addons.

## Overview

The project is split into independent addons under the `addons/` folder. Each addon is self-contained and can be enabled or disabled independently as needed.

## Included addons

### Core gameplay and quality-of-life
- AI Skill Presets (`aisettings`)
  - Adds configurable AI skill presets.
- Allow Markers (`allow_markers`)
  - Restricts marker placement to selected channels after briefing and hides the default marker system.
- Briefing Equipment (`briefing_equipment`)
  - Adds a briefing tab with equipment info for each side.
- Chat Filter (`chatfilter`)
  - Filters repetitive system chat spam such as connection and kill notifications.
- Clutter Cutter (`cluttercutter`)
  - Adds an ACE interaction to remove clutter around the player.
- Confirm Start (`confirm_start`)
  - Requires an admin confirmation before a mission can begin from the briefing screen.
- Disable 3DEN Start Shortcut (`disable_3den_start_shortcut`)
  - Prevents accidental mission starts from the editor shortcut.
- Disable Gamma (`disable_gamma`)
  - Blocks the ability to adjust gamma during multiplayer missions.
- Enemy Radios (`enemy_radios`)
  - Adds an option to allow or disallow taking enemy-side radios.
- Enemy Vehicles (`enemy_vehicles`)
  - Adds settings to control access to enemy vehicles while leaving static vehicles unlocked.
- Engine Delay (`engine_delay`)
  - Expands ACE engine start delay logic, limits driver movement while the engine is starting, and displays startup timing feedback.
- Engine Delay 3CB Factions (`engine_delay_3cb_factions`)
  - Vehicle startup delay data for 3CB factions.
- Engine Delay RHS RU (`engine_delay_rhs_ru`)
  - Vehicle startup delay data for RHS Russian vehicles.
- Engine Delay RHS US (`engine_delay_rhs_us`)
  - Vehicle startup delay data for RHS US vehicles.
- Knocking (`knocking`)
  - Adds vehicle knocking functionality.
- Main (`main`)
  - Includes base AFI settings such as ambient environment and remote sensor toggles, and disables profile glasses.
- Repair (`repair`)
  - Adjusts repair timing to reduce rapid post-damage repair loops.
- Safestart (`safestart`)
  - Adds AFI safestart handling.
- Viewdistance (`viewdistance`)
  - Adds hotkeys to adjust view distance.
- Volume Control (`volume_control`)
  - Adds hotkeys to adjust volume.
- World Grid (`world_grid`)
  - Adds per-map terrain grid settings through CBA.

### Editor and mission tools
- Editor Enhancements (`editor_enhancements`)
  - Adds editor utilities, marker visibility controls, briefing equipment display, and mission attribute helpers.
- Mission Debug (`missiondebug`)
  - Basic debugging utilities for AFI missions.
- Mission Framework (`mission_framework`)
  - Provides framework support for AFI mission setups.
- ORBAT Export (`orbat_export`)
  - Adds ORBAT export tools for 3DEN event JSON exports.
- CBA Settings Whitelist (`cba_settings_whitelist`)
  - Restricts which users are allowed to modify CBA settings.
- Logo (`logo`)
  - Adds AFI branding to the splash screen and custom server join buttons in the menu.

### Maps and compatibility fixes
- Aliabad Fix (`aliabad_fix`)
  - Map-specific compatibility fix.
- FATA Fix (`fata_fix`)
  - Fixes issues on the FATA map and supports related tunnel functionality.
- Hellanmaa / Ihantala Snow Fixes (`hellanmaaw`, `ihantalaw`, `winter_footsteps_tolvajarvi`)
  - Corrects snow sound behavior and footsteps on affected maps.
- BWA XEH Fix (`bwa_xeh_fix`)
  - Compatibility fix for XEH behavior.
- IFA Fix (`ifa_fix`)
  - Compatibility fix for IFA-related content.
- TBD MTLB XEH Fix (`tbd_mtlb_xeh_fix`)
  - Adds a compatibility fix for the TBD MTLB.

## Build and development

This project is built using [HEMTT](https://github.com/BrettMayson/HEMTT).

Common commands:
- `build_dev.bat` - builds the mod in development mode
- `build_release.bat` - produces a release build
- `build.bat` - general build entry point
- `buld_test.bat` - launches the mod for local testing
- `debugMultiplayer.bat` - starts a local multiplayer debug setup

Standard HEMTT usage:
- `hemtt build`
- `hemtt dev`
- `hemtt release`

## Notes

- This mod is designed as a modular AFI toolkit rather than a single monolithic package.
- Addons are intended to be independent where possible, while still sharing the same CBA/ACE foundation.
- Most configuration and logic is managed through addon-specific config files and CBA settings.

## License

This project is distributed as part of the AFI Mod package and follows the repository's existing licensing and distribution terms.
