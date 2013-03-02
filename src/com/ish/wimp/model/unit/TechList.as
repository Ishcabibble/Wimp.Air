package com.ish.wimp.model.unit {
	public class TechList {
		private var inf : int;
		private var veh : int;
		private var aer : int;
		private var nav : int;
		private var nuk : int;
		
		public function TechList( inf : int, veh : int, aer : int, nav : int, nuk : int ) {
			this.inf = inf;
			this.veh = veh;
			this.aer = aer;
			this.nav = nav;
			this.nuk = nuk;
		}
		
		public function getInf() : int { return inf; }
		public function getVeh() : int { return veh; }
		public function getAer() : int { return aer; }
		public function getNav() : int { return nav; }
		public function getNuk() : int { return nuk; }
	}
}