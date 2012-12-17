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
		
		[Embed(source = '../assets/gfx/anim_kid.png')] public var ImgKid:Class;
		public var validated:Boolean = false;
		public var moving:FlxTimer = new FlxTimer();
		public var rand:int = -1;
		public var blocked:Boolean = false;
		public var bisounours:int = 14;
		public var infect:int = 14;
		public var rating:Array = null
		public var ratid:int = 0;
		public var nbanim:int = 1;
		public var lastdir:uint = 8;
		public var INFECTED_MODE:FlxSound = new FlxSound();
		
		public function Kid(x:int, y:int) 
		{
			moving.start(1);
			super(x, y, null);
			loadGraphic(ImgKid, true, false, 64, 64);
			addAnimation("walkhd", [0, 1, 2, 3, 4], 10, true);
			addAnimation("walkh", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			nbanim++;
			addAnimation("walkhg", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			nbanim++;
			addAnimation("walkbg", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true); // ICI BAS FOIRE
			addAnimation("walkb", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			nbanim++;
			addAnimation("walkbd", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			nbanim++;
			addAnimation("attack_hd", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			nbanim++;
			addAnimation("attack_hg", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			nbanim++;
			addAnimation("attack_bg", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			nbanim++;
			addAnimation("attack_bg", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			health = 10;
			speed = 5;
			INFECTED_MODE.loadStream("../assets/sfx/ENFANT/INFECTED_MODE.mp3", false, false);
		}
		
		override public function update():void {
			
			if(!Game.paused) {
				if (x < 0)
					x = 0;
				if (x > FlxG.worldBounds.width - frameWidth)
					x = FlxG.worldBounds.width - frameWidth;
				if (y < 0)
					y = 0;
				if (y > FlxG.worldBounds.height - frameHeight)
					y = FlxG.worldBounds.height - frameHeight;
			}
			
			if (lastdir != dir) {
				switch(dir) { }
			}
			lastdir= dir;
			if (rating != null) {
				switch (rating[ratid][3]) {
					case "Kick":
						break;
					case "Gun":
						break;
					case "MG":
						break;
					default:
						break;
				}
				health = rating[ratid][4];
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
						play("walkhg");
						break;
					case 1:
						if (FlxG.overlap(builds, new FlxSprite(x, y - speed))) {
							blocked = true;
							break;
						}
						this.y -= speed;
						play("walkh");
						break;
					case 2:
						if (FlxG.overlap(builds, new FlxSprite(x + speed, y - speed))) {
							blocked = true;
							break;
						}
						this.x += speed;
						this.y -= speed;
						play("walkhd");
						break;
					case 3:
						if (FlxG.overlap(builds, new FlxSprite(x - speed, y))) {
							blocked = true;
							break;
						}
							break;
						this.x -= speed;
						play("walkg");
						break;
					case 4:
						if (FlxG.overlap(builds, new FlxSprite(x + speed, y))) {
							blocked = true;
							break;
						}
						this.x += speed;
						play("walkd");
						break;
					case 5:
						if (FlxG.overlap(builds, new FlxSprite(x - speed, y + speed))) {
							blocked = true;
							break;
						}
						this.x -= speed;
						this.y += speed;
						play("walkbg");
						break;
					case 6:
						if (FlxG.overlap(builds, new FlxSprite(x, y + speed))) {
							blocked = true;
							break;
						}
						this.y += speed;
						play("walkb");
						break;
					case 7:
						if (FlxG.overlap(builds, new FlxSprite(x + speed, y + speed))) {
							blocked = true;
							break;
						}
						this.x += speed;
						this.y += speed;
						play("walkbd");
						break;
					default:
						if (FlxG.overlap(builds, new FlxSprite(x - speed, y - speed))) {
							blocked = true;
							break;
						}
						this.x -= speed;
						this.y -= speed;
						play("walkhg");
					}
		}
	}

}