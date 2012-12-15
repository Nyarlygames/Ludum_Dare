package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxRect;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.plugin.photonstorm.FlxCollision;
	
	/**
	 * Player
	 * @author ...
	 */
	public class Player extends FlxSprite 
	{
		[Embed(source = '../assets/gfx/ph_pj.png')] public var ImgPlayer:Class;
		public var speed:int = 15;
		public var lives:int = 3;
		private var imgs:ImgRegistry = new ImgRegistry;
		private var w:int = 0;
		private var h:int = 0;
		
		public function Player(x:int, y:int, width:int, height:int) 
		{
			super(x, y, ImgPlayer);
			w = width;
			h = height;
		}
		
		override public function update():void {
			super.update();
			FlxG.camera.follow(this);
			// DROITE
			if (FlxG.keys.pressed("RIGHT") && (x < w - frameWidth)) {
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
			if (FlxG.keys.pressed("DOWN") && (y < h - frameHeight)) {
				y += speed;
			}
		}
		
		public function getLoot(obj1:Player, obj2:SpawnObjet):void {
			switch(obj2.label){
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
		
		public function hit_wall(obj1:Player, obj2:Buildings):void {
			switch(obj2.label){
				case "Hopital":
					trace("test");
				break;
				case "Jeu":
					trace("test");
				break;
				default:
			}
		}
		public function hit_shop(obj1:Player, obj2:Buildings):void {
				trace(obj2.hitbox.scrollFactor.y, obj2.hitbox.scrollFactor.x, obj2.offset.x, obj2.offset.y, obj1, obj2,FlxG.camera.scroll.x);
			//if ((obj2.hitbox != null) && (FlxCollision.pixelPerfectCheck(obj1, obj2.hitbox))) {
			//	FlxG.collide(obj1, obj2.hitbox);
			//}
		}
		
		public function getKid(obj1:Player, obj2:Kid):void {
		/*	if (k.validated == false) {
						childcount++;
						k.validated = true;
						if (childcount == 3)
							score += 1000;
					}
			obj2.destroy();
			obj2.exists = false;*/
		}	
	}
} 