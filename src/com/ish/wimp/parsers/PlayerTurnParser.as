package com.ish.wimp.parsers {
	import com.ish.wimp.model.ExpenseModel;
	import com.ish.wimp.model.input.CombatReport;
	import com.ish.wimp.model.input.PlayerTurnModel;
	import com.ish.wimp.mxml.Map;
	import com.ish.wimp.mxml.popup.LoadFilesPopup;
	import com.ish.wimp.view.Map;
	
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayList;
	import mx.utils.StringUtil;

	public class PlayerTurnParser {
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
		private const POSITION_CONTROL_HEX_TEST_REGEX : RegExp = /(^Hexes controlled|^[^H]\s+\d)/;
		private const POSITION_CONTROL_HEX_SPLIT_REGEX : RegExp = /(, |,)/;
		private const POSITION_CONTEST_HEX_TEST_REGEX : RegExp = /is contested/;
		private const POSITION_CONTEST_HEX_SPLIT_REGEX : RegExp = /(Hex | is)/;
		
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
			LoadFilesPopup.playerFileName = file.name;
		}
		
		private function onLoadComplete( e : Event ) : void {
			var data : String = file.data.readUTFBytes( file.data.bytesAvailable );
			var lines : Array = data.split( LINE_SPLIT_REGEX );
			parseBasics( lines );
			
			var line : String;
			for( var i : int = 90; i < lines.length; ++i ) {
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
			PlayerTurnModel.contestedHexList = posList;
		}
		
		private function parseBasics( lines : Array ) : void {
			var line : String;
			
			line = lines[36];
			tempArray = line.split( NAME_SPLIT_REGEX );
			PlayerTurnModel.playerName = tempArray[1];
			
			line = lines[76];
			tempArray = line.split( BASIC1_SPLIT_REGEX );
			PlayerTurnModel.turnNumber = tempArray[2];
			PlayerTurnModel.countryName = tempArray[4];
			PlayerTurnModel.countryNumber = tempArray[6];
			PlayerTurnModel.gameNumber = tempArray[8];
			
			
			line = lines[80];
			tempArray = line.split( BASIC2_SPLIT_REGEX );
			PlayerTurnModel.accountNumber = tempArray[1];
		}

		private function findIntelligence( line : String ) : void {
			// TODO: PlayerTurnModel.alliances ?
			
			if( NATIONAL_SECURITY_TEST_REGEX.test( line ) ) {
				tempArray = line.split( NATIONAL_SECURITY_SPLIT_REGEX );
				PlayerTurnModel.nationalSecurityLevel = tempArray[1];
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
				PlayerTurnModel.combatMap = combatMap;
				++searchState;
			} else if( COMBAT_TEST_REGEX.test( line ) ) {
				finishReport( );
				tempArray = line.split( COMBAT_SPLIT_REGEX );
				elementList = new ArrayList();
				report = new CombatReport( tempArray[2], tempArray[4], StringUtil.trim( tempArray[6] ) );
			} else if( COMBAT_TAC_NUC_TEST_REGEX.test( line ) ) {
				tempArray = line.split( COMBAT_TAC_NUC_SPLIT_REGEX );
				PlayerTurnModel.takNuke = tempArray.length > 1 ? tempArray[2] : 0; 
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
			if( TECH_RECOVERY_TEST_REGEX.test( line ) ) {
				tempArray = line.split( TECH_RECOVERY_SPLIT_REGEX );
				switch( tempArray[6] ) {
					case "infantry":
						PlayerTurnModel.infTechLevel = tempArray[10];
						break;
					case "vehicle":
						PlayerTurnModel.vehTechLevel = tempArray[10];
						break;
					case "aerospace":
						PlayerTurnModel.aerTechLevel = tempArray[10];
						break;
					case "naval":
						PlayerTurnModel.navTechLevel = tempArray[10];
						break;
					case "nuclear":
						PlayerTurnModel.nucTechLevel = tempArray[10];
						++searchState;
						break;
				}
			}
		}
		
		private function findEconomics( line : String ) : void {
			if( ECONOMICS_TEST_REGEX.test( line ) ) {
				tempArray = line.split( ECONOMICS_SPLIT_REGEX );
				ExpenseModel.StartingBalance.Food = tempArray[2];
				ExpenseModel.StartingBalance.Minerals = tempArray[3];
				ExpenseModel.StartingBalance.Iron = tempArray[4];
				ExpenseModel.StartingBalance.Oil = tempArray[5];
				ExpenseModel.StartingBalance.PMetals = tempArray[6];
				ExpenseModel.StartingBalance.Uranium = tempArray[7];
				ExpenseModel.StartingBalance.Ecs = tempArray[8];
				ExpenseModel.StartingBalance = ExpenseModel.StartingBalance;
				ExpenseModel.EndingBalance = ExpenseModel.EndingBalance;
				++searchState;
			}
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
				PlayerTurnModel.positionMap = positionMap;
				
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
			if( POSITION_UNIT_HEX_TEST_REGEX.test( line ) ) {
				PlayerTurnModel.ownedHexList = posList;
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