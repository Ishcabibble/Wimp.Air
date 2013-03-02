package com.ish.wimp.model {
	public class ActionRow {
		private var sectionNumber : int;
		private var lineNumber : int;
		private var qty : String;
		private var unit : String;
		private var source : String;
		private var mission : String;
		
		private var hex0 : String;
		private var hex1 : String;
		private var hex2 : String;
		private var hex3 : String;
		private var hex4 : String;
		private var hex5 : String;
		private var hex6 : String;
		private var hex7 : String;
		private var hex8 : String;
		private var hex9 : String;
		
		[Bindable] public function get SectionNumber( ) : int { return sectionNumber; }
		[Bindable] public function get LineNumber( ) : int { return lineNumber; }
		[Bindable] public function get Qty( ) : String { return qty; }
		[Bindable] public function get Unit( ) : String { return unit; }
		[Bindable] public function get Source( ) : String { return source; }
		[Bindable] public function get Mission( ) : String { return mission; }
		
		[Bindable] public function get Hex0( ) : String { return hex0; }
		[Bindable] public function get Hex1( ) : String { return hex1; }
		[Bindable] public function get Hex2( ) : String { return hex2; }
		[Bindable] public function get Hex3( ) : String { return hex3; }
		[Bindable] public function get Hex4( ) : String { return hex4; }
		[Bindable] public function get Hex5( ) : String { return hex5; }
		[Bindable] public function get Hex6( ) : String { return hex6; }
		[Bindable] public function get Hex7( ) : String { return hex7; }
		[Bindable] public function get Hex8( ) : String { return hex8; }
		[Bindable] public function get Hex9( ) : String { return hex9; }
		
		public function set SectionNumber( value : int ) : void { sectionNumber = value; }
		public function set LineNumber( value : int ) : void { lineNumber = value; }
		public function set Qty( value : String ) : void { qty = value; }
		public function set Unit( value : String ) : void { unit = value; }
		public function set Source( value : String ) : void { source = value; }
		public function set Mission( value : String ) : void { mission = value; }
		
		public function set Hex0( value : String ) : void { hex0 = value; }
		public function set Hex1( value : String ) : void { hex1 = value; }
		public function set Hex2( value : String ) : void { hex2 = value; }
		public function set Hex3( value : String ) : void { hex3 = value; }
		public function set Hex4( value : String ) : void { hex4 = value; }
		public function set Hex5( value : String ) : void { hex5 = value; }
		public function set Hex6( value : String ) : void { hex6 = value; }
		public function set Hex7( value : String ) : void { hex7 = value; }
		public function set Hex8( value : String ) : void { hex8 = value; }
		public function set Hex9( value : String ) : void { hex9 = value; }
	}
}