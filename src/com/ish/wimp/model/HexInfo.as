package com.ish.wimp.model {
	public class HexInfo {
		private var type : String;
		private var resources : String;
		private var isOutline : Boolean;
		private var outline : String;
		
		public function HexInfo( type : String = "W", resources : String = "", isOutline : Boolean = false, outline : String = null ) {
			this.type = type;
			this.resources = resources;
			this.isOutline = isOutline;
			this.outline = outline;
		}
		
		public function getType() : String { return type; }
		public function getResources() : String { return resources; }
		public function hasOutline() : Boolean { return isOutline; }
		public function getOutline() : String { return outline; }
	}
}