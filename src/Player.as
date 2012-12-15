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
		public var speed:int = 2;
		public var lives:int = 3;
		
		public function Player(x:int, y:int) 
		{
			super(x, y, ImgPlayer);
		}
		
		override public function update():void {
			super.update();
			FlxG.camera.follow(this);
			if (FlxG.keys.pressed("RIGHT")) {
				x += speed;
			}
			if (FlxG.keys.pressed("LEFT")) {
				x -= speed;
			}
			if (FlxG.keys.pressed("UP")) {
				y -= speed;
			}
			if (FlxG.keys.pressed("DOWN")) {
				y += speed;
			}
		}
		
		public function getLoot(obj1:Player, obj2:SpawnObjet):void {
			switch(obj2.label){
				case "Build":
					lives++;
				break;
				case "Hopital":
					if (lives < 3)
						lives++;
				break;
				case "Autre":
					speed *= 2;
				break;
				default:
			}
			obj2.destroy();
			obj2.exists = false;
		}
	}
} 