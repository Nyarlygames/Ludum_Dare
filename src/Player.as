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
	
	/**
	 * Player
	 * @author ...
	 */
	public class Player extends Character 
	{
		[Embed(source = '../assets/gfx/Test_Annim.png')] public var ImgPlayer:Class;
		public var speed:int = 5;
		public var maxspeed:int = 8;
		public var lives:int = 3;
		private var imgs:ImgRegistry = new ImgRegistry;
		private var w:int = 0;
		private var h:int = 0;
		public var buildings:FlxGroup = new FlxGroup();
		
		public function Player(x:int, y:int, width:int, height:int) 
		{
			super(x, y, ImgPlayer);
			w = width;
			h = height;
			loadGraphic(ImgPlayer, true, false, 64, 64);
			addAnimation("walk", [0, 1, 2, 3, 4], 5, false);
		}
		
		override public function update():void {
			super.update();
			FlxG.camera.follow(this);
			// DROITE
			if ((FlxG.keys.pressed("RIGHT") || (FlxG.keys.pressed("D"))) && (x < w - frameWidth)) {
				x += speed;
				play("walk");
			}
			// GAUCHE
			if ((FlxG.keys.pressed("LEFT") || (FlxG.keys.pressed("A"))) && (x > 0)) {
				x -= speed;
				play("walk");
			}
			// HAUT
			if ((FlxG.keys.pressed("UP") || (FlxG.keys.pressed("W"))) && (y > 0)) {
				y -= speed;	
				play("walk");
			}
			// BAS
			if ((FlxG.keys.pressed("DOWN") || (FlxG.keys.pressed("Z"))) && (y < h - frameHeight)) {
				y += speed;
				play("walk");
			}
			if (FlxG.keys.justReleasedAny() != -1) {
				frame = 0;
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
				case "Hopital":
					if (lives < 3)
						lives++;
				break;
				case "Jeu":
					speed = maxspeed;
				break;
				default:
			}
			obj2.destroy();
			obj2.exists = false;
		}	
	}
} 