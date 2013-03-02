package com.ish.wimp.model.unit {
	import mx.collections.ArrayList;

	public class UnitInfo {
		private var type : String;
		private var code : String;
		private var name : String;
		private var notes : ArrayList;
		private var tech : TechList;
		private var cost : CostList;
		private var atk : AttackList;
		private var def : int;
		private var capacity : ArrayList;		// later ....
		private var maxNuke : int;				// later ....
		private var dropRange : int;			// later ....
		private var minLaunch : int;			// later ....
		private var maxLaunch : int;			// later ....
		
		public function UnitInfo( type : String, code : String, name : String, notes : ArrayList, tech : TechList, cost : CostList, atk : AttackList, def : int,
								  capacity : ArrayList = null, maxNuke : int = 0, dropRange : int = 0, minLaunch : int = 0, maxLaunch : int = 0 ) {
			this.type = type;
			this.code = code;
			this.name = name;
			this.notes = notes;
			this.tech = tech;
			this.cost = cost;
			this.atk = atk;
			this.def = def;
			this.capacity = capacity;
			this.maxNuke = maxNuke;
			this.dropRange = dropRange;
			this.minLaunch = minLaunch;
			this.maxLaunch = maxLaunch;
		}
		
		public function getType() : String { return type; }
		public function getCode() : String { return code; }
		public function getName() : String { return name; }
		public function getNotes() : ArrayList { return notes; }
		public function getTech() : TechList { return tech; }
		public function getCost() : CostList { return cost; }
		public function getAtk() : AttackList { return atk; }
		public function getDef() : int { return def; }
		public function getCapacity() : ArrayList { return capacity; }
		public function getMaxNuke() : int { return maxNuke; }
		public function getDropRange() : int { return dropRange; }
		public function getMinLaunch() : int { return minLaunch; }
		public function getMaxLaunch() : int { return maxLaunch; }
	}
}