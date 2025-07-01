class CfgSounds {
	sounds[] = {QGVAR(knockMetal),QGVAR(knockMetalInside)};
	class GVAR(knockMetal) {
		name = QGVAR(knockMetal);
		sound[] = {QPATHTOF(sounds\knockMetal.ogg),25,1,25};
		titles[] = {};
	};
	class GVAR(knockMetalInside) {
		name = QGVAR(knockMetalInside);
		sound[] = {QPATHTOF(sounds\knockMetal.ogg),2,1};
		titles[] = {};
	};
};
