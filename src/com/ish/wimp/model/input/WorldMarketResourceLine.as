package com.ish.wimp.model.input {
	public class WorldMarketResourceLine {
		private var resource : String;
		private var prevVol : int;
		private var prevSell : int;
		private var prevBuy : int;
		private var transSold : int;
		private var transBought : int;
		private var curVol : int;
		private var curSell : int;
		private var curBuy : int;
		
		public function WorldMarketResourceLine( resource : String, prevVol : int, prevSell : int, prevBuy : int,
				transSold : int, transBought : int, curVol : int, curSell : int, curBuy : int ) {
			this.resource = resource;
			this.prevVol = prevVol;
			this.prevSell = prevSell;
			this.prevBuy = prevBuy;
			this.transSold = transSold;
			this.transBought = transBought;
			this.curVol = curVol;
			this.curSell = curSell;
			this.curBuy = curBuy;
		}
		
		public function getResource() : String { return resource; }
		public function getPrevVol() : int { return prevVol; }
		public function getPrevSell() : int { return prevSell; }
		public function getPrevBuy() : int { return prevBuy; }
		public function getTransSold() : int { return transSold; }
		public function getTransBought() : int { return transBought; }
		public function getCurVol() : int { return curVol; }
		public function getCurSell() : int { return curSell; }
		public function getCurBuy() : int { return curBuy; }
	}
}