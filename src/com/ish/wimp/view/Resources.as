package com.ish.wimp.view {
	public final class Resources {
		[Embed (source="img/water.png")] public static const IMG_WATER : Class;
		[Embed (source="img/fact.png")] public static const IMG_FACT : Class;
		[Embed (source="img/food.png")] public static const IMG_FOOD : Class;
		[Embed (source="img/iron.png")] public static const IMG_IRON : Class;
		[Embed (source="img/minerals.png")] public static const IMG_MINERALS : Class;
		[Embed (source="img/oil.png")] public static const IMG_OIL : Class;
		[Embed (source="img/precious_metals.png")] public static const IMG_PRECIOUS_METALS : Class;
		[Embed (source="img/uranium.png")] public static const IMG_URANIUM : Class;
		
		[Embed (source="img/incident.png")] public static const IMG_INCIDENT : Class;
		[Embed (source="img/ownedGroundUnit.png")] public static const IMG_OWNED_GROUND_UNIT : Class;
		[Embed (source="img/ownedNavalUnit.png")] public static const IMG_OWNED_NAVAL_UNIT : Class;
		[Embed (source="img/ownedFactory.png")] public static const IMG_OWNED_FACTORY : Class;
		
		[Embed (source="img/alliedGroundUnit.png")] public static const IMG_ALLIED_GROUND_UNIT : Class;
		[Embed (source="img/alliedNavalUnit.png")] public static const IMG_ALLIED_NAVAL_UNIT : Class;
		[Embed (source="img/alliedFactory.png")] public static const IMG_ALLIED_FACTORY : Class;
		
		public static function getImgByLetter( str : String ) : Class {
			switch( str ) {
				case "W": return IMG_WATER;
				case "C": return IMG_FACT;
				case "F": return IMG_FOOD;
				case "I": return IMG_IRON;
				case "M": return IMG_MINERALS;
				case "O": return IMG_OIL;
				case "P": return IMG_PRECIOUS_METALS;
				case "R": return IMG_URANIUM;
			}
			return null;
		}
	}
}