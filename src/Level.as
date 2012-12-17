package
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTimer;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.plugin.photonstorm.FlxCollision;
	/**
	 * Level
	 * @author 
	 */
	public class Level extends FlxState
	{	
			
		[Embed(source="../assets/sfx/7.mp3")] public  var Sound7:Class;
		[Embed(source = "../maps/map01.txt", mimeType = "application/octet-stream")] public var map1:Class;
		public var player:Player;
		public var kids:FlxGroup = new FlxGroup();
		public var esrbs:FlxGroup = new FlxGroup();
		public var builds:FlxGroup = new FlxGroup();
		public var map:Map = new Map(map1);
		private var background:FlxSprite = new FlxSprite();
		private var imgs:ImgRegistry = new ImgRegistry;
		private var ui:UI;
		public var name:String = "";
		public var rating:String = "";
		public var playtime:FlxTimer = new FlxTimer();
		public var totaltime:FlxTimer = new FlxTimer();
		public var immunity:FlxTimer;
		public var immunetime:int = 1;
		public var shopcount:int = 0;
		public var childcount:int = 0;
		public var started:Boolean = false;
		public var count2:int = 0;
		private var mazeArray:Array;
		public var music:FlxSound = new FlxSound();
		private var distances:Array;
		
		public function Level(nom:String, rat:String):void
		{
			/*FORMAT RATING
			 * --- KID ---
			 * Attack Fou/Agressif/meurtrier
			 * KID PV 20/40/60
			 * --- ECOLE ---
			 * SPAWNTIME 30/20/10
			 * SPAWNTIME EXTENDS SI LENGTH > LIM
			 * --- SERB ---
			 * SPAWNTIME 90/60/30
			 * SPAWNTIME EXTENDS 180/120/60
			 * --- SPAWN WHO? ----
			 * 7-12, 0 obj => PEGI
			 * 12+, 1 obj => PEGI SERB
			 * 12+, 2 obj => SERB
			 */
			
			
			
			rating = rat;
			//FlxG.stream("../assets/sfx/mort_2.mp3", 1, true);
			//FlxG.loadSound(Sound7, 1, true, false, true);
			//FlxG.playMusic(Sound7,1);
			
			FlxG.playMusic(Sound7,1);
			
			name = nom;
			background = new FlxSprite(0, 0, imgs.assets[int (map.bg)]);
			add(background);
			// JOUEUR
			player = new Player(FlxG.width / 2, FlxG.height / 2, background.frameWidth, background.frameHeight);
			esrbs = map.esrbs;
			kids = map.kids;
			builds = map.builds;
			for each (var z:Buildings in builds.members) {
				if ((z != null) && (z.lootable == true)) {
					player.buildings.add(z);
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
			
			//Create an array with the dimensions of the map array
			mazeArray = new Array();
			
			//Fill array of distances with 0 on empty tiles and 999 on blocked tiles so that they won't be chosen as path
			for (var j:uint = 0 ; j < Constants.NBTILESHEIGHT ; j++) {
				mazeArray[j] = [];
				for (var i:uint = 0 ; i < Constants.NBTILESWIDTH ; i++) {
					if(map.collisionsMap[j][i] == 1) {
						mazeArray[j][i] = 999;
					} else {
						mazeArray[j][i] = 0;
					}
				}
			}
			
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
		 * Copy a two dimensional array into a new array
		 */
		private function copyArray(array:Array):Array {
			var copiedArray:Array = new Array();
			
			for (var i:uint = 0 ; i < array.length ; i++) {
				copiedArray[i] = [];
				for (var j:uint = 0 ; j < array[i].length ; j++) {
					copiedArray[i][j] = array[i][j];
				}
			}
			
			return copiedArray;
		}

		/*
		 * Determines the distance between the player and every other square
		 * Returns a two-dimensionnal array corresponding with the map
		 */
		private function distanceCalculator(aiming:Character):Array {
			var distanceArray:Array = copyArray(mazeArray);
			
			var count:uint = 0;
			distanceArray[aiming.getSquare()[0]][aiming.getSquare()[1]] = ++count;//Find hero
			
			while(findIndexInArray(0, distanceArray).length != 0) {
				var centerIndex:Array = findIndexInArray(count++, distanceArray);
				for (var i:int = 0 ; i < centerIndex.length ; i += 2) {
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
			if(!Game.paused) {
				FlxG.worldBounds = new FlxRect(0, 0, background.frameWidth, background.frameHeight);
				FlxG.camera.setBounds(0, 0, background.frameWidth, background.frameHeight);
				FlxG.camera.follow(player);
				super.update();
				count2++;
				if ((count2 == 30) ) {
					distances = distanceCalculator(player);
					count2 = 0;
				}
				for each (var en:ESRB in esrbs.members) {
					if (en != null) {
						en.findPath(distances, player);
					}
					if (FlxCollision.pixelPerfectCheck(en, player) && (immunity != null) && (immunity.finished)) {
						player.lives--;
						immunity = null;
					}
					else if (FlxCollision.pixelPerfectCheck(en, player) && (immunity == null)) {
						immunity = new FlxTimer();
						immunity.start(immunetime);
						//player.bump(en);
					}
				}
				FlxG.collide(kids, kids);
				FlxG.collide(kids, builds);
				FlxG.collide(player, esrbs);
				FlxG.collide(player, builds);
				FlxG.collide(esrbs, builds);
				FlxG.collide(esrbs, esrbs);
				
				
				if (started == false) {
					playtime.start(map.time);
					started = true;
				}
				for each (var b:Buildings in builds.members) {
					if ((b != null) && (b.lootable == true)){
						if (b.taken == false) {
							player.getBuild();
						}
						else if (b.validated == false) {
							shopcount++;
							map.shops--;
							b.validated = true;
						}
						// loots
						if (b.loot != null)
							FlxG.overlap(player, b.loot, player.getLoot);
					}
					if ((b.label == "Ecole") && (!b.bspawnkid)) {
						b.spawntimer.start(b.spawnkid);
						kids.add(new Kid(b.x + b.frameWidth/2, b.y + b.frameHeight));
						b.bspawnkid = true;
					}
					if (b.spawntimer.finished) {
						b.bspawnkid = false;
					}
					if ((b.label == "Centre") && (!b.bspawnesrb) && (!b.spawntimeresrb.paused)) {
						b.bspawnesrb = true
						b.spawntimeresrb.start(b.spawnesrb);
						esrbs.add(new ESRB(b.x + b.frameWidth/2, b.y + b.frameHeight, null));
					}
					if (b.spawntimeresrb.finished) {
						b.bspawnesrb = false;
					}
				}
				if ((playtime != null) && ((playtime.time - playtime.timeLeft) / 60 == 0) && (int (playtime.timeLeft) != int (map.time)))
					FlxG.score++;
				// CAPTURE ENFANTS
				if (FlxG.keys.justReleased("SPACE")) {
					captureKid(player, kids);
				}
				
				for each (var child:Kid in kids.members) {
					if (child != null) {
						child.behave(builds);
					}
				} 
			}
		}
		
		public function captureKid(player:Player, kids:FlxGroup):void {
			for each (var child:Kid in kids.members) {
				if ((child != null) && (child.validated == false) && (FlxVelocity.distanceBetween(player, child) < 2 * Constants.TILESIZE)) {
					child.loadGraphic(imgs.assets[child.infect]);
					map.childs--;
					child.INFECTED_MODE.play(true);
					FlxG.score += 10;
					child.validated = true; 
				}
			} 
		}
		
	}
}
