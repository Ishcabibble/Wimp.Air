package com.ish.wimp.model {
	public class ExpenseLineModel {
		public function ExpenseLineModel( food : int = 0, minerals : int = 0, iron : int = 0, oil : int = 0, pMetals : int = 0, uranium : int = 0, ecs : int = 0 ) {
			Food = food;
			Minerals = minerals;
			Iron = iron;
			Oil = oil;
			PMetals = pMetals;
			Uranium = uranium;
			Ecs = ecs;
		}
		
		private var foodString : String;
		private var mineralsString : String;
		private var ironString : String;
		private var oilString : String;
		private var pMetalsString : String;
		private var uraniumString : String;
		private var ecsString : String;
		
		private var food : int;
		private var minerals : int;
		private var iron : int;
		private var oil : int;
		private var pMetals : int;
		private var uranium : int;
		private var ecs : int;
		
		[Bindable] public function get FoodString( ) : String { return foodString; }
		[Bindable] public function get MineralsString( ) : String { return mineralsString; }
		[Bindable] public function get IronString( ) : String { return ironString; }
		[Bindable] public function get OilString( ) : String { return oilString; }
		[Bindable] public function get PMetalsString( ) : String { return pMetalsString; }
		[Bindable] public function get UraniumString( ) : String { return uraniumString; }
		[Bindable] public function get EcsString( ) : String { return ecsString; }
		
		[Bindable] public function get Food( ) : int { return food; }
		[Bindable] public function get Minerals( ) : int { return minerals; }
		[Bindable] public function get Iron( ) : int { return iron; }
		[Bindable] public function get Oil( ) : int { return oil; }
		[Bindable] public function get PMetals( ) : int { return pMetals; }
		[Bindable] public function get Uranium( ) : int { return uranium; }
		[Bindable] public function get Ecs( ) : int { return ecs; }
		
		public function set FoodString( value : String ) : void { foodString = value; }
		public function set MineralsString( value : String ) : void { mineralsString = value; }
		public function set IronString( value : String ) : void { ironString = value; }
		public function set OilString( value : String ) : void { oilString = value; }
		public function set PMetalsString( value : String ) : void { pMetalsString = value; }
		public function set UraniumString( value : String ) : void { uraniumString = value; }
		public function set EcsString( value : String ) : void { ecsString = value; }
		
		public function set Food( value : int ) : void { food = value; FoodString = food.toString(); }
		public function set Minerals( value : int ) : void { minerals = value; MineralsString = minerals.toString(); }
		public function set Iron( value : int ) : void { iron = value; IronString = iron.toString(); }
		public function set Oil( value : int ) : void { oil = value; OilString = oil.toString(); }
		public function set PMetals( value : int ) : void { pMetals = value; PMetalsString = pMetals.toString(); }
		public function set Uranium( value : int ) : void { uranium = value; UraniumString = uranium.toString(); }
		public function set Ecs( value : int ) : void { ecs = value; EcsString = ecs.toString(); }
	}
}