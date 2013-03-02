package com.ish.wimp.parsers {
	import com.ish.wimp.model.input.WorldMarketResourceLine;
	import com.ish.wimp.model.input.WorldPressModel;
	
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayList;

	public class WorldPressParser {
		private const LINE_SPLIT_REGEX : RegExp = /[\r\n]/;
		private const BLANK_LINE_TEXT_REGEX : RegExp = /^\s*$/;
		
		private const TURN_TEST_REGEX : RegExp = /^Turn/;
		private const TURN_SPLIT_REGEX : RegExp = /\s+/;
		
		private const MARKET_TEST_REGEX : RegExp = /^(Food|Minerals|Iron|Oil|Precious Metals|Uranium)/;
		private const MARKET_SPLIT_REGEX : RegExp = /\s+\+?-?/;
		
		private const DETONATION_HEADER_REGEX : RegExp = /^Nuclear Detonations/;
		private const DETONATION_SPLIT_REGEX : RegExp = /\s{2,}/;
		private const DETONATION_SUB_SPLIT_REGEX : RegExp = /(Hex |: )/;
		
		private const SPACE_HEADER_REGEX : RegExp = /^Military Units in Space/;
		
		private var file : FileReference;
		private var searchState : int = 0;	// 0 - turn, 1 - world market
		
		public function loadWorldPress() : void {
			file = new FileReference( );
			file.addEventListener( Event.SELECT, onFileSelect );
			file.browse( );
		}
			
		private function onFileSelect( e : Event ) : void {
			file.addEventListener( Event.COMPLETE, onLoadComplete );
			file.load();
		}
		
		private function onLoadComplete( e : Event ) : void {
			var data : String = file.data.readUTFBytes( file.data.bytesAvailable );
			var lines : Array = data.split( LINE_SPLIT_REGEX );
			var line : String;
			for( var i : int = 0; i < lines.length; ++i ) {
				line = lines[i];
				switch( searchState ) {
					case 0: findTurn( line ); break;
					case 1: findWorldMarket( line ); break;
					case 2: findNuclearDetonationHeader( line ); break;
					case 3: findNuclearDetonations( line ); break;
					case 4: findSpaceUnits( line ); break;
				}
			}
		}
		
		private function findTurn( line : String ) : void {
			if( TURN_TEST_REGEX.test( line ) ) {
				var arr : Array = line.split( TURN_SPLIT_REGEX );
				WorldPressModel.turn = arr[1];
				++searchState;
			}
		}
		
		private function findWorldMarket( line : String ) : void {
			if( MARKET_TEST_REGEX.test( line ) )
				parseWorldMarketLine( line );
		}
		
		private function parseWorldMarketLine( line : String ) : void {
			var arr : Array = line.split( MARKET_SPLIT_REGEX );
			switch( arr[0] ) {
				case "Food":
					WorldPressModel.worldMarketFood = new WorldMarketResourceLine( arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[8] );
					break;
				case "Minerals":
					WorldPressModel.worldMarketMinerals = new WorldMarketResourceLine( arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[8] );
					break;
				case "Iron":
					WorldPressModel.worldMarketIron = new WorldMarketResourceLine( arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[8] );
					break;
				case "Oil":
					WorldPressModel.worldMarketOil = new WorldMarketResourceLine( arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[8] );
					break;
				case "Precious":
					WorldPressModel.worldMarketPMetals = new WorldMarketResourceLine( arr[0] + " " + arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[8], arr[9] );
					break;
				case "Uranium":
					WorldPressModel.worldMarketUranium = new WorldMarketResourceLine( arr[0], arr[1], arr[2], arr[3], arr[4], arr[5], arr[6], arr[7], arr[8] );
					++searchState;
					break;
			}
		}
		
		private var detonations : Dictionary;
		private function findNuclearDetonationHeader( line : String ) : void {
			if( DETONATION_HEADER_REGEX.test( line ) ) {
				detonations = new Dictionary();
				++searchState;
			}
		}
		
		private function findNuclearDetonations( line : String ) : void {
			if( SPACE_HEADER_REGEX.test( line ) ) {
				++searchState;
			} else {
				if( BLANK_LINE_TEXT_REGEX.test( line ) ) return;
				var arr : Array = line.split( DETONATION_SPLIT_REGEX );
				var subArr : Array;
				var nukeList : ArrayList;
				for( var i : int = 1; i < arr.length; ++i ) {
					subArr = arr[i].split( DETONATION_SUB_SPLIT_REGEX );
					nukeList = detonations[subArr[2]] == null ? new ArrayList() : detonations[subArr[2]];
					nukeList.addItem( subArr[4] );
					detonations[subArr[2]] = nukeList;
				}
			}
		}
		
		private function findSpaceUnits( line : String ) : void {
			WorldPressModel.nuclearDetonations = detonations;
			++searchState;
		}
	}
}