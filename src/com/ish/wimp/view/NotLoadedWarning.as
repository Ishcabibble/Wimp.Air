package com.ish.wimp.view {
	import mx.controls.Alert;

	public class NotLoadedWarning {
		public static function playerTurnNotLoaded() : void {
			Alert.show( "this feature will not work until a player turn file is loaded." );
		}
		
		public static function worldPressNotLoaded() : void {
			Alert.show( "this feature will not work until a world press file is loaded." );
		}
	}
}