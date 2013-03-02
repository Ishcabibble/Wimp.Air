package com.ish.wimp.model {
	import mx.collections.ArrayList;

	public class Constants {
		public static const EXPENSE_HEADER_RESOURCE_WIDTH : int = 20;
		public static const EXPENSE_HEADER_EC_WIDTH : int = 40;
		public static const EXPENSE_LINE_X : int = 390;
		public static const EXPENSE_PANEL_WIDTH : int = 620;
		public static const PROD_LEFT_PAD : int = 10;
		public static const PROD_TOP_PAD : int = 10;
		public static const PROD_BOT_PAD : int = 10;
		public static const PROD_LINE_HEIGHT : int = 25;
		public static const PROD_LINE_INPUT_WIDTH : int = 50;
		public static const TECH_TYPE_LABEL_WIDTH : int = 30;
		public static const EC_INPUT_WIDTH : int = 40;
		public static const WORLD_MARKET_LABEL_WIDTH : int = 100;
		public static const ESPIONAGE_BOX_WIDTH : int = 225;
		public static const COUNTRY_BOX_WIDTH : int = 200;
		public static const RESOURCE_BOX_WIDTH : int = 50;
		public static const TECH_TYPE_BOX_WIDTH : int = 60;
		public static const ACTION_LINE_INPUT_WIDTH : int = 80;
		
		public static const NUKE_LIST : ArrayList = new ArrayList( ["None", "1K", "5K", "10K", "50K", "100K", "500K"] );
		public static const RESOURCE_LIST : ArrayList = new ArrayList( ["F", "M", "I", "O", "P", "U"] );
		public static const TECH_TYPE_LIST : ArrayList = new ArrayList( ["Inf", "Veh", "Aer", "Nav", "Nuc"] );
		public static const COUNTRY_LIST : ArrayList = new ArrayList( [
			"1  - Alaska",
			"2  - Ecotopia",
			"3  - Canada",
			"4  - Quebec",
			"5  - United States of America",
			"6  - Texas",
			"7  - Mexico",
			"8  - Peru",
			"9  - Venezuela",
			"10 - Brazil",
			"11 - Argentina",
			"12 - United Kingdom",
			"13 - Scandinavia",
			"14 - Poland",
			"15 - Germany",
			"16 - France",
			"17 - Turkey",
			"18 - Ukraine",
			"19 - Russia",
			"20 - Kazakh",
			"21 - Iran",
			"22 - Saudi Arabia",
			"23 - Egypt",
			"24 - Algeria",
			"25 - Nigeria",
			"26 - Sudan",
			"27 - Zaire",
			"28 - Tanzania",
			"29 - South Africa",
			"30 - India",
			"31 - Indochina",
			"32 - China",
			"33 - Manchuria",
			"34 - Evenki Soviet Republic",
			"35 - Yakutsk",
			"36 - Kamchatka",
			"37 - Japan",
			"38 - Indonesia",
			"39 - Western Australia",
			"40 - New South Wales"
		] );
		
		public static const ESPIONAGE_LIST : ArrayList = new ArrayList( [
			"DR - determine resources",
			"DS - determine security",
			"DT - determine tech",
			"IN - infiltrate",
			"PA - purge agents",
			"RG - raise guerrillas",
			"RH - recon hex",
			"RP - recruit partisans",
			"SA - sabotage aircraft",
			"SN - sabotage nuclear warheads",
			"SP - sabotage production",
			"SR - sabotage resource",
			"ST - sabotage tech recovery"
		] );
		
		public static const MISSION_LIST : ArrayList = new ArrayList( [
			"Drop",
			"HMove",
			"Move",
			"Recon",
			"SMove",
			"Bomb",
			"CAP",
			"CAPS",
			"Escort",
			"Recall",
			"Transfer",
			"Patrol",
			"Attack",
			"1x1K"
		] );
	}
}