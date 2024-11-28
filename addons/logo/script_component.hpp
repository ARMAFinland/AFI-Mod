#define COMPONENT logo
#define COMPONENT_BEAUTIFIED logo
#include "\x\afi\addons\main\script_mod.hpp"

// #define DEBUG_MODE_FULL
// #define DISABLE_COMPILE_CACHE

#ifdef DEBUG_ENABLED_MAIN
	#define DEBUG_MODE_FULL
#endif

#include "\x\afi\addons\main\script_macros.hpp"




// Static styles
#define ST_POS			0x0F
#define ST_HPOS		   0x03
#define ST_VPOS		   0x0C
#define ST_LEFT		   0x00
#define ST_RIGHT		  0x01
#define ST_CENTER		 0x02
#define ST_DOWN		   0x04
#define ST_UP			 0x08
#define ST_VCENTER		0x0C

#define ST_TYPE		   0xF0
#define ST_SINGLE		 0x00
#define ST_MULTI		  0x10
#define ST_TITLE_BAR	  0x20
#define ST_PICTURE		0x30
#define ST_FRAME		  0x40
#define ST_BACKGROUND	 0x50
#define ST_GROUP_BOX	  0x60
#define ST_GROUP_BOX2	 0x70
#define ST_HUD_BACKGROUND 0x80
#define ST_TILE_PICTURE   0x90
#define ST_WITH_RECT	  0xA0
#define ST_LINE		   0xB0
#define ST_UPPERCASE	  0xC0
#define ST_LOWERCASE	  0xD0

#define ST_SHADOW		 0x100
#define ST_NO_RECT		0x200
#define ST_KEEP_ASPECT_RATIO  0x800


// Default grid
#define GUI_GRID_WAbs			((safezoneW / safezoneH) min 1.2)
#define GUI_GRID_HAbs			(GUI_GRID_WAbs / 1.2)
#define GUI_GRID_W			(GUI_GRID_WAbs / 40)
#define GUI_GRID_H			(GUI_GRID_HAbs / 25)
#define GUI_GRID_X			(safezoneX)
#define GUI_GRID_Y			(safezoneY + safezoneH - GUI_GRID_HAbs)

// Default text sizes
#define GUI_TEXT_SIZE_SMALL		(GUI_GRID_H * 0.8)
#define GUI_TEXT_SIZE_MEDIUM		(GUI_GRID_H * 1)
#define GUI_TEXT_SIZE_LARGE		(GUI_GRID_H * 1.2)
