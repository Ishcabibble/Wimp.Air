package com.ish.wimp.parsers {
	import com.ish.wimp.model.ExpenseModel;
	import com.ish.wimp.mxml.action.AllianceLine;
	import com.ish.wimp.mxml.econ.ForeignAidLine;
	import com.ish.wimp.mxml.econ.PrivateTradeLine;
	import com.ish.wimp.mxml.econ.WorldMarketLine;
	import com.ish.wimp.mxml.popup.LoadFilesPopup;
	
	import flash.events.Event;
	import flash.net.FileReference;
	
	import mx.core.FlexGlobals;

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
		private const SPLIT_REGEX : RegExp = /( |,)/;
		
		private var app : WIMP = FlexGlobals.topLevelApplication as WIMP;
		private var file : FileReference;
		
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
			var tradeLine : int = 0;
			var aidLine : int = 0;
			var allyLine : int = 0;
			
			var data : String = file.data.readUTFBytes( file.data.bytesAvailable );
			var lines : Array = data.split( LINE_SPLIT_REGEX );
			var line : String;
			var arr : Array;
			for( var i : int = 0; i < lines.length; ++i ) {
				line = lines[i];
				arr = line.split( SPLIT_REGEX );
				
				if( MARKET_TEST_REGEX.test( line ) ) {
					doMarket( arr );
				} else if( TRADE_TEST_REGEX.test( line ) ) {
					doTrade( arr, tradeLine++ );
				} else if( AID_TEST_REGEX.test( line ) ) {
					doAid( arr, aidLine++ );
				} else if( ALLY_TEST_REGEX.test( line ) ) {
					doAlly( arr, allyLine++ );
				} else if( DISBAND_TEST_REGEX.test( line ) ) {
					
				} else if( DROPHEX_TEST_REGEX.test( line ) ) {
					
				} else if( TECH_TEST_REGEX.test( line ) ) {
					
				} else if( PRODUCTION_TEST_REGEX.test( line ) ) {
					
				} else if( NATSEC_TEST_REGEX.test( line ) ) {
					
				} else if( TACNUKE_TEST_REGEX.test( line ) ) {
					
				} else if( ESPIONAGE_TEST_REGEX.test( line ) ) {
					
				} else if( ACTION_TEST_REGEX.test( line ) ) {
					
				}
			}
			
			ExpenseModel.WorldMarket = ExpenseModel.WorldMarket;
			ExpenseModel.EndingBalance = ExpenseModel.EndingBalance;
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
				line.countryBox.selectedIndex = parseInt( arr[6] ) - 1;
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
				line.countryBox.selectedIndex = parseInt( arr[4] ) - 1;
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
				line.makeBox.selectedIndex = parseInt( arr[2] ) - 1;
				line.breakBox.selectedIndex = parseInt( arr[4] ) - 1;
				line.changeHandler();
			}
		}
	}
}