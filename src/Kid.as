package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTimer;
	import org.flixel.FlxG;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxSound;
	/**
	 * KID
	 * @author ...
	 */
	public class Kid extends Character
	{
		
		[Embed(source = '../assets/gfx/kid.png')] public var ImgKid:Class;
		public var validated:Boolean = false;
		public var moving:FlxTimer = new FlxTimer();
		public var rand:int = -1;
		public var blocked:Boolean = false;
		public var bisounours:int = 14;
		public var infect:int = 14;
		public var rating:Array = null
		public var ratid:int = 0;
		public var INFECTED_MODE:FlxSound = new FlxSound();
		
		public function Kid(x:int, y:int) 
		{
			super(x, y, ImgKid);
			moving.start(1);
			health = 10;
			speed = 1;
			INFECTED_MODE.loadStream("../assets/sfx/ENFANT/INFECTED_MODE.mp3", false, false);
		}
		
		override public function update():void {
			if (rating != null) {
				switch (rating[ratid][2]) {
					case "Kick":
						break;
					case "Gun":
						break;
					case "MG":
						break;
					default:
						break;
				}
			}
		}
		
		
		public function behave(builds:FlxGroup):void {
			if ((moving.finished) || (blocked == true)) {
				rand = Math.floor(Math.random() * 7);
				if (blocked == true)
					blocked = false;
				if (moving.finished)
					moving.start(1);
			}
				switch(rand) {
					case 0:
						if (FlxG.overlap(builds, new FlxSprite(x - speed, y - speed))) {
							blocked = true;
							break;
						}
						this.x -= speed;
						this.y -= speed;
						break;
					case 1:
						if (FlxG.overlap(builds, new FlxSprite(x, y - speed))) {
							blocked = true;
							break;
						}
						this.y -= speed;
						break;
					case 2:
						if (FlxG.overlap(builds, new FlxSprite(x + speed, y - speed))) {
							blocked = true;
							break;
						}
						this.x += speed;
						this.y -= speed;
						break;
					case 3:
						if (FlxG.overlap(builds, new FlxSprite(x - speed, y))) {
							blocked = true;
							break;
						}
							break;
						this.x -= speed;
						break;
					case 4:
						if (FlxG.overlap(builds, new FlxSprite(x + speed, y))) {
							blocked = true;
							break;
						}
						this.x += speed;
						break;
					case 5:
						if (FlxG.overlap(builds, new FlxSprite(x - speed, y + speed))) {
							blocked = true;
							break;
						}
						this.x -= speed;
						this.y += speed;
						break;
					case 6:
						if (FlxG.overlap(builds, new FlxSprite(x, y + speed))) {
							blocked = true;
							break;
						}
						this.y += speed;
						break;
					case 7:
						if (FlxG.overlap(builds, new FlxSprite(x + speed, y + speed))) {
							blocked = true;
							break;
						}
						this.x += speed;
						this.y += speed;
						break;
					default:
						if (FlxG.overlap(builds, new FlxSprite(x - speed, y - speed))) {
							blocked = true;
							break;
						}
						this.x -= speed;
						this.y -= speed;
					}
		}
	}

}