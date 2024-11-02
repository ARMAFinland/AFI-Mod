class CfgVehicles {
	class LandVehicle;

	class Car: LandVehicle {
		ace_vehicles_engineStartDelay  = 2;
	};

	class Car_F: Car { };

	class Truck_F: Car_F {
		ace_vehicles_engineStartDelay  = 3;
	};

	class MRAP_01_base_F: Car_F {
		ace_vehicles_engineStartDelay  = 3;
	};

	class MRAP_02_base_F: Car_F {
		ace_vehicles_engineStartDelay  = 3;
	};

	class MRAP_03_base_F: Car_F {
		ace_vehicles_engineStartDelay  = 3;
	};

	class Quadbike_01_base_F: Car_F {
		ace_vehicles_engineStartDelay  = 1.3;
	};

	class Kart_01_Base_F: Car_F {
		ace_vehicles_engineStartDelay  = 1.3;
	};

	class Wheeled_APC_F: Car_F {
		ace_vehicles_engineStartDelay  = 4;
	};
	
	class Tractor_01_base_F: Car_F {
		ace_vehicles_engineStartDelay  = 4;
	};

	//Mopot
	class Motorcycle: LandVehicle {
		ace_vehicles_engineStartDelay  = 0;
	};

	//Tanks
	class Tank: LandVehicle {
		ace_vehicles_engineStartDelay  = 5;
	};

	class Tank_F: Tank { };

	class MBT_01_base_F: Tank_F {
		ace_vehicles_engineStartDelay  = 10;
	};

	class MBT_02_base_F: Tank_F {
		ace_vehicles_engineStartDelay  = 10;
	};

	class MBT_03_base_F: Tank_F {
		ace_vehicles_engineStartDelay  = 10;
	};

	class APC_Tracked_01_base_F: Tank_F {
		ace_vehicles_engineStartDelay  = 7;
	};

	class APC_Tracked_02_base_F: Tank_F {
		ace_vehicles_engineStartDelay  = 7;
	};

	class APC_Tracked_03_base_F: Tank_F {
		ace_vehicles_engineStartDelay  = 7;
	};

	class MBT_04_base_F: Tank_F {
		ace_vehicles_engineStartDelay  = 10;
	};
};
