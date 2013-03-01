package com.ish.wimp.view {
	import com.ish.wimp.controller.IconClickHandler;
	import com.ish.wimp.model.HexInfo;
	import com.ish.wimp.model.input.AllyTurnModel;
	import com.ish.wimp.model.input.PlayerTurnModel;
	import com.ish.wimp.model.input.WorldPressModel;
	import com.ish.wimp.parsers.MapParser;
	
	import flash.display.Graphics;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import mx.collections.ArrayList;
	import mx.controls.Image;
	import mx.controls.Text;
	
	import spark.components.Group;
	import spark.primitives.supportClasses.FilledElement;

	public class Map extends FilledElement{
		private static const NUM_ROWS : int = 36;
		private static const NUM_COLS : int = 84;
		
		private static const HEX_SIDE : int = 30;
		private static const HEX_LITTLE : int = 15;
		private static const HEX_BIG : int = 26;
		
		private static const HEX_WIDTH : int = HEX_SIDE + 2 * HEX_LITTLE;
		private static const HEX_HEIGHT : int = 2 * HEX_BIG;
		
		private static const HEX_NUMBER_SMALL_OFFSET : int = 11;
		private static const HEX_NUMBER_LARGE_OFFSET : int = 15;
		private static const ICON_HEIGHT_OFFSET : int = 24;
		private static const ICON_WIDTH_OFFSET1 : int = 14;
		private static const ICON_WIDTH_OFFSET2 : int = 30;
		private static const WATER_WIDTH_OFFSET : int = 12;
		private static const WATER_HEIGHT_OFFSET : int = 28;
		
		private static const INCIDENT_WIDTH_OFFSET : int = 9;
		private static const INCIDENT_HEIGHT_OFFSET : int = 18;
		
		private static const GROUND_UNIT_WIDTH_OFFSET : int = -4;
		private static const GROUND_UNIT_HEIGHT_OFFSET : int = 18;
		
		private static const NAVAL_UNIT_WIDTH_OFFSET : int = -4;
		private static const NAVAL_UNIT_HEIGHT_OFFSET : int = 16;
		
		private static const FACTORY_WIDTH_OFFSET : int = 22;
		private static const FACTORY_HEIGHT_OFFSET : int = 16;
		
		private static const WATER_COLOR : uint = 0xBEBEBE;
		private static const LAND_COLOR : uint = 0xFFFFFF;
		
		private static const OWNED_COLOR : uint = 0x00E200;
		private static const ALLY_COLOR : uint = 0xFFFF00;
		private static const CONTESTED_COLOR : uint = 0xFF3031;
		
		private static const OWNED_UNIT_COLOR : uint = 0x00a000;
		private static const ALLY_UNIT_COLOR : uint = 0x006B8D;
		
		private static const FONT_SIZE : int = 12;
		private static const FONT_NAME : String = "Courier";
		private static const DECORATION_UNDERLINE : String = "underline";
		private static const DECORATION_NONE : String = "none";
		
		private static const NORMAL_LINE_WIDTH : int = 1;
		private static const BORDER_LINE_WIDTH : int = 3;
		
		public static var mapInstance : Map;
		private var mapParser : MapParser;
		private var iconClickHandler : IconClickHandler;
		
		public function Map() {
			super();
			mapInstance = this;
			mapParser = new MapParser();
			iconClickHandler = new IconClickHandler();
		}
		
		private var group : Group;
		public function getGroup() : Group { return group; }
		public function setGroup( value : Group ) : void { group = value; }
		
		override protected function draw( g : Graphics ) : void {
			g.clear();
			
			var number : int;
			var outlineY1 : int = HEX_BIG;
			var outlineY2 : int = 0;
			var outlineX1 : int, outlineX2 : int;
			
			var numberY1 : int = HEX_BIG;
			var numberY2 : int = 0;
			var numberX1 : int, numberX2 : int;
			
			var iconY1 : int = HEX_BIG + ICON_HEIGHT_OFFSET;
			var iconY2 : int = ICON_HEIGHT_OFFSET;
			var iconX1 : int, iconX2 : int, iconX3 : int, iconX4 : int;
			
			var waterY1 : int = HEX_BIG + WATER_HEIGHT_OFFSET;
			var waterY2 : int = WATER_HEIGHT_OFFSET;
			var waterX1 : int, waterX2 : int;
			
			var i : int, j : int;
			
			// draw background
			for( i = 0; i < NUM_ROWS; ++i ) {
				number = 101 + i;
				outlineX1 = HEX_LITTLE;
				outlineX2 = HEX_WIDTH;
				for( j = 0; j < NUM_COLS/2; ++j ) {
					drawHexBackground( outlineX1, outlineY1, number, g );
					number += 100;
					drawHexBackground( outlineX2, outlineY2, number, g );
					number += 100;
					outlineX1 += HEX_WIDTH + HEX_SIDE;
					outlineX2 += HEX_WIDTH + HEX_SIDE;
				}
				outlineY1 += HEX_HEIGHT;
				outlineY2 += HEX_HEIGHT;
			}
			
			// reset a couple variables
			outlineY1 = HEX_BIG;
			outlineY2 = 0;
			
			// draw everything else
			for( i = 0; i < NUM_ROWS; ++i ) {
				number = 101 + i;
				outlineX1 = HEX_LITTLE;
				outlineX2 = HEX_WIDTH;
				numberX1 = HEX_NUMBER_LARGE_OFFSET;
				numberX2 = HEX_NUMBER_LARGE_OFFSET + HEX_SIDE + HEX_LITTLE;
				iconX1 = ICON_WIDTH_OFFSET1;
				iconX2 = ICON_WIDTH_OFFSET2;
				iconX3 = ICON_WIDTH_OFFSET1 + HEX_SIDE + HEX_LITTLE;
				iconX4 = ICON_WIDTH_OFFSET2 + HEX_SIDE + HEX_LITTLE;
				waterX1 = WATER_WIDTH_OFFSET;
				waterX2 = WATER_WIDTH_OFFSET + HEX_SIDE + HEX_LITTLE;
				
				for( j = 0; j < NUM_COLS/2; ++j ) {
					if( j == 4 ) { numberX2 += HEX_NUMBER_SMALL_OFFSET - HEX_NUMBER_LARGE_OFFSET; }
					else if( j == 5 ) { numberX1 += HEX_NUMBER_SMALL_OFFSET - HEX_NUMBER_LARGE_OFFSET; }
					
					drawHexOutline( outlineX1, outlineY1, number, g );
					addHexNumber( numberX1, numberY1, number );
					addIcon( iconX1, iconY1, number, 0 );
					addIcon( iconX2, iconY1, number, 1 );
					addWater( waterX1, waterY1, number );
					number += 100;
					
					drawHexOutline( outlineX2, outlineY2, number, g );
					addHexNumber( numberX2, numberY2, number );
					addIcon( iconX3, iconY2, number, 0 );
					addIcon( iconX4, iconY2, number, 1 );
					addWater( waterX2, waterY2, number );
					number += 100;
					
					outlineX1 += HEX_WIDTH + HEX_SIDE;
					outlineX2 += HEX_WIDTH + HEX_SIDE;
					numberX1 += HEX_WIDTH + HEX_SIDE;
					numberX2 += HEX_WIDTH + HEX_SIDE;
					iconX1 += HEX_WIDTH + HEX_SIDE;
					iconX2 += HEX_WIDTH + HEX_SIDE;
					iconX3 += HEX_WIDTH + HEX_SIDE;
					iconX4 += HEX_WIDTH + HEX_SIDE;
					waterX1 += HEX_WIDTH + HEX_SIDE;
					waterX2 += HEX_WIDTH + HEX_SIDE;
				}
				outlineY1 += HEX_HEIGHT;
				outlineY2 += HEX_HEIGHT;
				numberY1 += HEX_HEIGHT;
				numberY2 += HEX_HEIGHT;
				iconY1 += HEX_HEIGHT;
				iconY2 += HEX_HEIGHT;
				waterY1 += HEX_HEIGHT;
				waterY2 += HEX_HEIGHT;
			}
			
			// draw canals to finish off the base map
			drawCanals( g );
			
			// draw game specific details
			drawIncidents( );
			drawUnits( );
		}
		
		private function drawHexBackground( x : int, y : int, number : int, g : Graphics ) : void {
			var hexInfo : HexInfo = mapParser.getMap()[number] as HexInfo;
			var type : String = hexInfo.getType();
			var color : uint = type == "W" ? WATER_COLOR : LAND_COLOR;
			
			if( PlayerTurnModel.ownedHexList != null ) {
				var model : ArrayList = PlayerTurnModel.ownedHexList;
				if( PlayerTurnModel.ownedHexList.source.indexOf( number ) != -1 )
					color = OWNED_COLOR;
				else if( PlayerTurnModel.contestedHexList.source.indexOf( number ) != -1 )
					color = CONTESTED_COLOR;
			}
			
			if( AllyTurnModel.ownedHexList != null ) {
				if( AllyTurnModel.ownedHexList.source.indexOf( number ) != -1 )
					color = ALLY_COLOR;
				else if( AllyTurnModel.contestedHexList.source.indexOf( number ) != -1 )
					color = CONTESTED_COLOR;
			}
			
			g.moveTo( x, y );
			g.beginFill( color );
			g.lineTo( x + HEX_SIDE, y );
			g.lineTo( x + HEX_SIDE + HEX_LITTLE, y + HEX_BIG );
			g.lineTo( x + HEX_SIDE, y + HEX_HEIGHT );
			g.lineTo( x, y + HEX_HEIGHT );
			g.lineTo( x - HEX_LITTLE, y + HEX_BIG );
			g.lineTo( x, y );
			g.endFill();
		}
		
		private function drawHexOutline( x : int, y : int, number : int, g : Graphics ) : void {
			var hexInfo : HexInfo = mapParser.getMap()[number] as HexInfo;
			var type : String = hexInfo.getType();
			
			g.moveTo( x, y );
			if( !hexInfo.hasOutline() ) {
				g.lineTo( x + HEX_SIDE, y );
				g.lineTo( x + HEX_SIDE + HEX_LITTLE, y + HEX_BIG );
				g.lineTo( x + HEX_SIDE, y + HEX_HEIGHT );
				g.lineTo( x, y + HEX_HEIGHT );
				g.lineTo( x - HEX_LITTLE, y + HEX_BIG );
				g.lineTo( x, y );
			} else {
				var outline : String = hexInfo.getOutline();
				var width : int;
				
				width = outline.indexOf( "1" ) > -1 ? BORDER_LINE_WIDTH : NORMAL_LINE_WIDTH;
				g.lineStyle( width );
				g.lineTo( x + HEX_SIDE, y );
				
				width = outline.indexOf( "2" ) > -1 ? BORDER_LINE_WIDTH : NORMAL_LINE_WIDTH;
				g.lineStyle( width );
				g.lineTo( x + HEX_SIDE + HEX_LITTLE, y + HEX_BIG );
				
				width = outline.indexOf( "3" ) > -1 ? BORDER_LINE_WIDTH : NORMAL_LINE_WIDTH;
				g.lineStyle( width );
				g.lineTo( x + HEX_SIDE, y + HEX_HEIGHT );
				
				width = outline.indexOf( "4" ) > -1 ? BORDER_LINE_WIDTH : NORMAL_LINE_WIDTH;
				g.lineStyle( width );
				g.lineTo( x, y + HEX_HEIGHT );
				
				width = outline.indexOf( "5" ) > -1 ? BORDER_LINE_WIDTH : NORMAL_LINE_WIDTH;
				g.lineStyle( width );
				g.lineTo( x - HEX_LITTLE, y + HEX_BIG );
				
				width = outline.indexOf( "6" ) > -1 ? BORDER_LINE_WIDTH : NORMAL_LINE_WIDTH;
				g.lineStyle( width );
				g.lineTo( x, y );
				g.lineStyle( NORMAL_LINE_WIDTH );
			}
		}
		
		private function addHexNumber( x : int, y : int, number : int ) : void {
			var hexInfo : HexInfo = mapParser.getMap()[number] as HexInfo;
			var type : String = hexInfo.getType();
			var decoration : String = type == "C" || type == "N" ? DECORATION_UNDERLINE : DECORATION_NONE;
			
			var t : Text = new Text();
			t.x = x;
			t.y = y;
			t.text = number.toString();
			t.setStyle( "fontSize", FONT_SIZE );
			t.setStyle( "fontFamily", FONT_NAME );
			t.setStyle( "textDecoration", decoration );
			t.addEventListener(
				MouseEvent.CLICK,
				function( evt : MouseEvent ) : void {
					iconClickHandler.handleHexNumberClick( evt, number )
				}
			);
			group.addElement( t );
		}
		
		private function addIcon( x : int, y : int, number : int, side : int ) : void {
			var hexInfo : HexInfo = mapParser.getMap()[number] as HexInfo;
			var resources : String = hexInfo.getResources();
			if( resources != null && resources.length > side )
				addIconByString( x, y, resources.substr( side, 1 ) );
		}
		
		private function addIconByString( x : int, y : int, str : String ) : void {
			var img : Image = new Image();
			img.x = x;
			img.y = y;
			img.source = Resources.getImgByLetter( str );
			group.addElement( img );
		}
		
		private function addWater( x : int, y : int, number : int ) : void {
			var hexInfo : HexInfo = mapParser.getMap()[number] as HexInfo;
			var type : String = hexInfo.getType();
			if( type == "W" ) {
				var img : Image = new Image();
				img.x = x;
				img.y = y;
				img.source = Resources.getImgByLetter( "W" );
				group.addElement( img );
			}
		}
		
		private function drawCanals( g : Graphics ) : void {
			var startX : int, startY : int, endX : int, endY : int;
			g.lineStyle( 2 );
			
			// Panama : 1220->1221, 1220->1319
			startX = 5 * (HEX_WIDTH + HEX_SIDE) + HEX_WIDTH + .5 * HEX_SIDE;
			startY = 19 * HEX_HEIGHT + HEX_BIG;
			
			g.moveTo( startX, startY );
			endX = startX;
			endY = startY + HEX_HEIGHT;
			g.lineTo( endX, endY );
			g.lineTo( endX+3,endY-10 );
			g.lineTo( endX-3,endY-10 );
			g.lineTo( endX, endY );
			
			g.moveTo( startX, startY );
			endX = startX + .5 * (HEX_SIDE + HEX_WIDTH);
			endY = startY - HEX_BIG;
			g.lineTo( endX, endY );
			g.lineTo( endX-9, endY+2 );
			g.lineTo( endX-7, endY+8 );
			g.lineTo( endX, endY );
			
			// Dardanelles : 4013->4014, 4013->4112
			startX = 19 * (HEX_WIDTH + HEX_SIDE) + HEX_WIDTH + .5 * HEX_SIDE;
			startY = 12 * HEX_HEIGHT + HEX_BIG;
			
			g.moveTo( startX, startY );
			endX = startX + .5 * (HEX_SIDE + HEX_WIDTH);
			endY = startY - HEX_BIG;
			g.lineTo( endX, endY );
			g.lineTo( endX-9, endY+2 );
			g.lineTo( endX-7, endY+8 );
			g.lineTo( endX, endY );
			
			g.moveTo( startX, startY );
			endX = startX;
			endY = startY + HEX_HEIGHT;
			g.lineTo( endX, endY );
			g.lineTo( endX+3,endY-10 );
			g.lineTo( endX-3,endY-10 );
			g.lineTo( endX, endY );
			
			// Suez : 4317->4316, 4317->4418
			startX = 21 * (HEX_WIDTH + HEX_SIDE) + HEX_LITTLE + .5 * HEX_SIDE;
			startY = 17 * HEX_HEIGHT;
			
			g.moveTo( startX, startY );
			endX = startX;
			endY = startY - HEX_HEIGHT;
			g.lineTo( endX, endY );
			g.lineTo( endX+3,endY+10 );
			g.lineTo( endX-3,endY+10 );
			g.lineTo( endX, endY );
			
			g.moveTo( startX, startY );
			endX = startX + .5 * (HEX_SIDE + HEX_WIDTH);
			endY = startY + HEX_BIG;
			g.lineTo( endX, endY );
			g.lineTo( endX-10, endY-2 );
			g.lineTo( endX-7, endY-8 );
			g.lineTo( endX, endY );
		}
		
		private function drawIncidents( ) : void {
			var hexObj : Object
			var p : Point;
			
			// nukes
			for( hexObj in WorldPressModel.nuclearDetonations ) {
				p = getHexPos( hexObj as int );
				doDrawIncident( p.x, p.y, hexObj as int );
			}
			
			// combats
			for( hexObj in PlayerTurnModel.combatMap ) {
				p = getHexPos( hexObj as int );
				doDrawIncident( p.x, p.y, hexObj as int );
			}
		}
		
		private function doDrawIncident( x : int, y : int, hex : int ) : void {
			var img : Image = new Image();
			img.source = Resources.IMG_INCIDENT;
			img.x = x + INCIDENT_WIDTH_OFFSET;
			img.y = y + INCIDENT_HEIGHT_OFFSET;
			img.addEventListener(
				MouseEvent.CLICK,
				function( evt : MouseEvent ) : void {
					iconClickHandler.handleIncidentClick( evt, hex )
				}
			);
			group.addElement( img );
		}
		
		private function drawUnits( ) : void {
			var hexObj : Object;
			var p : Point;
			
			for( hexObj in PlayerTurnModel.positionMap ) {
				p = getHexPos( hexObj as int );
				doDrawUnit( p.x, p.y, hexObj as int, true );
				doDrawFactory( p.x, p.y, hexObj as int, true );
			}
			
			for( hexObj in AllyTurnModel.positionMap ) {
				p = getHexPos( hexObj as int );
				doDrawUnit( p.x, p.y, hexObj as int, false );
				doDrawFactory( p.x, p.y, hexObj as int, false );
			}
		}
		
		private function doDrawUnit( x : int, y : int, hex : int, owned : Boolean ) : void {
			var img : Image = new Image();
			var hexInfo : HexInfo = mapParser.getMap()[hex] as HexInfo;
			if( hexInfo.getType() == "W" ) {
				img.source = owned ?  Resources.IMG_OWNED_NAVAL_UNIT : Resources.IMG_ALLIED_NAVAL_UNIT;
				img.x = x + NAVAL_UNIT_WIDTH_OFFSET;
				img.y = y + NAVAL_UNIT_HEIGHT_OFFSET;
			} else {
				img.source = owned ? Resources.IMG_OWNED_GROUND_UNIT : Resources.IMG_ALLIED_GROUND_UNIT;
				img.x = x + GROUND_UNIT_WIDTH_OFFSET;
				img.y = y + GROUND_UNIT_HEIGHT_OFFSET;
			}
			img.addEventListener(
				MouseEvent.CLICK,
				function( evt : MouseEvent ) : void {
					iconClickHandler.handleUnitClick( evt, hex )
				}
			);
			group.addElement( img );
		}
		
		private function doDrawFactory( x : int, y : int, hex : int, owned : Boolean ) : void {
			var img : Image = new Image();
			var unitList : ArrayList = owned ? PlayerTurnModel.positionMap[hex] : AllyTurnModel.positionMap[hex];
			var unitString : String;
			for( var i : int = 0; i < unitList.length; ++i ) {
				unitString = unitList.source[i];
				if( unitString.indexOf( "FACT" ) != -1 ) {
					img = new Image();
					img.source = owned ? Resources.IMG_OWNED_FACTORY : Resources.IMG_ALLIED_FACTORY;
					img.x = x + FACTORY_WIDTH_OFFSET;
					img.y = y + FACTORY_HEIGHT_OFFSET;
					img.addEventListener(
						MouseEvent.CLICK,
						function( evt : MouseEvent ) : void {
							iconClickHandler.handleFactoryClick( evt, hex )
						}
					);
					group.addElement( img );
					break;
				}
			}
		}
		
		private function getHexPos( hex : int ) : Point {
			var hundreds : int = hex / 100;
			var ones : int = hex - (hundreds*100);
			
			var x : int;
			var y : int;
			if( hundreds % 2 == 1 ) {
				x = HEX_LITTLE + (hundreds-1) * (HEX_WIDTH + HEX_SIDE) / 2;
				y = HEX_BIG + (ones-1) * HEX_HEIGHT;
			} else {
				x = HEX_WIDTH + (hundreds-2) * (HEX_WIDTH + HEX_SIDE) / 2;
				y = (ones-1) * HEX_HEIGHT
			}
			
			return new Point( x, y );
		}
	}
}