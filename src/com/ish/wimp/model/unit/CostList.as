package com.ish.wimp.model.unit {
	public class CostList {
		private var food : int;
		private var minerals : int;
		private var iron : int;
		private var oil : int;
		private var pMetals : int;
		private var uranium : int;
		private var ecs : int;
		
		public function CostList( food : int = 0, minerals : int = 0, iron : int = 0, oil : int = 0, pMetals : int = 0, uranium : int = 0, ecs : int = 0 ) {
			this.food = food;
			this.minerals = minerals;
			this.iron = iron;
			this.oil = oil;
			this.pMetals = pMetals;
			this.uranium = uranium;
			this.ecs = ecs;
		}
		
		public function getFood() : int { return food; }
		public function getMinerals() : int { return minerals; }
		public function getIron() : int { return iron; }
		public function getOil() : int { return oil; }
		public function getPMetals() : int { return pMetals; }
		public function getUranium() : int { return uranium; }
		public function getEcs() : int { return ecs; }
		
		public function setFood( value : int ) : void { food = value; }
		public function setMinerals( value : int ) : void { minerals = value; }
		public function setIron( value : int ) : void { iron = value; }
		public function setOil( value : int ) : void { oil = value; }
		public function setPMetals( value : int ) : void { pMetals = value; }
		public function setUranium( value : int ) : void { uranium = value; }
		public function setEcs( value : int ) : void { ecs = value; }
	}
}