package com.ish.wimp.parsers {
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import com.ish.wimp.model.HexInfo;

	public class MapParser {
		[Embed (source="resources/hexes.txt",mimeType="application/octet-stream")] private static const MAP_FILE : Class;
		
		private var map : Dictionary;
		
		private static var instance : MapParser;
		public static function getInstance() : MapParser { return instance == null ? instance = new MapParser() : instance; }
		public function MapParser() {
			map = new Dictionary();
			loadMap();
		}
		
		private function loadMap() : void {
			var mapContents : String = (new MAP_FILE as ByteArray).toString();
			var array : Array = mapContents.split( /\r\n/ );
			
			var line : String;
			var splitLine : Array;
			var hexInfo : HexInfo;
			for( var i : int = 0; i < array.length; ++i ) {
				line = array[i] as String;
				splitLine = line.split( /[ :]/ );
				if( splitLine[3] != null && (splitLine[3] as String).length > 0 )
					map[splitLine[0]] = new HexInfo( splitLine[1], splitLine[2], true, splitLine[3] );
				else
					map[splitLine[0]] = new HexInfo( splitLine[1], splitLine[2] );
			}
		}
		
		public function getMap() : Dictionary {
			return map;
		}
	}
}