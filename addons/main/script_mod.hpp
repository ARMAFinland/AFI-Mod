#define MAINPREFIX x
#define PREFIX afi

#include "script_version.hpp"

#define VERSION MAJOR.MINOR
#define VERSION_AR MAJOR,MINOR,PATCH,BUILD

#define REQUIRED_VERSION 2.20

#ifdef COMPONENT_BEAUTIFIED
	#define COMPONENT_NAME QUOTE(ADDON - COMPONENT_BEAUTIFIED)
#else
	#define COMPONENT_NAME QUOTE(ADDON - COMPONENT)
#endif
