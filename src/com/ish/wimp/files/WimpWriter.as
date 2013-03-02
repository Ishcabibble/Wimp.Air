package com.ish.wimp.files {
	import com.ish.wimp.model.ActionRow;
	import com.ish.wimp.model.ExpenseModel;
	import com.ish.wimp.model.input.PlayerTurnModel;
	import com.ish.wimp.model.output.OutputModel;
	
	import flash.events.Event;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import mx.controls.Alert;

	public class WimpWriter {
		
		private static var fileStream : FileStream = new FileStream();
		private static var file : File = new File();
		
		public static function writeWimpFile( ) : void {
			if( PlayerTurnModel.playerName == null ) {
				Alert.show( "Saving is disabled until a player turn file is loaded" );
				return;
			}
			
			file.addEventListener( Event.SELECT, onFileSelected );
			file.browseForSave( "Save file as" );
		}
		
		public static function onFileSelected( e : Event ) : void {
			fileStream.open( File( e.target ), FileMode.WRITE );
			writeMisc();
			writeMarket();
			writeTrade();
			writeAid();
			writeAlly();
			writeDisband();
			writeDrophex();
			writeTech();
			writeProduction();
			writeNatsec();
			writeTacnuke();
			writeEspionage();
			writeActions();
			writePress();
			closeFile();
		}
		
		private static function writeMisc() : void {
			fileStream.writeUTFBytes( "MISC " );
			fileStream.writeUTFBytes( PlayerTurnModel.playerName );
			fileStream.writeUTFBytes( "," + PlayerTurnModel.accountNumber );
			fileStream.writeUTFBytes( "," + PlayerTurnModel.gameNumber );
			fileStream.writeUTFBytes( "," + PlayerTurnModel.countryNumber );
			var turnNumber : int = PlayerTurnModel.turnNumber + 1;
			fileStream.writeUTFBytes( "," + turnNumber );
			fileStream.writeUTFBytes( "\n" );
		}
		
		private static function writeMarket() : void {
			fileStream.writeUTFBytes( "MARKETf " );
			if( OutputModel.worldMarketFoodQty > 0 ) fileStream.writeUTFBytes( OutputModel.worldMarketFoodBuy );
			fileStream.writeUTFBytes( "," );
			if( OutputModel.worldMarketFoodQty > 0 ) fileStream.writeUTFBytes( "" + OutputModel.worldMarketFoodQty );
			fileStream.writeUTFBytes( "\n" );
			
			fileStream.writeUTFBytes( "MARKETm " );
			if( OutputModel.worldMarketMineralsQty > 0 ) fileStream.writeUTFBytes( OutputModel.worldMarketMineralsBuy );
			fileStream.writeUTFBytes( "," );
			if( OutputModel.worldMarketMineralsQty > 0 ) fileStream.writeUTFBytes( "" + OutputModel.worldMarketMineralsQty );
			fileStream.writeUTFBytes( "\n" );
			
			fileStream.writeUTFBytes( "MARKETi " );
			if( OutputModel.worldMarketIronQty > 0 ) fileStream.writeUTFBytes( OutputModel.worldMarketIronBuy );
			fileStream.writeUTFBytes( "," );
			if( OutputModel.worldMarketIronQty > 0 ) fileStream.writeUTFBytes( "" + OutputModel.worldMarketIronQty );
			fileStream.writeUTFBytes( "\n" );
			
			fileStream.writeUTFBytes( "MARKETo " );
			if( OutputModel.worldMarketOilQty > 0 ) fileStream.writeUTFBytes( OutputModel.worldMarketOilBuy );
			fileStream.writeUTFBytes( "," );
			if( OutputModel.worldMarketOilQty > 0 ) fileStream.writeUTFBytes( "" + OutputModel.worldMarketOilQty );
			fileStream.writeUTFBytes( "\n" );
			
			fileStream.writeUTFBytes( "MARKETp " );
			if( OutputModel.worldMarketPMetalsQty > 0 ) fileStream.writeUTFBytes( OutputModel.worldMarketPMetalsBuy );
			fileStream.writeUTFBytes( "," );
			if( OutputModel.worldMarketPMetalsQty > 0 ) fileStream.writeUTFBytes( "" + OutputModel.worldMarketPMetalsQty );
			fileStream.writeUTFBytes( "\n" );
			
			fileStream.writeUTFBytes( "MARKETu " );
			if( OutputModel.worldMarketUraniumQty > 0 ) fileStream.writeUTFBytes( OutputModel.worldMarketUraniumBuy );
			fileStream.writeUTFBytes( "," );
			if( OutputModel.worldMarketUraniumQty > 0 ) fileStream.writeUTFBytes( "" + OutputModel.worldMarketUraniumQty );
			fileStream.writeUTFBytes( "\n" );
		}
		
		private static function writeTrade() : void {
			fileStream.writeUTFBytes( "TRADE " );
			if( ExpenseModel.PrivateTrade1.Food < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade1.Food + ",F," + OutputModel.tradeCountry1 + "," );
			else if( ExpenseModel.PrivateTrade1.Minerals < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade1.Minerals + ",M," + OutputModel.tradeCountry1 + "," );
			else if( ExpenseModel.PrivateTrade1.Iron < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade1.Iron + ",I," + OutputModel.tradeCountry1 + "," );
			else if( ExpenseModel.PrivateTrade1.Oil < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade1.Oil + ",O," + OutputModel.tradeCountry1 + "," );
			else if( ExpenseModel.PrivateTrade1.PMetals < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade1.PMetals + ",P," + OutputModel.tradeCountry1 + "," );
			else if( ExpenseModel.PrivateTrade1.Uranium < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade1.Uranium + ",U," + OutputModel.tradeCountry1 + "," );
			else
				fileStream.writeUTFBytes( ",,," );
			if( ExpenseModel.PrivateTrade1.Food > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade1.Food + ",F" );
			else if( ExpenseModel.PrivateTrade1.Minerals > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade1.Minerals + ",M" );
			else if( ExpenseModel.PrivateTrade1.Iron > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade1.Iron + ",I" );
			else if( ExpenseModel.PrivateTrade1.Oil > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade1.Oil + ",O" );
			else if( ExpenseModel.PrivateTrade1.PMetals > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade1.PMetals + ",P" );
			else if( ExpenseModel.PrivateTrade1.Uranium > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade1.Uranium + ",U" );
			else
				fileStream.writeUTFBytes( "," );
			fileStream.writeUTFBytes( "\n" );
			
			fileStream.writeUTFBytes( "TRADE " );
			if( ExpenseModel.PrivateTrade2.Food < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade2.Food + ",F," + OutputModel.tradeCountry2 + "," );
			else if( ExpenseModel.PrivateTrade2.Minerals < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade2.Minerals + ",M," + OutputModel.tradeCountry2 + "," );
			else if( ExpenseModel.PrivateTrade2.Iron < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade2.Iron + ",I," + OutputModel.tradeCountry2 + "," );
			else if( ExpenseModel.PrivateTrade2.Oil < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade2.Oil + ",O," + OutputModel.tradeCountry2 + "," );
			else if( ExpenseModel.PrivateTrade2.PMetals < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade2.PMetals + ",P," + OutputModel.tradeCountry2 + "," );
			else if( ExpenseModel.PrivateTrade2.Uranium < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade2.Uranium + ",U," + OutputModel.tradeCountry2 + "," );
			else
				fileStream.writeUTFBytes( ",,," );
			if( ExpenseModel.PrivateTrade2.Food > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade2.Food + ",F" );
			else if( ExpenseModel.PrivateTrade2.Minerals > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade2.Minerals + ",M" );
			else if( ExpenseModel.PrivateTrade2.Iron > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade2.Iron + ",I" );
			else if( ExpenseModel.PrivateTrade2.Oil > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade2.Oil + ",O" );
			else if( ExpenseModel.PrivateTrade2.PMetals > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade2.PMetals + ",P" );
			else if( ExpenseModel.PrivateTrade2.Uranium > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade2.Uranium + ",U" );
			else
				fileStream.writeUTFBytes( "," );
			fileStream.writeUTFBytes( "\n" );
			
			fileStream.writeUTFBytes( "TRADE " );
			if( ExpenseModel.PrivateTrade3.Food < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade3.Food + ",F," + OutputModel.tradeCountry3 + "," );
			else if( ExpenseModel.PrivateTrade3.Minerals < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade3.Minerals + ",M," + OutputModel.tradeCountry3 + "," );
			else if( ExpenseModel.PrivateTrade3.Iron < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade3.Iron + ",I," + OutputModel.tradeCountry3 + "," );
			else if( ExpenseModel.PrivateTrade3.Oil < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade3.Oil + ",O," + OutputModel.tradeCountry3 + "," );
			else if( ExpenseModel.PrivateTrade3.PMetals < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade3.PMetals + ",P," + OutputModel.tradeCountry3 + "," );
			else if( ExpenseModel.PrivateTrade3.Uranium < 0 )
				fileStream.writeUTFBytes( -ExpenseModel.PrivateTrade3.Uranium + ",U," + OutputModel.tradeCountry3 + "," );
			else
				fileStream.writeUTFBytes( ",,," );
			if( ExpenseModel.PrivateTrade3.Food > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade3.Food + ",F" );
			else if( ExpenseModel.PrivateTrade3.Minerals > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade3.Minerals + ",M" );
			else if( ExpenseModel.PrivateTrade3.Iron > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade3.Iron + ",I" );
			else if( ExpenseModel.PrivateTrade3.Oil > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade3.Oil + ",O" );
			else if( ExpenseModel.PrivateTrade3.PMetals > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade3.PMetals + ",P" );
			else if( ExpenseModel.PrivateTrade3.Uranium > 0 )
				fileStream.writeUTFBytes( ExpenseModel.PrivateTrade3.Uranium + ",U" );
			else
				fileStream.writeUTFBytes( "," );
			fileStream.writeUTFBytes( "\n" );
		}
		
		private static function writeAid() : void {
			fileStream.writeUTFBytes( "AID " );
			if( ExpenseModel.ForeignAid1 < 0 ) fileStream.writeUTFBytes( "" + -ExpenseModel.ForeignAid1 );
			fileStream.writeUTFBytes( "," );
			if( ExpenseModel.ForeignAid1 < 0 ) fileStream.writeUTFBytes( "" + OutputModel.foreignAidCountry1 );
			fileStream.writeUTFBytes( "\n" );
			
			if( PlayerTurnModel.superpower ) {
				fileStream.writeUTFBytes( "AID " );
				if( ExpenseModel.ForeignAid2 < 0 ) fileStream.writeUTFBytes( "" + -ExpenseModel.ForeignAid2 );
				fileStream.writeUTFBytes( "," );
				if( ExpenseModel.ForeignAid2 < 0 ) fileStream.writeUTFBytes( "" + OutputModel.foreignAidCountry2 );
				fileStream.writeUTFBytes( "\n" );
			}
		}
		
		private static function writeAlly() : void {
			fileStream.writeUTFBytes( "ALLY " );
			if( OutputModel.allianceMake1 > 0 ) fileStream.writeUTFBytes( "" + OutputModel.allianceMake1 );
			fileStream.writeUTFBytes( "," );
			if( OutputModel.allianceBreak1 > 0 ) fileStream.writeUTFBytes( "" + OutputModel.allianceBreak1 );
			fileStream.writeUTFBytes( "\n" );
			
			if( PlayerTurnModel.superpower ) {
				fileStream.writeUTFBytes( "ALLY " );
				if( OutputModel.allianceMake2 > 0 ) fileStream.writeUTFBytes( "" + OutputModel.allianceMake2 );
				fileStream.writeUTFBytes( "," );
				if( OutputModel.allianceBreak2 > 0 ) fileStream.writeUTFBytes( "" + OutputModel.allianceBreak2 );
				fileStream.writeUTFBytes( "\n" );
			}
		}
		
		private static function writeDisband() : void {
			fileStream.writeUTFBytes( "DISBAND " );
			if( OutputModel.scrapQty1 > 0 ) fileStream.writeUTFBytes( OutputModel.scrapQty1 + "," + OutputModel.scrapUnit1 + "," + OutputModel.scrapHex1 );
			else fileStream.writeUTFBytes( ",," );
			fileStream.writeUTFBytes( "\n" );
			
			fileStream.writeUTFBytes( "DISBAND " );
			if( OutputModel.scrapQty2 > 0 ) fileStream.writeUTFBytes( OutputModel.scrapQty2 + "," + OutputModel.scrapUnit2 + "," + OutputModel.scrapHex2 );
			else fileStream.writeUTFBytes( ",," );
			fileStream.writeUTFBytes( "\n" );
		}
		
		private static function writeDrophex() : void {
			fileStream.writeUTFBytes( "DROPHEX " );
			if( OutputModel.dropHex != null ) fileStream.writeUTFBytes( OutputModel.dropHex );
			fileStream.writeUTFBytes( "\n" );
		}
		
		private static function writeTech() : void {
			fileStream.writeUTFBytes( "TECH " );
			fileStream.writeUTFBytes( -ExpenseModel.InfTech + "," + -ExpenseModel.VehTech + "," + -ExpenseModel.AerTech + "," + -ExpenseModel.NavTech + "," + -ExpenseModel.NucTech );
			fileStream.writeUTFBytes( "\n" );
		}
		
		private static function writeProduction() : void {
			fileStream.writeUTFBytes( "PROD " );
			if( OutputModel.prodQty1 > 0 ) fileStream.writeUTFBytes( OutputModel.prodQty1 + "," + OutputModel.prodUnit1 + "," + OutputModel.prodSourceHex1 + "," + OutputModel.prodDestHex1 );
			else fileStream.writeUTFBytes( ",,," );
			fileStream.writeUTFBytes( "\n" );
			
			fileStream.writeUTFBytes( "PROD " );
			if( OutputModel.prodQty2 > 0 ) fileStream.writeUTFBytes( OutputModel.prodQty2 + "," + OutputModel.prodUnit2 + "," + OutputModel.prodSourceHex2 + "," + OutputModel.prodDestHex2 );
			else fileStream.writeUTFBytes( ",,," );
			fileStream.writeUTFBytes( "\n" );
			
			fileStream.writeUTFBytes( "PROD " );
			if( OutputModel.prodQty3 > 0 ) fileStream.writeUTFBytes( OutputModel.prodQty3 + "," + OutputModel.prodUnit3 + "," + OutputModel.prodSourceHex3 + "," + OutputModel.prodDestHex3 );
			else fileStream.writeUTFBytes( ",,," );
			fileStream.writeUTFBytes( "\n" );
			
			fileStream.writeUTFBytes( "PROD " );
			if( OutputModel.prodQty4 > 0 ) fileStream.writeUTFBytes( OutputModel.prodQty4 + "," + OutputModel.prodUnit4 + "," + OutputModel.prodSourceHex4 + "," + OutputModel.prodDestHex4 );
			else fileStream.writeUTFBytes( ",,," );
			fileStream.writeUTFBytes( "\n" );
			
			fileStream.writeUTFBytes( "PROD " );
			if( OutputModel.prodQty5 > 0 ) fileStream.writeUTFBytes( OutputModel.prodQty5 + "," + OutputModel.prodUnit5 + "," + OutputModel.prodSourceHex5 + "," + OutputModel.prodDestHex5 );
			else fileStream.writeUTFBytes( ",,," );
			fileStream.writeUTFBytes( "\n" );
		}
		
		private static function writeNatsec() : void {
			fileStream.writeUTFBytes( "NATSEC " + -ExpenseModel.NationalSecurity + "\n" );
		}
		
		private static function writeTacnuke() : void {
			fileStream.writeUTFBytes( "TACNUKE " );
			if( OutputModel.tacNuke ) fileStream.writeUTFBytes( OutputModel.tacNuke );
			fileStream.writeUTFBytes( "\n" );
		}
		
		private static function writeEspionage() : void {
			fileStream.writeUTFBytes( "ESP " );
			if( ExpenseModel.Espionage1 < 0 ) {
				fileStream.writeUTFBytes( -ExpenseModel.Espionage1 + "," + OutputModel.espMission1 + "," );
				if( OutputModel.espCountry1 > 0 ) fileStream.writeUTFBytes( "" + OutputModel.espCountry1 );
				else fileStream.writeUTFBytes( OutputModel.espHex1 );
				fileStream.writeUTFBytes( "," + OutputModel.espExtra1 );
			} else
				fileStream.writeUTFBytes( ",,," );
			fileStream.writeUTFBytes( "\n" );
			
			fileStream.writeUTFBytes( "ESP " );
			if( ExpenseModel.Espionage2 < 0 ) {
				fileStream.writeUTFBytes( -ExpenseModel.Espionage2 + "," + OutputModel.espMission2 + "," );
				if( OutputModel.espCountry2 > 0 ) fileStream.writeUTFBytes( "" + OutputModel.espCountry2 );
				else fileStream.writeUTFBytes( OutputModel.espHex2 );
				fileStream.writeUTFBytes( "," + OutputModel.espExtra2 );
			} else
				fileStream.writeUTFBytes( ",,," );
			fileStream.writeUTFBytes( "\n" );
			
			fileStream.writeUTFBytes( "ESP " );
			if( ExpenseModel.Espionage3 < 0 ) {
				fileStream.writeUTFBytes( -ExpenseModel.Espionage3 + "," + OutputModel.espMission3 + "," );
				if( OutputModel.espCountry3 > 0 ) fileStream.writeUTFBytes( "" + OutputModel.espCountry3 );
				else fileStream.writeUTFBytes( OutputModel.espHex3 );
				fileStream.writeUTFBytes( "," + OutputModel.espExtra3 );
			} else
				fileStream.writeUTFBytes( ",,," );
			fileStream.writeUTFBytes( "\n" );
			fileStream.writeUTFBytes( "\n" );
		}
		
		private static function writeActions() : void {
			var i : int = 0;
			for( i = 0; i < 12; ++i ) {
				writeAction( i );
			}
			
			if( PlayerTurnModel.superpower ) {
				for( i = 12; i < 24; ++i ) {
					writeAction( i );
				}
			}
			fileStream.writeUTFBytes( "\n" );
		}
		
		private static function writeAction( lineNumber : int ) : void {
			var row : ActionRow = OutputModel.actionArray[lineNumber];
				
			fileStream.writeUTFBytes( "ACTION " );
			if( row != null ) {
				fileStream.writeUTFBytes( row.Qty + "," );
				fileStream.writeUTFBytes( row.Unit + "," );
				fileStream.writeUTFBytes( row.Source + "," );
				fileStream.writeUTFBytes( row.Mission + "," );
				fileStream.writeUTFBytes( row.Hex0 + "," );
				fileStream.writeUTFBytes( row.Hex1 + "," );
				fileStream.writeUTFBytes( row.Hex2 + "," );
				fileStream.writeUTFBytes( row.Hex3 + "," );
				fileStream.writeUTFBytes( row.Hex4 + "," );
				fileStream.writeUTFBytes( row.Hex5 + "," );
				fileStream.writeUTFBytes( row.Hex6 + "," );
				fileStream.writeUTFBytes( row.Hex7 + "," );
				fileStream.writeUTFBytes( row.Hex8 + "," );
				fileStream.writeUTFBytes( row.Hex9 );
			} else {
				fileStream.writeUTFBytes( ",,,,,,,,,,,,," );
			}
			fileStream.writeUTFBytes( "\n" );
		}
		
		private static function writePress() : void {
			switch( OutputModel.pressNumber ) {
				case 1:
					if( OutputModel.pressText0 == "" ) break;
					if( OutputModel.pressAnon0 )
						fileStream.writeUTFBytes( "ANONYMOUS 0\n" );
					fileStream.writeUTFBytes( "CONT 0,1\n" );
					
					writePressText( "PRESS0", OutputModel.pressText0 );
					break;
				
				case 2:
					if( OutputModel.pressAnon0 && OutputModel.pressAnon1 )
						fileStream.writeUTFBytes( "ANONYMOUS 0,1\n" );
					else if( OutputModel.pressAnon0 )
						fileStream.writeUTFBytes( "ANONYMOUS 0\n" );
					else if( OutputModel.pressAnon1 )
						fileStream.writeUTFBytes( "ANONYMOUS 1\n" );
					fileStream.writeUTFBytes( "CONT 0\n" );
					
					writePressText( "PRESS0", OutputModel.pressText0 );
					writePressText( "PRESS1", OutputModel.pressText1 );
					break;
				
				case 3:
					if( OutputModel.pressAnon0 && OutputModel.pressAnon1 && OutputModel.pressAnon2  )
						fileStream.writeUTFBytes( "ANONYMOUS 0,1,2\n" );
					else if( OutputModel.pressAnon0 && OutputModel.pressAnon1  )
						fileStream.writeUTFBytes( "ANONYMOUS 0,1\n" );
					else if( OutputModel.pressAnon0 && OutputModel.pressAnon2  )
						fileStream.writeUTFBytes( "ANONYMOUS 0,2\n" );
					else if( OutputModel.pressAnon1 && OutputModel.pressAnon2  )
						fileStream.writeUTFBytes( "ANONYMOUS 1,2\n" );
					else if( OutputModel.pressAnon0 )
						fileStream.writeUTFBytes( "ANONYMOUS 0\n" );
					else if( OutputModel.pressAnon1 )
						fileStream.writeUTFBytes( "ANONYMOUS 1\n" );
					else if( OutputModel.pressAnon2 )
						fileStream.writeUTFBytes( "ANONYMOUS 2\n" );
					
					writePressText( "PRESS0", OutputModel.pressText0 );
					writePressText( "PRESS1", OutputModel.pressText1 );
					writePressText( "PRESS2", OutputModel.pressText2 );
					break;
			}
		}
		
		private static const LINE_WRAP : RegExp = /.{1,65}\s+/g;
		private static function writePressText( header : String, text : String ) : void {
			text = text + " ";
			var a : Array = LINE_WRAP.exec( text );
			while( a != null ) {
				fileStream.writeUTFBytes( header + " " + a + "\n" );
				a = LINE_WRAP.exec( text );
			}
			fileStream.writeUTFBytes( "\n" );
		}
		
		private static function closeFile() : void {
			fileStream.close();
			Alert.show( "Turn file saved successfully" );
		}
	}
}