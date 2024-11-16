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
			repairingTime = 300;
		};
		
		class RepairTrack: MiscRepair {
			repairingTime = 300;
		};
		
		class RemoveTrack: MiscRepair {
			repairingTime = 120;
		};
		
		class ReplaceTrack: RemoveTrack {
			repairingTime = 300;
		};
		
		// class FullRepair: MiscRepair {
		// 	repairingTime = 300;			
		// };
	};
};