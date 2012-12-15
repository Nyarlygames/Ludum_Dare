package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	
	/**
	 * Player
	 * @author ...
	 */
	public class Player extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/player.png')] public var ImgPlayer:Class;
		public var speed:int = 15;
		public var lives:int = 3;
		private var imgs:ImgRegistry = new ImgRegistry;
		
		public function Player(x:int, y:int) 
		{
			super(x, y, ImgPlayer);
		}
		
		override public function update():void {
			super.update();
			FlxG.camera.follow(this);
			
			// DROITE
			if (FlxG.keys.pressed("RIGHT") && (x < imgs.assets[0].frameWidth)) {
				x += speed;
			}
			// GAUCHE
			if (FlxG.keys.pressed("LEFT") && (x > 0)) {
				x -= speed;
			}
			// HAUT
			if (FlxG.keys.pressed("UP") && (y > 0)) {
				y -= speed;
			}
			// BAS
			if (FlxG.keys.pressed("DOWN") && (y < imgs.assets[0].frameHeight)) {
				y += speed;
			}
		}
		
		public function getLoot(obj1:Player, obj2:SpawnObjet):void {
			switch(obj2.label){
				case "Info":
					lives++;
				break;
				case "Hopital":
					if (lives < 3)
						lives++;
				break;
				case "Jeu":
					speed *= 2;
				break;
				default:
			}
			obj2.destroy();
			obj2.exists = false;
		}
	}
} 