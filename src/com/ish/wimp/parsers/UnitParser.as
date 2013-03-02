package com.ish.wimp.parsers {
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayList;
	import com.ish.wimp.model.unit.AttackList;
	import com.ish.wimp.model.unit.CostList;
	import com.ish.wimp.model.unit.TechList;
	import com.ish.wimp.model.unit.UnitInfo;

	public class UnitParser {
		[Embed (source="resources/units.txt",mimeType="application/octet-stream")] private static const UNIT_FILE : Class;
		
		private var units : Dictionary;
		
		private static var instance : UnitParser;
		public static function getInstance() : UnitParser { return instance == null ? instance = new UnitParser() : instance; }
		public function UnitParser() {
			units = new Dictionary();
			loadUnits();
		}
		
		public function getUnits() : Dictionary {
			return units;
		}
		
		private function loadUnits() : void {
			var unitContents : String = (new UNIT_FILE as ByteArray).toString();
			var array : Array = unitContents.split( /\r\n/ );
			
			var line : String;
			var splitLine : Array;
			var unitInfo : UnitInfo;
			for( var i : int = 0; i < array.length; ++i ) {
				line = array[i] as String;
				splitLine = line.split( ":" );
				units[splitLine[1]] = new UnitInfo(
					splitLine[0],
					splitLine[1],
					splitLine[2],
					generateNotes( splitLine[3] ),
					generateTech( splitLine[4] ),
					generateCost( splitLine[5] ),
					generateAttack( splitLine[6] ),
					splitLine[7] );
			}
		}
		
		private function generateNotes( str : String ) : ArrayList {
			return null;
		}
		
		private function generateTech( str : String ) : TechList {
			return null;
		}
		
		private function generateCost( str : String ) : CostList {
			var costList : CostList = new CostList();
			var splitCost : Array = str.split( "," );
			var cost : String;
			for( var i : int; i < splitCost.length; ++i ) {
				cost = splitCost[i];
				if( cost.indexOf( "F" ) > -1 )
					costList.setFood( parseInt( cost.substr( 0, cost.length - 1 ) ) );
				else if( cost.indexOf( "M" ) > -1 )
					costList.setMinerals( parseInt( cost.substr( 0, cost.length - 1 ) ) );
				else if( cost.indexOf( "I" ) > -1 )
					costList.setIron( parseInt( cost.substr( 0, cost.length - 1 ) ) );
				else if( cost.indexOf( "O" ) > -1 )
					costList.setOil( parseInt( cost.substr( 0, cost.length - 1 ) ) );
				else if( cost.indexOf( "P" ) > -1 )
					costList.setPMetals( parseInt( cost.substr( 0, cost.length - 1 ) ) );
				else if( cost.indexOf( "U" ) > -1 )
					costList.setUranium( parseInt( cost.substr( 0, cost.length - 1 ) ) );
				else if( cost.indexOf( "ec" ) > -1 )
					costList.setEcs( parseInt( cost.substr( 0, cost.length - 2 ) ) );
			}
			return costList;
		}
		
		private function generateAttack( str : String ) : AttackList {
			return null;
		}
	}
}