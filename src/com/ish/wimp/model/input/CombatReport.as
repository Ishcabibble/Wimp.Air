package com.ish.wimp.model.input {
	import mx.collections.ArrayList;

	public class CombatReport {
		private var hex : int;
		private var hexName : String;
		private var combatType : String;
		private var combatElementList : ArrayList;
		
		public function CombatReport( hex : int, hexName : String, combatType : String, combatElementList : ArrayList = null ) {
			this.hex = hex;
			this.hexName = hexName;
			this.combatType = combatType;
			this.combatElementList = combatElementList;
		}
		
		public function getHex() : int { return hex; }
		public function getHexName() : String { return hexName; }
		public function getCombatType() : String { return combatType; }
		public function getCombatElementList() : ArrayList { return combatElementList; }
		
		public function setCombatElementList( value : ArrayList ) : void { combatElementList = value; }
	}
}