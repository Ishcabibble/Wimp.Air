package com.ish.wimp.model.input {
	import flash.utils.Dictionary;

	public class WorldPressModel {
		public static var turn : int;
		public static var worldMarketFood : WorldMarketResourceLine;
		public static var worldMarketMinerals: WorldMarketResourceLine;
		public static var worldMarketIron : WorldMarketResourceLine;
		public static var worldMarketOil : WorldMarketResourceLine;
		public static var worldMarketPMetals : WorldMarketResourceLine;
		public static var worldMarketUranium : WorldMarketResourceLine;
		
		public static var nuclearDetonations : Dictionary;
	}
}