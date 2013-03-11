package com.ish.wimp.parsers {
	import com.ish.wimp.model.input.AllyTurnModel;
	import com.ish.wimp.model.input.CombatReport;
	import com.ish.wimp.mxml.popup.LoadFilesPopup;
	
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayList;
	import mx.utils.StringUtil;

	public class AllyTurnParser {
		private const LINE_SPLIT_REGEX : RegExp = /[\r\n]/;
		private const BLANK_LINE_TEXT_REGEX : RegExp = /^\s*$/;
		
		private const NAME_SPLIT_REGEX : RegExp = /\s{2,}/;
		private const BASIC1_SPLIT_REGEX : RegExp = /(Turn | report for | \(|\)\s+Game #)/;
		private const BASIC2_SPLIT_REGEX : RegExp = /Account Number /;
		
		private const NATIONAL_SECURITY_TEST_REGEX : RegExp = /Our current/;
		private const NATIONAL_SECURITY_SPLIT_REGEX : RegExp = /\D+/;
		
		private const COMBAT_HEADER_REGEX : RegExp = /Combat Reports/;
		private const COMBAT_TAC_NUC_TEST_REGEX : RegExp = /^(Tactical nuclear|No tactical nuclear)/;
		private const COMBAT_TAC_NUC_SPLIT_REGEX : RegExp = /(weapons of |K or smaller)/;
		private const COMBAT_TEST_REGEX : RegExp = /^Hex \d{3,4}/;
		private const COMBAT_SPLIT_REGEX : RegExp = /(Hex | \(|\): )/;
		
		private const TECH_RECOVERY_HEADER_REGEX : RegExp = /Technology Recovery Reports/;
		private const TECH_RECOVERY_TEST_REGEX : RegExp = /^We spent/;
		private const TECH_RECOVERY_SPLIT_REGEX : RegExp = /(on | technology|level |\.)/;
		
		private const ECONOMICS_TEST_REGEX : RegExp = /^Current Totals/;
		private const ECONOMICS_SPLIT_REGEX : RegExp = /\s+/;
		
		private const POSITION_HEADER_REGEX : RegExp = /Victory Point Total/;
		private const POSITION_UNIT_HEX_TEST_REGEX : RegExp = /^Hex/;
		private const POSITION_UNIT_HEX_SPLIT_REGEX : RegExp = /(Hex |\s+- )/;
		private const POSITION_CONTROL_HEX_TEST_REGEX : RegExp = /^Hexes controlled/;
		private const POSITION_CONTROL_HEX_SPLIT_REGEX : RegExp = /(, |,)/;
		private const POSITION_CONTEST_HEX_TEST_REGEX : RegExp = /is contested/;
		private const POSITION_CONTEST_HEX_SPLIT_REGEX : RegExp = /(Hex | is)/;
		private const RECON_TEXT_REGEX : RegExp = /Reconnaissance Reports/;
		
		private var file : FileReference;
		private var searchState : int = 0;	// 0 - intellegence, 1 - combat header, 2 - combat, 3 - tech recovery, 4 - economics,
		// 5 - position header, 6 - position units, 7 - position hexes, 8 - contested hexes
		private var tempArray : Array;
		
		public function loadPlayerTurn() : void {
			combatMap = new Dictionary();
			report = null;
			elementList = null;
			
			file = new FileReference( );
			file.addEventListener( Event.SELECT, onFileSelect );
			file.browse( );
		}
		
		private function onFileSelect( e : Event ) : void {
			file.addEventListener( Event.COMPLETE, onLoadComplete );
			file.load();
			LoadFilesPopup.allyFileNames.addItem( file.name );
		}
		
		private function onLoadComplete( e : Event ) : void {
			var data : String = file.data.readUTFBytes( file.data.bytesAvailable );
			var lines : Array = data.split( LINE_SPLIT_REGEX );
			
			var line : String;
			for( var i : int = 40; i < lines.length; ++i ) {
				line = lines[i];
				switch( searchState ) {
					case 0: findIntelligence( line ); break;
					case 1: findCombatHeader( line ); break;
					case 2: findCombat( line ); break;
					case 3: findTechnology( line ); break;
					case 4: findEconomics( line ); break;
					case 5: findPositionHeader( line ); break;
					case 6: findPositionUnits( line ); break;
					case 7: findPositionHexes( line ); break;
					case 8: findContestedHexes( line ); break;
				}
			}
			if( AllyTurnModel.contestedHexList == null )
				AllyTurnModel.contestedHexList = posList;
			else
				AllyTurnModel.contestedHexList.addAll( posList );
		}
		
		private function findIntelligence( line : String ) : void {
			if( NATIONAL_SECURITY_TEST_REGEX.test( line ) ) {
				++searchState;
			}
		}
		
		private function findCombatHeader( line : String ) : void {
			if( COMBAT_HEADER_REGEX.test( line ) )
				++searchState;
		}
		
		private var combatMap : Dictionary = new Dictionary();
		private var report : CombatReport  = null;
		private var elementList : ArrayList = null;
		private function findCombat( line : String ) : void {
			if( TECH_RECOVERY_HEADER_REGEX.test( line ) ) {
				finishReport( );
				if( AllyTurnModel.combatMap == null )
					AllyTurnModel.combatMap = combatMap;
				else
					for( var key : Object in combatMap )
						AllyTurnModel.combatMap[key] = combatMap[key];
				++searchState;
			} else if( COMBAT_TEST_REGEX.test( line ) ) {
				finishReport( );
				tempArray = line.split( COMBAT_SPLIT_REGEX );
				elementList = new ArrayList();
				report = new CombatReport( tempArray[2], tempArray[4], StringUtil.trim( tempArray[6] ) );
			} else if( COMBAT_TAC_NUC_TEST_REGEX.test( line ) ) {
				// no op
			} else {
				if( BLANK_LINE_TEXT_REGEX.test( line ) ) return;
				elementList.addItem( line );
			}
		}
		
		private function finishReport( ) : void {
			if( report != null ) {									// if this is not the first report, finish processing the last one
				report.setCombatElementList( elementList );
				var hexNum : int = report.getHex();
				var curHex : ArrayList;
				if( combatMap[hexNum] != null ) {					// this is not the first combat in the hex
					curHex = combatMap[hexNum] as ArrayList;
				} else {											// this is the first combat in the hex
					curHex = new ArrayList();
				}
				curHex.addItem( report );
				combatMap[hexNum] = curHex;
			}
		}
		
		private function findTechnology( line : String ) : void {
			if( TECH_RECOVERY_TEST_REGEX.test( line ) )
				++searchState;
		}
		
		private function findEconomics( line : String ) : void {
			if( ECONOMICS_TEST_REGEX.test( line ) )
				++searchState;
		}
		
		private function findPositionHeader( line : String ) : void {
			if( POSITION_HEADER_REGEX.test( line ) )
				++searchState;
		}
		
		private var positionMap : Dictionary = new Dictionary();
		private var curHex : int;
		private var countryList : ArrayList = null;
		private var posList : ArrayList = null;
		private function findPositionUnits( line : String ) : void {
			if( POSITION_CONTROL_HEX_TEST_REGEX.test( line ) ) {
				finishPosition( );
				if( AllyTurnModel.positionMap == null )
					AllyTurnModel.positionMap = positionMap;
				else
					for( var key : Object in positionMap )
						AllyTurnModel.positionMap[key] = positionMap[key];
				
				posList = new ArrayList();
				tempArray = line.split( /- / );
				var hexes : String = StringUtil.trim( tempArray[1] );
				addHexesToPosList( hexes );
				++searchState;
			} else if( POSITION_UNIT_HEX_TEST_REGEX.test( line ) ) {
				finishPosition( );
				tempArray = line.split( POSITION_UNIT_HEX_SPLIT_REGEX );
				curHex = tempArray[2];
				countryList = new ArrayList();
				countryList.addItem( tempArray[4] );
			} else {
				if( BLANK_LINE_TEXT_REGEX.test( line ) ) return;
				countryList.addItem( StringUtil.trim( line ) );
			}
		}
		
		private function finishPosition( ) : void {
			if( countryList != null )								// if this is not the first hex, finish processing the last one
				positionMap[curHex] = countryList;
		}
		
		private function findPositionHexes( line : String ) : void {
			if( POSITION_UNIT_HEX_TEST_REGEX.test( line ) || RECON_TEXT_REGEX.test( line ) ) {
				if( AllyTurnModel.ownedHexList == null )
					AllyTurnModel.ownedHexList = posList;
				else
					AllyTurnModel.ownedHexList.addAll( posList );
				posList = new ArrayList( );
				++searchState;
			} else {
				if( BLANK_LINE_TEXT_REGEX.test( line ) ) return;
				var hexes : String = StringUtil.trim( line );
				addHexesToPosList( hexes );
			}
		}
		
		private function addHexesToPosList( hexes : String ) : void {
			tempArray = hexes.split( POSITION_CONTROL_HEX_SPLIT_REGEX );
			var hex : String;
			for( var i : int = 0; i < tempArray.length; ++i ) {
				hex = tempArray[i];
				if( hex != "" && hex.indexOf( "," ) == -1 ) {
					posList.addItem( parseInt( hex ) );
				}
			}
		}
		
		private function findContestedHexes( line : String ) : void {
			if( POSITION_CONTEST_HEX_TEST_REGEX.test( line ) ) {
				tempArray = line.split( POSITION_CONTEST_HEX_SPLIT_REGEX );
				posList.addItem( parseInt( tempArray[2] ) );
			}
		}
	}
}