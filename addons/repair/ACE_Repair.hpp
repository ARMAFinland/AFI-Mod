class ACE_Repair
{
	class Actions
	{
		class ReplaceWheel {
			repairingTime = 90;
		};
		
		class RemoveWheel: ReplaceWheel {
			repairingTime = 45;
		};
		
		class PatchWheel: ReplaceWheel {
			repairingTime = 45;
		};
		
		class MiscRepair: ReplaceWheel {
			repairingTime = 180;
		};
		
		class RepairTrack: MiscRepair {
			repairingTime = 180;
		};
		
		class RemoveTrack: MiscRepair {
			repairingTime = 90;
		};
		
		class ReplaceTrack: RemoveTrack {
			repairingTime = 180;
		};
		
		// class FullRepair: MiscRepair {
		// 	repairingTime = 300;			
		// };
	};
};

