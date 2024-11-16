This mod is build using [HEMTT](https://github.com/BrettMayson/HEMTT)

# Engine start (Engine delay) 
- Expands ace engine start delay system.
  - Disables drivers ability to use vehicle movement keys, should prvent tyres and tracks moving but vehicle staying in position.
  - onEngineOff, it will do linearConversion on the next vehicle start up delay. It will take 3x time of the default startup delayt to get back to that. This allows vehicles to start moving faster soon after shutting engine down. 
- Adds different delay times to at least all land vehicles.
- Add hint to the driver that shows how long starting engine takse.
- Splitted both RHS RU, US and 3cb factions to seperate mods that only loads if those mods are present. Minor nano secod savings due to not creating config classes to these.

# Make snow maps not sound like raining
- add missing config entry-
- TODO: add automatic script to force update that, as it is currenlty broken due to arma

# Knocking
- vehicle knocking

# Logo
- Add afi logo on splash screen
- Add buttons to join servers to main menu

# Mission debug
- Some basic AFI mission debug features 

# Repair
- Tweak repair times to be higher. Aim is to prevent 1min repair after mobility kill.
