package com.ish.wimp.model {
	public class ExpenseModel {
		private static var startingBalance : ExpenseLineModel = new ExpenseLineModel();
		
		private static var scrap1 : ExpenseLineModel = new ExpenseLineModel();
		private static var scrap2 : ExpenseLineModel = new ExpenseLineModel();
		private static var scrapTotal : ExpenseLineModel = new ExpenseLineModel();
		
		private static var production1 : ExpenseLineModel = new ExpenseLineModel();
		private static var production2 : ExpenseLineModel = new ExpenseLineModel();
		private static var production3 : ExpenseLineModel = new ExpenseLineModel();
		private static var production4 : ExpenseLineModel = new ExpenseLineModel();
		private static var production5 : ExpenseLineModel = new ExpenseLineModel();
		private static var productionTotal : ExpenseLineModel = new ExpenseLineModel();
		
		private static var worldMarketFood : ExpenseLineModel = new ExpenseLineModel();
		private static var worldMarketMinerals : ExpenseLineModel = new ExpenseLineModel();
		private static var worldMarketIron : ExpenseLineModel = new ExpenseLineModel();
		private static var worldMarketOil : ExpenseLineModel = new ExpenseLineModel();
		private static var worldMarketPMetals : ExpenseLineModel = new ExpenseLineModel();
		private static var worldMarketUranium : ExpenseLineModel = new ExpenseLineModel();
		private static var worldMarket : ExpenseLineModel = new ExpenseLineModel();
		
		private static var privateTrade1 : ExpenseLineModel = new ExpenseLineModel();
		private static var privateTrade2 : ExpenseLineModel = new ExpenseLineModel();
		private static var privateTrade3 : ExpenseLineModel = new ExpenseLineModel();
		private static var foreignAid1 : int;
		private static var foreignAid2 : int;
		private static var privateTradeTotal : ExpenseLineModel = new ExpenseLineModel();
		
		private static var infTech : int;
		private static var vehTech : int;
		private static var aerTech : int;
		private static var navTech : int;
		private static var nucTech : int;
		private static var techRecovery : ExpenseLineModel = new ExpenseLineModel();
		
		private static var espionage1 : int;
		private static var espionage2 : int;
		private static var espionage3 : int;
		private static var nationalSecurity : int;
		private static var espionageTotal : ExpenseLineModel = new ExpenseLineModel();
		
		private static var endingBalance : ExpenseLineModel = new ExpenseLineModel();
		
		// ********************************************************************************************************************************
		
		[Bindable] public static function get StartingBalance( ) : ExpenseLineModel { return startingBalance; }
		
		[Bindable] public static function get Scrap1( ) : ExpenseLineModel { return scrap1; }
		[Bindable] public static function get Scrap2( ) : ExpenseLineModel { return scrap2; }
		[Bindable] public static function get ScrapTotal( ) : ExpenseLineModel {
			return new ExpenseLineModel(
				Scrap1.Food + Scrap2.Food,
				Scrap1.Minerals + Scrap2.Minerals,
				Scrap1.Iron + Scrap2.Iron,
				Scrap1.Oil + Scrap2.Oil,
				Scrap1.PMetals + Scrap2.PMetals,
				Scrap1.Uranium + Scrap2.Uranium,
				Scrap1.Ecs + Scrap2.Ecs
			);
		}
		
		[Bindable] public static function get Production1( ) : ExpenseLineModel { return production1; }
		[Bindable] public static function get Production2( ) : ExpenseLineModel { return production2; }
		[Bindable] public static function get Production3( ) : ExpenseLineModel { return production3; }
		[Bindable] public static function get Production4( ) : ExpenseLineModel { return production4; }
		[Bindable] public static function get Production5( ) : ExpenseLineModel { return production5; }
		[Bindable] public static function get ProductionTotal( ) : ExpenseLineModel {
			return new ExpenseLineModel(
				Production1.Food + Production2.Food + Production3.Food + Production4.Food + Production5.Food,
				Production1.Minerals + Production2.Minerals + Production3.Minerals + Production4.Minerals + Production5.Minerals,
				Production1.Iron + Production2.Iron + Production3.Iron + Production4.Iron + Production5.Iron,
				Production1.Oil + Production2.Oil + Production3.Oil + Production4.Oil + Production5.Oil,
				Production1.PMetals + Production2.PMetals + Production3.PMetals + Production4.PMetals + Production5.PMetals,
				Production1.Uranium + Production2.Uranium + Production3.Uranium + Production4.Uranium + Production5.Uranium,
				Production1.Ecs + Production2.Ecs + Production3.Ecs + Production4.Ecs + Production5.Ecs
			);
		}
		
		[Bindable] public static function get WorldMarketFood( ) : ExpenseLineModel { return worldMarketFood; }
		[Bindable] public static function get WorldMarketMinerals( ) : ExpenseLineModel { return worldMarketMinerals; }
		[Bindable] public static function get WorldMarketIron( ) : ExpenseLineModel { return worldMarketIron; }
		[Bindable] public static function get WorldMarketOil( ) : ExpenseLineModel { return worldMarketOil; }
		[Bindable] public static function get WorldMarketPMetals( ) : ExpenseLineModel { return worldMarketPMetals; }
		[Bindable] public static function get WorldMarketUranium( ) : ExpenseLineModel { return worldMarketUranium; }
		[Bindable] public static function get WorldMarket( ) : ExpenseLineModel {
			return new ExpenseLineModel(
				WorldMarketFood.Food, WorldMarketMinerals.Minerals, WorldMarketIron.Iron, WorldMarketOil.Oil, WorldMarketPMetals.PMetals, WorldMarketUranium.Uranium,
				WorldMarketFood.Ecs + WorldMarketMinerals.Ecs + WorldMarketIron.Ecs + WorldMarketOil.Ecs + WorldMarketPMetals.Ecs + WorldMarketUranium.Ecs
			);
		}
		
		[Bindable] public static function get PrivateTrade1( ) : ExpenseLineModel { return privateTrade1; }
		[Bindable] public static function get PrivateTrade2( ) : ExpenseLineModel { return privateTrade2; }
		[Bindable] public static function get PrivateTrade3( ) : ExpenseLineModel { return privateTrade3; }
		[Bindable] public static function get ForeignAid1( ) : int { return foreignAid1; }
		[Bindable] public static function get ForeignAid2( ) : int { return foreignAid2; }
		[Bindable] public static function get PrivateTradeTotal( ) : ExpenseLineModel {
			return new ExpenseLineModel(
				PrivateTrade1.Food + PrivateTrade2.Food + PrivateTrade3.Food,
				PrivateTrade1.Minerals + PrivateTrade2.Minerals + PrivateTrade3.Minerals,
				PrivateTrade1.Iron + PrivateTrade2.Iron + PrivateTrade3.Iron,
				PrivateTrade1.Oil + PrivateTrade2.Oil + PrivateTrade3.Oil,
				PrivateTrade1.PMetals + PrivateTrade2.PMetals + PrivateTrade3.PMetals,
				PrivateTrade1.Uranium + PrivateTrade2.Uranium + PrivateTrade3.Uranium,
				ForeignAid1 + ForeignAid2
			);
		}
		
		[Bindable] public static function get InfTech( ) : int { return infTech; }
		[Bindable] public static function get VehTech( ) : int { return vehTech; }
		[Bindable] public static function get AerTech( ) : int { return aerTech; }
		[Bindable] public static function get NavTech( ) : int { return navTech; }
		[Bindable] public static function get NucTech( ) : int { return nucTech; }
		[Bindable] public static function get TechRecovery( ) : ExpenseLineModel { 
			return new ExpenseLineModel( 0, 0, 0, 0, 0, 0, InfTech + VehTech + AerTech + NavTech + NucTech );
		}
		
		[Bindable] public static function get Espionage1( ) : int { return espionage1; }
		[Bindable] public static function get Espionage2( ) : int { return espionage2; }
		[Bindable] public static function get Espionage3( ) : int { return espionage3; }
		[Bindable] public static function get NationalSecurity( ) : int { return nationalSecurity; }
		[Bindable] public static function get EspionageTotal( ) : ExpenseLineModel { 
			return new ExpenseLineModel( 0, 0, 0, 0, 0, 0, Espionage1 + Espionage2 + Espionage3 + NationalSecurity );
		}
		
		[Bindable] public static function get EndingBalance( ) : ExpenseLineModel {
			return new ExpenseLineModel(
				StartingBalance.Food + ScrapTotal.Food + ProductionTotal.Food + WorldMarket.Food + PrivateTradeTotal.Food,
				StartingBalance.Minerals + ScrapTotal.Minerals + ProductionTotal.Minerals + WorldMarket.Minerals + PrivateTradeTotal.Minerals,
				StartingBalance.Iron + ScrapTotal.Iron + ProductionTotal.Iron + WorldMarket.Iron + PrivateTradeTotal.Iron,
				StartingBalance.Oil + ScrapTotal.Oil + ProductionTotal.Oil + WorldMarket.Oil + PrivateTradeTotal.Oil,
				StartingBalance.PMetals + ScrapTotal.PMetals + ProductionTotal.PMetals + WorldMarket.PMetals + PrivateTradeTotal.PMetals,
				StartingBalance.Uranium + ScrapTotal.Uranium + ProductionTotal.Uranium + WorldMarket.Uranium + PrivateTradeTotal.Uranium,
				StartingBalance.Ecs + ScrapTotal.Ecs + ProductionTotal.Ecs + WorldMarket.Ecs + PrivateTradeTotal.Ecs + TechRecovery.Ecs + EspionageTotal.Ecs
			);
		}
		
		// ********************************************************************************************************************************
		
		public static function set StartingBalance( value : ExpenseLineModel ) : void { startingBalance = value; }
		
		public static function set Scrap1( value : ExpenseLineModel ) : void { scrap1 = value; }
		public static function set Scrap2( value : ExpenseLineModel ) : void { scrap2 = value; }
		public static function set ScrapTotal( value : ExpenseLineModel ) : void { scrapTotal = value; }
		
		public static function set Production1( value : ExpenseLineModel ) : void { production1 = value; }
		public static function set Production2( value : ExpenseLineModel ) : void { production2 = value; }
		public static function set Production3( value : ExpenseLineModel ) : void { production3 = value; }
		public static function set Production4( value : ExpenseLineModel ) : void { production4 = value; }
		public static function set Production5( value : ExpenseLineModel ) : void { production5 = value; }
		public static function set ProductionTotal( value : ExpenseLineModel ) : void { productionTotal = value; }
		
		public static function set WorldMarketFood( value : ExpenseLineModel ) : void { worldMarketFood = value; }
		public static function set WorldMarketMinerals( value : ExpenseLineModel ) : void { WorldMarketMinerals = value; }
		public static function set WorldMarketIron( value : ExpenseLineModel ) : void { worldMarketIron = value; }
		public static function set WorldMarketOil( value : ExpenseLineModel ) : void { worldMarketOil = value; }
		public static function set WorldMarketPMetals( value : ExpenseLineModel ) : void { worldMarketPMetals = value; }
		public static function set WorldMarketUranium( value : ExpenseLineModel ) : void { worldMarketUranium = value; }
		public static function set WorldMarket( value : ExpenseLineModel ) : void { worldMarket = value; }
		
		public static function set PrivateTrade1( value : ExpenseLineModel ) : void { PrivateTrade1 = value; }
		public static function set PrivateTrade2( value : ExpenseLineModel ) : void { PrivateTrade2 = value; }
		public static function set PrivateTrade3( value : ExpenseLineModel ) : void { PrivateTrade3 = value; }
		public static function set ForeignAid1( value : int ) : void { foreignAid1 = value; }
		public static function set ForeignAid2( value : int ) : void { foreignAid2 = value; }
		public static function set PrivateTradeTotal( value : ExpenseLineModel ) : void { privateTradeTotal = value; }
		
		public static function set InfTech( value : int ) : void { infTech = value; }
		public static function set VehTech( value : int ) : void { vehTech = value; }
		public static function set AerTech( value : int ) : void { aerTech = value; }
		public static function set NavTech( value : int ) : void { navTech = value; }
		public static function set NucTech( value : int ) : void { nucTech = value; }
		public static function set TechRecovery( value : ExpenseLineModel ) : void { techRecovery = value; }
		
		public static function set Espionage1( value : int ) : void { espionage1 = value; }
		public static function set Espionage2( value : int ) : void { espionage2 = value; }
		public static function set Espionage3( value : int ) : void { espionage3 = value; }
		public static function set NationalSecurity( value : int ) : void { nationalSecurity = value; }
		public static function set EspionageTotal( value : ExpenseLineModel ) : void { espionageTotal = value; }
		
		public static function set EndingBalance( value : ExpenseLineModel ) : void { endingBalance = value; }
	}
}