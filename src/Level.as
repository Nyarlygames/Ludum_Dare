package
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTimer;
	
	/**
	 * Level
	 * @author 
	 */
	public class Level extends FlxState
	{	
			
		[Embed(source = "../maps/map01.txt", mimeType = "application/octet-stream")] public var map1:Class;
		public var player:Player;
		private var kids:FlxGroup = new FlxGroup();
		private var esrbs:FlxGroup = new FlxGroup();
		private var builds:FlxGroup = new FlxGroup();
		public var map:Map = new Map(map1);
		private var background:FlxSprite = new FlxSprite();
		private var imgs:ImgRegistry = new ImgRegistry;
		private var ui:UI;
		public var score:int = 0;
		public var name:String = "";
		public var rating:String = "";
		public var playtime:FlxTimer = new FlxTimer();
		public var shopcount:int = 0;
		public var childcount:int = 0;
		public var started:Boolean = false;
		
		private var lastPosition:Array = new Array;
		private var distances:Array = new Array();
		
		public function Level(nom:String, rat:String):void
		{
			rating = rat;
			name = nom;
			background = new FlxSprite(0, 0, imgs.assets[int (map.bg)]);
			//add(background);
			// JOUEUR
			player = new Player(FlxG.width / 2, FlxG.height / 2, background.frameWidth, background.frameHeight);
			esrbs = map.esrbs;
			kids = map.kids;
			builds = map.builds;
			for each (var z:Buildings in builds.members) {
				if (z.hitbox != null) {
					add(z.hitbox);
				}
			} 
			add(builds);
			add(esrbs);
			add(kids);
			add(player);
			ui = new UI(this);
			add(ui);
			add(ui.components);
			//ui.sticktoplayer(player);
			FlxG.worldBounds =  new FlxRect(0, 0, background.frameWidth, background.frameHeight);
			FlxG.camera.setBounds(0, 0, background.frameWidth, background.frameHeight);
			
			lastPosition = player.getSquare();
			distances = distanceCalculator(player);
		}
		
		
		/*
		 * Finds a value in a "two-dimensional" array
		 */
		private function findIndexInArray(value:Object,array:Array):Array {
			var occurences:Array = new Array();
			
			for (var i:uint = 0 ; i < Constants.NBTILESWIDTH ; i++) {
				for (var j:uint = 0 ; j < Constants.NBTILESHEIGHT ; j++) {
					if (array[j][i] == value) {
						occurences.push(j,i);
					}
				}
			}
			return occurences;
		}
		
		/*
		 * Determines the distance between the player and every other square
		 * Returns a two-dimensionnal array corresponding with the map
		 */
		private function distanceCalculator(aiming:Character):Array {
			var mazeArray:Array = map.collisionsMap;
			
			//Create an array with the dimensions of the map array
			var distanceArray:Array = new Array();
			
			//Fill array of distances with 0 on empty tiles and 999 on blocked tiles so that they won't be chosen as path
			for (var j:uint = 0 ; j < Constants.NBTILESHEIGHT ; j++) {
				distanceArray[j] = [];
				for (var i:uint = 0 ; i < Constants.NBTILESWIDTH ; i++) {
					if(mazeArray[j][i] == 1) {
						distanceArray[j][i] = 999;
					} else {
						distanceArray[j][i] = 0;
					}
				}
			}
			
			var count:uint = 0;		
			distanceArray[aiming.getSquare()[0]][aiming.getSquare()[1]] = ++count;//Find hero
			
			while(findIndexInArray(0, distanceArray).length != 0) {
				var centerIndex:Array = findIndexInArray(count++, distanceArray);
				for (i = 0 ; i < centerIndex.length ; i += 2) {
					if(centerIndex[i] != null && centerIndex[i+1] != null) {
						//Fill the neighbors with the incrementing count gives the distance
						if(distanceArray[centerIndex[i] - 1] != null) {
							if (distanceArray[centerIndex[i] - 1][centerIndex[i+1] - 1] != null && distanceArray[centerIndex[i] - 1][centerIndex[i+1] - 1] == 0) {
								distanceArray[centerIndex[i] - 1][centerIndex[i+1] - 1] = count;
							}
							if (distanceArray[centerIndex[i] - 1][centerIndex[i+1]] != null && distanceArray[centerIndex[i] - 1][centerIndex[i+1]] == 0) {
								distanceArray[centerIndex[i] - 1][centerIndex[i+1]] = count;
							}
							if (distanceArray[centerIndex[i] - 1][centerIndex[i+1] + 1] != null && distanceArray[centerIndex[i] - 1][centerIndex[i+1] + 1] == 0) {
								distanceArray[centerIndex[i] - 1][centerIndex[i+1] + 1] = count;
							}
						}
						if(distanceArray[centerIndex[i]] != null) {
							if (distanceArray[centerIndex[i]][centerIndex[i+1] - 1] != null && distanceArray[centerIndex[i]][centerIndex[i+1] - 1] == 0) {
								distanceArray[centerIndex[i]][centerIndex[i+1] - 1] = count;
							}
							if (distanceArray[centerIndex[i]][centerIndex[i+1] + 1] != null && distanceArray[centerIndex[i]][centerIndex[i+1] + 1] == 0) {
								distanceArray[centerIndex[i]][centerIndex[i+1] + 1] = count;
							}
						}
						if(distanceArray[centerIndex[i] + 1] != null) {
							if (distanceArray[centerIndex[i] + 1][centerIndex[i+1] - 1] != null && distanceArray[centerIndex[i] + 1][centerIndex[i+1] - 1] == 0) {
								distanceArray[centerIndex[i] + 1][centerIndex[i+1] - 1] = count;
							}
							if (distanceArray[centerIndex[i] + 1][centerIndex[i+1]] != null && distanceArray[centerIndex[i] + 1][centerIndex[i+1]] == 0) {
								distanceArray[centerIndex[i] + 1][centerIndex[i+1]] = count;
							}
							if (distanceArray[centerIndex[i] + 1][centerIndex[i+1] + 1] != null && distanceArray[centerIndex[i] + 1][centerIndex[i+1] + 1] == 0) {
								distanceArray[centerIndex[i] + 1][centerIndex[i+1] + 1] = count;
							}
						}
					}
				}
			}
			
			return distanceArray;
		}
		
		////UPDATE
		override public function update():void {
			super.update();
			
			if (lastPosition[0] != player.getSquare()[0] && lastPosition[1] != player.getSquare()[1]) {
				distances = distanceCalculator(player);
				lastPosition = player.getSquare();
			}
			kids.members[0].findPath(distances);
			
			if (started == false) {
				playtime.start(map.time);
				started = true;
			}
			FlxG.collide(player, builds);
			for each (var b:Buildings in builds.members) {
				if ((b != null) && (b.lootable == true)){
					if (b.taken == false) {
						b.playerGet(player);
					}
					else if (b.validated == false) {
						shopcount++;
						b.validated = true;
						if (shopcount == map.shops)
							score += 1000;
					}
					// loots
					if (b.loot != null)
						FlxG.overlap(player, b.loot, player.getLoot);
					// Collision building => esrb
					for each (var e:ESRB in esrbs.members) {
						if (e != null){
							b.playerGet(e);
						}
					}
				}
				if ((b.label == "Ecole") && (!b.bspawnkid)) {
					b.spawntimer.start(b.spawnkid);
					kids.add(new Kid(b.x, b.y));
					b.bspawnkid = true;
				}
				if (b.spawntimer.finished) {
					b.bspawnkid = false;
				}
			}
			if ((playtime != null) && (playtime.finished)) {
				score += 800;
				playtime = null;
			}
			/*
			// Collisions kids
			for each (var k:Kid in kids.members) {
				if (k != null) {
					FlxG.overlap(player, k, player.getKid);
				}
			}
			*/
		}
		
	}
}
