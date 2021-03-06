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
	import org.flixel.plugin.photonstorm.BaseTypes.Bullet;
	import org.flixel.plugin.photonstorm.FlxCollision;
	/**
	 * Level
	 * @author 
	 */
	public class Level extends FlxState
	{	
			
		[Embed(source="../assets/MUSIC/music_rating_7.mp3")] public  var Sound7:Class;
		[Embed(source = "../assets/MUSIC/music_rating_12.mp3")] public  var Sound12:Class;
		[Embed(source = "../assets/MUSIC/music_rating_18.mp3")] public  var Sound18:Class;
		[Embed(source="../assets/SOUNDS/RATING/SFX_RATING_12.mp3")] public  var Sound7_12:Class;
		[Embed(source="../assets/SOUNDS/RATING/SFX_RATING_18.mp3")] public  var Sound12_18:Class;
		[Embed(source="../assets/SOUNDS/ENFANT/CHILD_SPAWN.mp3")] public  var Kid_Spawn:Class;
		[Embed(source="../assets/SOUNDS/ENNEMIS/SERB_SPAWN.mp3")] public  var Serb_Spawn:Class;
		[Embed(source="../assets/SOUNDS/ENNEMIS/PIG_SPAWN.mp3")] public  var Pig_Spawn:Class;
		[Embed(source="../assets/SOUNDS/PLAYER/LOST_LIFE.mp3")] public  var Lost_Life:Class;
		[Embed(source = "../maps/map01.txt", mimeType = "application/octet-stream")] public var map1:Class;
		public var player:Player;
		public var kids:FlxGroup = new FlxGroup();
		public var esrbs:FlxGroup = new FlxGroup();
		public var builds:FlxGroup = new FlxGroup();
		public var map:Map = new Map(map1);
		private var background:FlxSprite = new FlxSprite();
		private var imgs:ImgRegistry = new ImgRegistry;
		public var ui:UI;
		public var name:String = "";
		public var rating:Array = new Array();
		public var ratid:int = 0;
		public var playtime:FlxTimer = new FlxTimer();
		public var totaltime:FlxTimer = new FlxTimer();
		public var immunity:FlxTimer = null;
		public var immunetime:int = 1;
		public var shopcount:int = 0;
		public var childcount:int = 0;
		public var started:Boolean = false;
		public var count2:int = 0;
		private var mazeArray:Array;
		public var sfx_trans:FlxSound = new FlxSound();
		public var sfx_spawn:FlxSound = new FlxSound();
		public var sfx_spawnesrb:FlxSound = new FlxSound();
		public var sfx_lost_life:FlxSound = new FlxSound();
		public var sfx_spawnpig:FlxSound = new FlxSound();
		private var distances:Array;
		public var other:Boolean = true;
		public var childtransforme:FlxTimer = new FlxTimer;
		
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
			rating.push(new Array("7+", 10, "Kick", 20, 30, 60, 90, 180));
			rating.push(new Array("12+", 20, "Gun", 40, 20, 40, 60, 120));
			rating.push(new Array("18+", -1, "MG", 60, 10, 10, 30, 60));
			FlxG.width = 1024;
			FlxG.height = 768;
			FlxG.playMusic(Sound7, 1);
			FlxG.music.getActualVolume();
			sfx_trans.loadEmbedded(Sound7_12, false, true);
			sfx_lost_life.loadEmbedded(Lost_Life, false, true);
			name = nom;
			background = new FlxSprite(0, 0, imgs.assets[int (map.bg)]);
			add(background);
			// JOUEUR
			esrbs = map.esrbs;
			kids = map.kids;
			for each (var k:Kid in kids.members) {
				if (k != null) {
					k.rating = rating;
					k.ratid = ratid;
				}
			}
			builds = map.builds;
			add(esrbs);
			add(kids);
			ui = new UI(this);
			player = new Player(FlxG.width / 2, FlxG.height / 2, background.frameWidth, background.frameHeight, this);			for each (var z:Buildings in builds.members) {
			if ((z != null) && (z.lootable == true)) {
					z.rating = rating;
					z.ratid = ratid;
					player.buildings.add(z);
					add(z.hitbox);
				}
			}
			add(builds);
			add(player);
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
				super.update();
				FlxG.width = background.frameWidth;
				FlxG.height = background.frameHeight;
				FlxG.camera.setBounds(0, 0, background.frameWidth, background.frameHeight);
				FlxG.worldBounds = new FlxRect(0, 0, background.frameWidth, background.frameHeight);
				FlxG.camera.follow(player);
				if ((childcount > rating[ratid][1]) && (ratid < 2)) {
					if (ratid == 0) {
						sfx_trans.play();
						FlxG.playMusic(Sound12, 1);
						ui.rating_sprite.loadGraphic(ui.Img12);
					}
					if (ratid == 1) {
						sfx_trans.loadEmbedded(Sound12_18, false, true);
						sfx_trans.play();
						FlxG.playMusic(Sound18, 1);
						ui.rating_sprite.loadGraphic(ui.Img18);
					}
					ratid++;
				}
				count2++;
				if ((count2 == 60) ) {
					distances = distanceCalculator(player);
					FlxG.score++;
					count2 = 0;
				}
				for each (var en:ESRB in esrbs.members) {
					if (en != null) {
						en.findPath(distances, player);
					}
				}
				
				FlxG.collide(kids, kids);
				FlxG.collide(kids, builds);
				FlxG.overlap(player, esrbs, get_hurt);
				FlxG.collide(player, builds);
				FlxG.collide(esrbs, builds);
			//	FlxG.collide(esrbs, kids);
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
						var kid:Kid = new Kid(b.x + b.frameWidth / 2, b.y + b.frameHeight);
						kids.add(kid);
						add(kid.tirs.group);
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
					if ((immunity != null) && (immunity.finished)) {
						immunity = null;
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
						if ((child.transformed == true) && (child.transforming == false)) {
							child.transforming = true;
							child.go_away.start(1);
						}
						if (child.transformed == true) {
							child.goAway();
						}
						if (child.go_away.finished) {
							kids.remove(child, true);
						}
						else 
							child.behave(builds);
					}	
					FlxG.overlap(child.tirs.group, esrbs, hit_esrbs);
					if ((child.validated == true) && (ratid == 1)) {
						child.tirs.fireFromAngle(Math.random() * 360);
					}
					else if ((child.validated == true) && (ratid == 2)) {
						child.tirs.setFireRate(1000);
						child.tirs.fireFromAngle(Math.random() * 360);
					}
						
					if ((child.validated == true ) && (childtransforme.finished) && (child.transformed == false)) {
						child.loadGraphic(child.getImg(ratid), true, false, 64, 64);
					}
					
				}
			}
			
		}

		// KID TOUCHE ESRB
		public function hit_esrbs(k:Bullet, en:ESRB):void {
			if (FlxCollision.pixelPerfectCheck(en, k)) {
				en.hurt(en.attack);   
			}
			k.exists = false;
		}
		// TRANSFORME EN BISOUNOURS
		public function trans_bisou(esrb:ESRB, k:Kid):void {
			if ((FlxCollision.pixelPerfectCheck(esrb, k)) && (k.validated == true) && (k.transformed ==false)) {
				k.TRANSFORMED_MODE.play();
				k.loadGraphic(k.ImgBisounours, true, false, 31, 64);
				k.transformed = true;
			}
		}
		
		// GET HURT BY ESRB
		public function get_hurt(pl:Player, es:ESRB):void {
			if ((player.lives > -1) && (immunity == null)) {
				// SI BOUCLIER
				if (player.lives ==0) {
					FlxG.music.stop();
					FlxG.switchState(new GameOver());
				}
				if (player.shield == 1) {
					player.shield = 0;
					ui.lives.members[3] = null;
					sfx_lost_life.play();
				}
				// SI VIES
				else {
					ui.lives.members[player.lives].loadGraphic(ui.ImgLifeEmpty, true, false, 32, 32);
					ui.lives.members[player.lives].scrollFactor.x = ui.lives.members[player.lives].scrollFactor.y = 0;
					player.lives--;
					sfx_lost_life.play();
					}
				}
				//SI STILL ALIVE
				immunity = new FlxTimer();
				immunity.start(immunetime);
			}
		
		public function captureKid(player:Player, kids:FlxGroup):void {
			for each (var child:Kid in kids.members) {
				if ((child != null) && (child.validated == false) && (FlxVelocity.distanceBetween(player, child) < 2 * Constants.TILESIZE)) {		
					switch(ratid) {
						case 0:
							child.loadGraphic(imgs.assets[16], true, false, 64, 64);
							break;
						case 1:
							child.loadGraphic(imgs.assets[17], true, false, 64, 64);
							break;
						case 2:
							child.loadGraphic(imgs.assets[18], true, false, 64, 64);
							break;
					}
					child.addAnimation("animtrans", [0, 1, 2, 3, 4, 5, 6, 7], 8, false);
					child.play("animtrans");
					childtransforme.start(1);
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
