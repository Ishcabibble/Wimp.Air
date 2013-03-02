package com.ish.wimp.model.input {
	import flash.utils.Dictionary;
	
	import mx.collections.ArrayList;

	public class PlayerTurnModel {
		public static var playerName : String;
		public static var accountNumber : int;
		public static var gameNumber : int;
		public static var turnNumber : int;
		public static var countryNumber : int;
		public static var countryName : String;
		
		public static var alliances : ArrayList;
		public static var nationalSecurityLevel : int;
		
		[Bindable] public static var takNuke : int;
		public static var combatMap : Dictionary;
		
		public static var infTechLevel : int;
		public static var vehTechLevel : int;
		public static var aerTechLevel : int;
		public static var navTechLevel : int;
		public static var nucTechLevel : int;
		
		public static var positionMap : Dictionary;
		public static var ownedHexList : ArrayList;
		public static var contestedHexList : ArrayList;
		
		[Bindable] public static var superpower : Boolean = false;
	}
}