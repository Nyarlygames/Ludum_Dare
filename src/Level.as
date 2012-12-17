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
			
		[Embed(source="../assets/MUSIC/7.mp3")] public  var Sound7:Class;
		[Embed(source="../assets/MUSIC/7.mp3")] public  var Sound12:Class;
		[Embed(source="../assets/MUSIC/7.mp3")] public  var Sound18:Class;
		[Embed(source="../assets/SOUNDS/RATING/SFX_RATING_12.mp3")] public  var Sound7_12:Class;
		[Embed(source="../assets/SOUNDS/RATING/SFX_RATING_18.mp3")] public  var Sound12_18:Class;
		[Embed(source="../assets/SOUNDS/ENFANT/CHILD_SPAWN.mp3")] public  var Kid_Spawn:Class;
		[Embed(source="../assets/SOUNDS/ENNEMIS/SERB_SPAWN.mp3")] public  var Serb_Spawn:Class;
		[Embed(source="../assets/SOUNDS/ENNEMIS/PIG_SPAWN.mp3")] public  var Pig_Spawn:Class;
		[Embed(source = '../assets/IMAGES/GAME_OVER/game_over.png')] public var ImgGameOver:Class;
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
		public var rating:Array = new Array();
		public var ratid:int = 0;
		public var playtime:FlxTimer = new FlxTimer();
		public var totaltime:FlxTimer = new FlxTimer();
		public var immunity:FlxTimer;
		public var immunetime:int = 1;
		public var shopcount:int = 0;
		public var childcount:int = 0;
		public var started:Boolean = false;
		public var count2:int = 0;
		private var mazeArray:Array;
		public var sfx_trans:FlxSound = new FlxSound();
		public var sfx_spawn:FlxSound = new FlxSound();
		public var sfx_spawnesrb:FlxSound = new FlxSound();
		public var sfx_spawnpig:FlxSound = new FlxSound();
		private var distances:Array;
		public var other:Boolean = true;
		
		public function Level(nom:String, rat:int):void
		{
			/*FORMAT RATING
			 * 
			 * 	  1		 		2
			 * 0 => 7		| 15 kid
			 * 1=> 12		| 30
			 * 2 => 18		| 40
			 * _________________
			 * --- KID ---
			 * Attack Fou/Agressif/meurtrier
			 * KID PV 20/40/60
			 * --- ECOLE ---
			 * SPAWNTIME 30/20/10
			 * SPAWNTIME EXTENDS SI LENGTH > LIM 60/40/10
			 * --- SERB ---
			 * SPAWNTIME 90/60/30
			 * SPAWNTIME EXTENDS 180/120/60
			 * --- SPAWN WHO? ----
			 * 7-12, 0 obj => PEGI XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
			 * 12+, 1 obj => PEGI SERB XXXXXXXXXXXXXXXXXXXXXXXXXX NON RENSEIGNE
			 * 12+, 2 obj => SERB XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
			 */
			ratid = rat;
			rating = new Array();
			rating.push(new Array("7+", 2, "Kick", 20, 30, 60, 90, 180));
			rating.push(new Array("12+", 4, "Gun", 40, 20, 40, 60, 120));
			rating.push(new Array("18+", -1, "MG", 60, 10, 10, 30, 60));
			
			FlxG.playMusic(Sound7, 1);
			sfx_trans.loadEmbedded(Sound7_12, false, true);
			name = nom;
			background = new FlxSprite(0, 0, imgs.assets[int (map.bg)]);
			add(background);
			// JOUEUR
			player = new Player(FlxG.width / 2, FlxG.height / 2, background.frameWidth, background.frameHeight);
			esrbs = map.esrbs;
			kids = map.kids;
			for each (var k:Kid in kids.members) {
				if (k != null) {
					k.rating = rating;
					k.ratid = ratid;
				}
			}
			builds = map.builds;
			for each (var z:Buildings in builds.members) {
				if ((z != null) && (z.lootable == true)) {
					z.rating = rating;
					z.ratid = ratid;
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

				if ((childcount > rating[ratid][1]) && (ratid < 2)) {
					if (ratid == 0) {
						sfx_trans.play();
						FlxG.playMusic(Sound12, 1);
						ui.loadGraphic(ui.Img12);
					}
					if (ratid == 1) {
						sfx_trans.loadEmbedded(Sound12_18, false, true);
						sfx_trans.play();
						FlxG.playMusic(Sound18, 1);
						ui.loadGraphic(ui.Img18);
					}
					ratid++;
				}
				count2++;
				if ((count2 == 60) ) {
					distances = distanceCalculator(player);
					count2 = 0;
				}
				for each (var en:ESRB in esrbs.members) {
					if (en != null) {
						en.findPath(distances, player);
					}//  HERE COLLISIONS ESRB / PLAYER
					if (FlxCollision.pixelPerfectCheck(en, player) && (immunity != null) && (immunity.finished)) {
						player.lives--;
						if (player.lives > 0)
							immunity = null;
						else
							add(new FlxSprite(0, 0, ImgGameOver));
					}
					else if (FlxCollision.pixelPerfectCheck(en, player) && (immunity == null)) {
						immunity = new FlxTimer();
						immunity.start(immunetime);
						//player.bump(en);
					}
				}
				FlxG.collide(kids, kids);
				FlxG.collide(kids, builds);
				FlxG.overlap(player, esrbs);
				FlxG.collide(player, builds);
				FlxG.collide(esrbs, builds);
				FlxG.collide(esrbs, kids);
				FlxG.collide(esrbs, esrbs);
				FlxG.collide(kids, kids);
				FlxG.overlap(esrbs, kids, trans_bisou);
				
				if (started == false) {
					playtime.start(map.time);
					started = true;
				}
				for each (var b:Buildings in builds.members) {
					if (b != null)
						b.updateRating(this);
					if ((b != null) && (b.lootable == true)){
						if (b.taken == false) {
							player.getBuild();
						}
						else if (b.validated == false) {
							shopcount++;
							map.shops--;
							b.validated = true;
							b.hitbox = null;
						}
						// loots
						if (b.loot != null)
							FlxG.overlap(player, b.loot, player.getLoot);
					}
					if ((b.label == "Ecole") && (!b.bspawnkid)) {
						b.spawntimer.start(b.spawnkid);
						kids.add(new Kid(b.x + b.frameWidth / 2, b.y + b.frameHeight));
						sfx_spawn.loadEmbedded(Kid_Spawn, false, true);
						sfx_spawn.play();
						b.bspawnkid = true;
					}
					if (b.spawntimer.finished) {
						b.bspawnkid = false;
					}
					if ((b.label == "Centre") && (!b.bspawnesrb) && (!b.spawntimeresrb.paused)) {
						b.bspawnesrb = true
						b.spawntimeresrb.start(b.spawnesrb);
						if (rating[ratid][0] == "18+") {
							esrbs.add(new ESRB(b.x + b.frameWidth / 2, b.y + b.frameHeight, null));
							sfx_spawnesrb.loadEmbedded(Serb_Spawn, false, true);
							sfx_spawnesrb.play();
						}
						else if (other) {
							esrbs.add(new ESRB(b.x + b.frameWidth / 2, b.y + b.frameHeight, null));
							other = !other;
							sfx_spawnesrb.loadEmbedded(Serb_Spawn, false, true);
							sfx_spawnesrb.play();
						}
						else {
							esrbs.add(new PIG(b.x + b.frameWidth / 2, b.y + b.frameHeight));
							other = !other;
							sfx_spawnpig.loadEmbedded(Pig_Spawn, false, true);
							sfx_spawnpig.play();
						}
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
						if (child.transformed == true)
							child.goAway();
						else 
							child.behave(builds);
					}
				} 
			}
		}

		// TRANSFORME EN BISOUNOURS
		public function trans_bisou(esrb:ESRB, k:Kid):void {
			if (FlxCollision.pixelPerfectCheck(esrb, k)) {
				//k = new Kid(k.x, k.y);
				k.loadGraphic(k.ImgBisounours, true, false, 64, 64);
				k.transformed == true;
			}
		}
		
		public function captureKid(player:Player, kids:FlxGroup):void {
			for each (var child:Kid in kids.members) {
				if ((child != null) && (child.validated == false) && (FlxVelocity.distanceBetween(player, child) < 2 * Constants.TILESIZE)) {
					child.loadGraphic(child.getImg(ratid), true, false, 64, 64);
					map.childs--;
					childcount++;
					child.INFECTED_MODE.play(true);
					FlxG.score += 10;
					child.validated = true; 
				}
			} 
		}
		
	}
}
