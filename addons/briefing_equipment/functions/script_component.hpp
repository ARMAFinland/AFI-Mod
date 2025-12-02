#include "..\script_component.hpp"

#define CREDITS 	format ["<br/>Click item count for more information.<br/><font color='#4F4F4F' size='8'>Script by Raimo @ ArmaFinland.fi</font><br/>"]
#define SUBJECT 	"Equipment"
#define DIVIDER 	"<br/>_________________________________________________________________________<br/>"
#define FONT_END 	"</font>"
#define FONT_0 		"<font color='#FFFFFF' size='14'>" //default text - colors are #RRGGBB in hex
#define FONT_1 		"<font color='#FFFFFF' size='18'>" //unit title
#define FONT_2 		"<font color='#FFFF00' size='14'>" //unit armament title
#define FONT_3 		"<font color='#FFFFFF' size='18'>" //vehicle title
#define FONT_4 		"<font color='#FFFF00' size='16'>" //vehicle armament title
#define FONT_5 		"<font color='#FFFF00' size='12'>" //turret role
#define FONT_6 		"<font color='#FFFFB2' size='14'>" //turret weapon ammo count
#define FONT_7 		"<font color='#FFFFFF' size='12'>" //crew/passenger names

#define MAGS_TO_BRIEF(TEXT,MAGS,UNIT)   _weaponBrief = _weaponBrief + "<br/>" + format [FONT_0 + TEXT + FONT_END] + ([MAGS,32,32,UNIT] call _fnc_formatItems) + "<br/>";  
