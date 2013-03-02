package com.ish.wimp.model.unit {
	public class AttackList {
		private var ground : int;
		private var air : int;
		private var naval : int;
		private var sub : int;
		private var missile : int;
		
		public function AttackList( ground : int, air : int, naval : int, sub : int, missile : int ) {
			this.ground = ground;
			this.air = air;
			this.naval = naval;
			this.sub = sub;
			this.missile = missile;
		}
		
		public function getGround() : int { return ground; }
		public function getAir() : int { return air; }
		public function getNaval() : int { return naval; }
		public function getSub() : int { return sub; }
		public function getMissile() : int { return missile; }
	}
}