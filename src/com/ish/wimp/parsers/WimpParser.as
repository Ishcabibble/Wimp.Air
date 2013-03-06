package com.ish.wimp.parsers {
	import com.ish.wimp.model.ActionRow;
	import com.ish.wimp.mxml.action.AllianceLine;
	import com.ish.wimp.mxml.action.DropHexLine;
	import com.ish.wimp.mxml.action.TacNukeLine;
	import com.ish.wimp.mxml.econ.EspionageLine;
	import com.ish.wimp.mxml.econ.ForeignAidLine;
	import com.ish.wimp.mxml.econ.NationalSecurityLine;
	import com.ish.wimp.mxml.econ.PrivateTradeLine;
	import com.ish.wimp.mxml.econ.ProductionLine;
	import com.ish.wimp.mxml.econ.ScrapLine;
	import com.ish.wimp.mxml.econ.TechRecoveryLine;
	import com.ish.wimp.mxml.econ.WorldMarketLine;
	import com.ish.wimp.mxml.popup.LoadFilesPopup;
	
	import flash.events.Event;
	import flash.net.FileReference;
	
	import mx.core.FlexGlobals;
	import mx.utils.StringUtil;

	public class WimpParser {
		private const LINE_SPLIT_REGEX : RegExp = /[\r\n]/;
		private const MARKET_TEST_REGEX : RegExp = /^MARKET/;
		private const TRADE_TEST_REGEX : RegExp = /^TRADE/;
		private const AID_TEST_REGEX : RegExp = /^AID/;
		private const ALLY_TEST_REGEX : RegExp = /^ALLY/;
		private const DISBAND_TEST_REGEX : RegExp = /^DISBAND/;
		private const DROPHEX_TEST_REGEX : RegExp = /^DROPHEX/;
		private const TECH_TEST_REGEX : RegExp = /^TECH/;
		private const PRODUCTION_TEST_REGEX : RegExp = /^PROD/;
		private const NATSEC_TEST_REGEX : RegExp = /^NATSEC/;
		private const TACNUKE_TEST_REGEX : RegExp = /^TACNUKE/;
		private const ESPIONAGE_TEST_REGEX : RegExp = /^ESP/;
		private const ACTION_TEST_REGEX : RegExp = /^ACTION/;
		private const ANON_TEST_REGEX : RegExp = /^ANONYMOUS/;
		private const PRESS0_TEST_REGEX : RegExp = /^PRESS0/;
		private const PRESS1_TEST_REGEX : RegExp = /^PRESS1/;
		private const PRESS2_TEST_REGEX : RegExp = /^PRESS2/;
		private const SPLIT_REGEX : RegExp = /( |,)/;
		
		private var app : WIMP = FlexGlobals.topLevelApplication as WIMP;
		private var file : FileReference;
		
		private var press0 : String;
		private var press1 : String;
		private var press2 : String;
		
		public function loadWimp() : void {
			file = new FileReference( );
			file.addEventListener( Event.SELECT, onFileSelect );
			file.browse( );
		}
		
		private function onFileSelect( e : Event ) : void {
			file.addEventListener( Event.COMPLETE, onLoadComplete );
			file.load();
			LoadFilesPopup.turnFileName = file.name;
		}
		
		private function onLoadComplete( e : Event ) : void {
			press0 = "";
			press1 = "";
			press2 = "";
			
			var tradeLine : int = 0;
			var aidLine : int = 0;
			var allyLine : int = 0;
			var disbandLine : int = 0;
			var productionLine : int = 0;
			var espionageLine : int = 0;
			var actionLine : int = 0;
			
			var data : String = file.data.readUTFBytes( file.data.bytesAvailable );
			var lines : Array = data.split( LINE_SPLIT_REGEX );
			var line : String;
			var arr : Array;
			for( var i : int = 0; i < lines.length; ++i ) {
				line = lines[i];
				arr = line.split( SPLIT_REGEX );
				
				if( MARKET_TEST_REGEX.test( line ) ) doMarket( arr );
				else if( TRADE_TEST_REGEX.test( line ) ) doTrade( arr, tradeLine++ );
				else if( AID_TEST_REGEX.test( line ) ) doAid( arr, aidLine++ );
				else if( ALLY_TEST_REGEX.test( line ) ) doAlly( arr, allyLine++ );
				else if( DISBAND_TEST_REGEX.test( line ) ) doDisband( arr, disbandLine++ );
				else if( DROPHEX_TEST_REGEX.test( line ) ) doDrop( arr );
				else if( TECH_TEST_REGEX.test( line ) ) doTech( arr );
				else if( PRODUCTION_TEST_REGEX.test( line ) ) doProduction( arr, productionLine++ )
				else if( NATSEC_TEST_REGEX.test( line ) ) doNatsec( arr );
				else if( TACNUKE_TEST_REGEX.test( line ) ) doTacNuke( arr );
				else if( ESPIONAGE_TEST_REGEX.test( line ) ) doEspionage( arr, espionageLine++ );
				else if( ACTION_TEST_REGEX.test( line ) ) doAction( arr, actionLine++ );
				else if( ANON_TEST_REGEX.test( line ) ) doAnon( line );
				else if( PRESS0_TEST_REGEX.test( line ) ) doPress( line, 0 );
				else if( PRESS1_TEST_REGEX.test( line ) ) doPress( line, 1 );
				else if( PRESS2_TEST_REGEX.test( line ) ) doPress( line, 2 );
			}
			finishPress();
		}
		
		private function doMarket( arr : Array ) : void {
			var index : int = -1;
			if( arr[2] == "Buy" ) index = 0;
			else if( arr[2] == "Sell" ) index = 1;
			
			var line : WorldMarketLine;
			switch( (arr[0] as String).charAt(6) ) {
				case "f": line = app.economics.worldMarket.foodLine; break;
				case "m": line = app.economics.worldMarket.mineralsLine; break;
				case "i": line = app.economics.worldMarket.ironLine; break;
				case "o": line = app.economics.worldMarket.oilLine; break;
				case "p": line = app.economics.worldMarket.pMetalsLine; break;
				case "u": line = app.economics.worldMarket.uraniumLine; break;
			}
			
			if( line != null ) {
				line.buySellBox.selectedIndex = index;
				line.qtyInput.text = arr[4];
				line.changeHandler();
			}
		}
		
		private function doTrade( arr : Array, lineNumber : int ) : void {
			var giveIndex : int = -1;
			if( arr[4] == "F" ) giveIndex = 0;
			else if( arr[4] == "M" ) giveIndex = 1;
			else if( arr[4] == "I" ) giveIndex = 2;
			else if( arr[4] == "O" ) giveIndex = 3;
			else if( arr[4] == "P" ) giveIndex = 4;
			else if( arr[4] == "U" ) giveIndex = 5;
			
			var forIndex : int = -1;
			if( arr[10] == "F" ) forIndex = 0;
			else if( arr[10] == "M" ) forIndex = 1;
			else if( arr[10] == "I" ) forIndex = 2;
			else if( arr[10] == "O" ) forIndex = 3;
			else if( arr[10] == "P" ) forIndex = 4;
			else if( arr[10] == "U" ) forIndex = 5;
			
			var line : PrivateTradeLine;
			switch( lineNumber ) {
				case 0: line = app.economics.privateTrade.privateTrade1; break;
				case 1: line = app.economics.privateTrade.privateTrade2; break;
				case 2: line = app.economics.privateTrade.privateTrade3; break;
			}
			
			if( line != null ) {
				line.qtyInput1.text = arr[2];
				line.resourceBox1.selectedIndex = giveIndex;
				line.countryBox.selectedIndex = isNaN( parseInt( arr[6] ) ) ? -1 : parseInt( arr[6] ) - 1;
				line.qtyInput2.text = arr[8];
				line.resourceBox2.selectedIndex = forIndex;
				line.changeHandler();
			}
		}
		
		private function doAid( arr : Array, lineNumber : int ) : void {
			var line : ForeignAidLine;
			switch( lineNumber ) {
				case 0: line = app.economics.privateTrade.aid1; break;
				case 1: line = app.economics.privateTrade.aid2; break;
			}
			
			if( line != null ) {
				line.ecInput.text = arr[2];
				line.countryBox.selectedIndex = isNaN( parseInt( arr[4] ) ) ? -1 : parseInt( arr[4] ) - 1;
				line.changeHandler();
			}
		}
		
		private function doAlly( arr : Array, lineNumber : int ) : void {
			var line : AllianceLine;
			switch( lineNumber ) {
				case 0: line = app.actions.allianceLine1; break;
				case 1: line = app.actions.allianceLine2; break;
			}
			
			if( line != null ) {
				line.makeBox.selectedIndex = isNaN( parseInt( arr[2] ) ) ? -1 : parseInt( arr[2] ) - 1;
				line.breakBox.selectedIndex = isNaN( parseInt( arr[4] ) ) ? -1 : parseInt( arr[4] ) - 1;
				line.changeHandler();
			}
		}
		
		private function doDisband( arr : Array, lineNumber : int ) : void {
			var line : ScrapLine;
			switch( lineNumber ) {
				case 0: line = app.economics.scrap.scrap1; break;
				case 1: line = app.economics.scrap.scrap2; break;
			}
			
			if( line != null ) {
				line.qtyInput.text = arr[2];
				line.unitInput.text = arr[4];
				line.hexInput.text = arr[6];
				line.recoveryCheck.selected = false;
				line.changeHandler();
			}
		}
		
		private function doDrop( arr : Array ) : void {
			var line : DropHexLine = app.actions.dropHex;
			if( line != null ) {
				line.hexInput.text = arr[2];
				line.changeHandler();
			}
		}
		
		private function doTech( arr : Array ) : void {
			doTechLine( app.economics.techRecovery.infTechLine, arr[2] );
			doTechLine( app.economics.techRecovery.vehTechLine, arr[4] );
			doTechLine( app.economics.techRecovery.aerTechLine, arr[6] );
			doTechLine( app.economics.techRecovery.navTechLine, arr[8] );
			doTechLine( app.economics.techRecovery.nucTechLine, arr[10] );
		}
		
		private function doTechLine( line : TechRecoveryLine, input : String ) : void {
			if( line != null ) {
				line.ecInput.text = input;
				line.changeHandler();
			}
		}
		
		private function doProduction( arr : Array, lineNumber : int ) : void {
			var line : ProductionLine;
			switch( lineNumber ) {
				case 0: line = app.economics.production.prodLine1; break;
				case 1: line = app.economics.production.prodLine2; break;
				case 2: line = app.economics.production.prodLine3; break;
				case 3: line = app.economics.production.prodLine4; break;
				case 4: line = app.economics.production.prodLine5; break;
			}
			
			if( line != null ) {
				line.qtyInput.text = arr[2];
				line.unitInput.text = arr[4];
				line.sourceHex.text = arr[6];
				line.destHex.text = arr[8];
				line.changeHandler();
			}
		}
		
		private function doNatsec( arr : Array ) : void {
			var line : NationalSecurityLine = app.economics.espionage.natsecLine;
			if( line != null ) {
				line.ecInput.text = arr[2];
				line.changeHandler();
			}
		}
		
		private function doTacNuke( arr : Array ) : void {
			var line : TacNukeLine = app.actions.tacNuke;
			if( line != null ) {
				switch( arr[2] ) {
					case "1": line.tacNukeBox.selectedIndex = 1; break;
					case "5": line.tacNukeBox.selectedIndex = 2; break;
					case "10": line.tacNukeBox.selectedIndex = 3; break;
					case "50": line.tacNukeBox.selectedIndex = 4; break;
					case "100": line.tacNukeBox.selectedIndex = 5; break;
					case "500": line.tacNukeBox.selectedIndex = 6; break;
					default: line.tacNukeBox.selectedIndex = 0; break;
				}
				line.tacNukeHandler();
			}
		}
		
		private function doEspionage( arr : Array, lineNumber : int ) : void {
			var line : EspionageLine;
			switch( lineNumber ) {
				case 0: line = app.economics.espionage.espLine1; break;
				case 1: line = app.economics.espionage.espLine2; break;
				case 2: line = app.economics.espionage.espLine3; break;
			}
			
			if( line != null ) {
				line.ecInput.text = arr[2];
				switch( arr[4] ) {
					case "DR": line.missionBox.selectedIndex = 0; break;
					case "DS": line.missionBox.selectedIndex = 1; break;
					case "DT": line.missionBox.selectedIndex = 2; break;
					case "IN": line.missionBox.selectedIndex = 3; break;
					case "PA": line.missionBox.selectedIndex = 4; break;
					case "RG": line.missionBox.selectedIndex = 5; break;
					case "RH": line.missionBox.selectedIndex = 6; break;
					case "RP": line.missionBox.selectedIndex = 7; break;
					case "SA": line.missionBox.selectedIndex = 8; break;
					case "SN": line.missionBox.selectedIndex = 9; break;
					case "SP": line.missionBox.selectedIndex = 10; break;
					case "SR": line.missionBox.selectedIndex = 11; break;
					case "ST": line.missionBox.selectedIndex = 12; break;
					default: line.missionBox.selectedIndex = -1; break;
				}
				line.missionHandler();
				
				switch( line.currentState ) {
					case "blank":
						break;
					case "country":
						line.countryBox.selectedIndex = isNaN( parseInt( arr[6] ) ) ? -1 : parseInt( arr[6] ) - 1;
						break;
					case "hex":
						line.hexInput.text = arr[6];
						break;
					case "SR":
					case "ST":
						line.countryBox.selectedIndex = isNaN( parseInt( arr[6] ) ) ? -1 : parseInt( arr[6] ) - 1;
						switch( arr[8] ) {
							case "F": line.resourceBox.selectedIndex = 0; break;
							case "M": line.resourceBox.selectedIndex = 1; break;
							case "I": line.resourceBox.selectedIndex = 2; break;
							case "O": line.resourceBox.selectedIndex = 3; break;
							case "P": line.resourceBox.selectedIndex = 4; break;
							case "U": line.resourceBox.selectedIndex = 5; break;
							case "Inf": line.techTypeBox.selectedIndex = 0; break;
							case "Veh": line.techTypeBox.selectedIndex = 1; break;
							case "Aer": line.techTypeBox.selectedIndex = 2; break;
							case "Nav": line.techTypeBox.selectedIndex = 3; break;
							case "Nuc": line.techTypeBox.selectedIndex = 4; break;
							default:
								line.resourceBox.selectedIndex = -1;
								line.techTypeBox.selectedIndex = -1;
								break;
						}
						break;
				}
				
				line.changeHandler();
			}
		}
		
		private function doAction( arr : Array, lineNumber : int ) : void {
			var line : ActionRow = app.actions.normalActionList.actionList.source[lineNumber];
			
			if( line != null ) {
				line.Qty = arr[2];
				line.Unit = arr[4];
				line.Source = arr[6];
				line.Mission = arr[8];
				line.Hex0 = arr[10];
				line.Hex1 = arr[12];
				line.Hex2 = arr[14];
				line.Hex3 = arr[16];
				line.Hex4 = arr[18];
				line.Hex5 = arr[20];
				line.Hex6 = arr[22];
				line.Hex7 = arr[24];
				line.Hex8 = arr[26];
				line.Hex9 = arr[28];
				
				app.actions.normalActionList.updateItemRenderer( lineNumber );
			}
		}
		
		private function doAnon( line : String ) : void {
			app.worldPress.pressCheck1.selected = line.indexOf( "0" ) > -1;
			app.worldPress.pressCheck2.selected = line.indexOf( "1" ) > -1;
			app.worldPress.pressCheck3.selected = line.indexOf( "2" ) > -1;
			app.worldPress.updateChecks();
		}
		
		private function doPress( line : String, pressNumber : int ) : void {
			switch( pressNumber ) {
				case 0:
					press0 = press0.concat( line.substr( 7 ) );
					break;
				case 1:
					press1 = press1.concat( line.substr( 7 ) );
					break;
				case 2:
					press2 = press2.concat( line.substr( 7 ) );
					break;
			}
		}
		
		private function finishPress( ) : void {
			if( press0 == "" && press1 == "" && press2 == "" ) {
				app.worldPress.numPressBox.selectedIndex = 0;
				app.worldPress.currentState = "init";
			} else if( press0 != "" && press1 != "" && press2 != "" ) {
				app.worldPress.numPressBox.selectedIndex = 3;
				app.worldPress.currentState = "three";
			} else if( press0 != "" && press1 != "" ) {
				app.worldPress.numPressBox.selectedIndex = 2;
				app.worldPress.currentState = "two";
			} else if( press0 != "" ) {
				app.worldPress.numPressBox.selectedIndex = 1;
				app.worldPress.currentState = "one";
			}
			
			app.worldPress.pressText1.text = StringUtil.trim( press0 );
			app.worldPress.pressText2.text = StringUtil.trim( press1 );
			app.worldPress.pressText3.text = StringUtil.trim( press2 );
			app.worldPress.updateTextAreas();
		}
	}
}