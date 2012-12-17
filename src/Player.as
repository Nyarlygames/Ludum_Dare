package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxRect;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxGroup;
	import org.flixel.FlxTimer;
	import org.flixel.FlxSound;
	
	/**
	 * Player
	 * @author ...
	 */
	public class Player extends Character 
	{
		[Embed(source = '../assets/ANIMATIONS/PLAYER/player.png')] public var ImgPlayer:Class;
		[Embed(source="../assets/SOUNDS/POWERUPS/GET_LIFE.mp3")] public  var Get_Life:Class;
		[Embed(source="../assets/SOUNDS/POWERUPS/GOT_SHIELD.mp3")] public  var Got_shield:Class;

		public var maxspeed:int = 20;
		public var normalspeed:int = 15;
		public var lives:int = 3;                                                              
		private var imgs:ImgRegistry = new ImgRegistry();
		private var w:int = 0;
		private var h:int = 0;
		public var buildings:FlxGroup = new FlxGroup();
		public var pw_life:FlxSound = new FlxSound();
		public var pw_shield:FlxSound = new FlxSound();
		public var pw_speed_timer:FlxTimer = new FlxTimer();
		public var pw_speed_time:int = 2;
		public var shield:int = 0;
		public var nbanim:int = 0;
		
		public function Player(x:int, y:int, width:int, height:int) 
		{
			super(x, y, ImgPlayer);
			w = width;
			h = height;
			speed = 15;
			loadGraphic(ImgPlayer, true, false, 64, 64);
			nbanim++;
			addAnimation("walkd", [nbanim  + 0, nbanim  + 1, nbanim  + 2, nbanim  + 3, nbanim  + 4], 5, false);
			nbanim += 5;
			addAnimation("walkg", [nbanim  + 0, nbanim  + 1, nbanim  + 2, nbanim  + 3, nbanim  + 4], 5, false);
			nbanim += 5;
			addAnimation("walkhg", [nbanim  + 0, nbanim  + 1, nbanim  + 2, nbanim  + 3, nbanim  + 4], 5, false);
			nbanim += 5;
			addAnimation("walkhd", [nbanim  + 0, nbanim  + 1, nbanim  + 2, nbanim  + 3, nbanim  + 4], 5, false);
			pw_life.loadEmbedded(Get_Life, false, true);
			pw_shield.loadEmbedded(Got_shield, false, true);
		}
		
		override public function update():void {
			super.update();
			// DROITE
			if ((FlxG.keys.pressed("RIGHT") || FlxG.keys.pressed("D")) && x < w - frameWidth) {
				x += speed;
				play("walkd");
			}
			// GAUCHE
			if ((FlxG.keys.pressed("LEFT") || FlxG.keys.pressed("A")) && x > 0) {
				x -= speed;
				play("walkg");
			}
			// HAUT
			if ((FlxG.keys.pressed("UP") || FlxG.keys.pressed("W")) && y > 0) {
				y -= speed;	
				play("walkh");
			}
			// BAS
			if ((FlxG.keys.pressed("DOWN") || FlxG.keys.pressed("Z")) && y < h - frameHeight) {
				y += speed;
				play("walkb");
			}
			if (FlxG.keys.justReleasedAny() != -1) {
				frame = 0;
			}
			
			if ((pw_speed_timer != null) && (pw_speed_timer.finished)) {
				speed = normalspeed;
				pw_speed_timer = null;
			}
		}
		
		public function getBuild():void {
			for each (var z:Buildings in buildings.members) {	
				if ((z != null) && (FlxG.overlap(this, z.hitbox))) {
					if (z.take != this) {
						z.timer = new FlxTimer();
						z.timer.start(z.time);
						z.take = this;
					}
				}
				else if (z.timer != null) {
					z.timer.stop();
					z.take = null;
				}
			}
		}
		
		public function getLoot(obj1:Player, obj2:SpawnObjet):void {
			switch(obj2.label){
				case "Jeu":
					if (obj2.spawntype == 1) {
						if (shield < 1) {
							shield++;
							pw_shield.play();
						}
					}
					else {
						speed = maxspeed;
						pw_speed_timer = new FlxTimer();
						pw_speed_timer.start(pw_speed_time);
					}
				break;
				case "Hopital":
					if (lives < 3)
						lives++;
					pw_life.play();
				break;
				default:
			}
			obj2.destroy();
			obj2.exists = false;
		}
		
		public function bump(en:ESRB):void {
		/*	var movex:int = 0;
			var movey:int = 0;
			var bump:int = Constants.TILESIZE*2;
			
			if (en.x + en.frameWidth < x)
				movex = x + bump;
			else if (en.x > x + frameWidth)
				movex = x - bump;
				else
					movex = 0;
				
			if (en.y + en.frameHeight < y)
				movey = y + bump;
			else if (en.y > y + frameHeight)
				movey = y - bump;
				else
					movey = 0;
			FlxVelocity.moveTowardsPoint(this, new FlxPoint(movex, movey));*/
		}	
	}
} 