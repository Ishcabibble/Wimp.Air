package com.ish.wimp.controller {
	import com.ish.wimp.mxml.Map;
	import com.ish.wimp.mxml.popup.IncidentPopup;
	import com.ish.wimp.mxml.popup.UnitPopup;
	
	import flash.events.MouseEvent;
	
	import mx.events.CloseEvent;
	import mx.managers.PopUpManager;
	
	import spark.events.TitleWindowBoundsEvent;

	public class IconClickHandler {
		public function handleHexNumberClick( evt : MouseEvent, hex : int ) : void {
			trace( "hex number clicked in hex " + hex );
		}
		
		public function handleIncidentClick( evt : MouseEvent, hex : int ) : void {
			var popup : IncidentPopup = new IncidentPopup( );
			popup.hex = hex;
			popup.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
			popup.addEventListener( MouseEvent.MOUSE_UP, mouseUpHandler );
			popup.addEventListener( TitleWindowBoundsEvent.WINDOW_MOVING, windowMovingHandler );
			popup.addEventListener( CloseEvent.CLOSE, function (evt : CloseEvent) : void { PopUpManager.removePopUp( IncidentPopup( evt.target ) ); });
			PopUpManager.addPopUp( popup, Map.publicGroup );
			PopUpManager.centerPopUp( popup );
		}
		
		public function handleUnitClick( evt : MouseEvent, hex : int ) : void {
			var popup : UnitPopup = new UnitPopup( );
			popup.hex = hex;
			popup.addEventListener( MouseEvent.MOUSE_DOWN, mouseDownHandler );
			popup.addEventListener( MouseEvent.MOUSE_UP, mouseUpHandler );
			popup.addEventListener( TitleWindowBoundsEvent.WINDOW_MOVING, windowMovingHandler );
			popup.addEventListener( CloseEvent.CLOSE, function (evt : CloseEvent) : void { PopUpManager.removePopUp( UnitPopup( evt.target ) ); });
			PopUpManager.addPopUp( popup, Map.publicGroup );
			PopUpManager.centerPopUp( popup );
		}
		
		public function handleFactoryClick( evt : MouseEvent, hex : int ) : void {
			trace( "factory clicked in hex " + hex );
		}
		
		// solve conflict with dragging popup and panning map
		private function mouseDownHandler( evt : MouseEvent ) : void { Map.isDraggingPopup = true; }
		private function mouseUpHandler( evt : MouseEvent ) : void { Map.isDraggingPopup = false; }
		
		// don't let the popup drag outside the application
		private function windowMovingHandler( evt : TitleWindowBoundsEvent ) : void {
			if( evt.afterBounds.left < 0 )
				evt.afterBounds.left = 0;
			else if( evt.afterBounds.right > Map.publicSytemManager.stage.stageWidth )
				evt.afterBounds.left = Map.publicSytemManager.stage.stageWidth - evt.afterBounds.width;
			
			if( evt.afterBounds.top < 0 )
				evt.afterBounds.top = 0;
			else if( evt.afterBounds.bottom > Map.publicSytemManager.stage.stageHeight )
				evt.afterBounds.top = Map.publicSytemManager.stage.stageHeight - evt.afterBounds.height;
		}
	}
}