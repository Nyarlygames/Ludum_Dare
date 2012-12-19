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
	import org.flixel.FlxSprite;
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
		[Embed(source="../assets/SOUNDS/POWERUPS/SPEED_UP.mp3")] public  var Speed_UP:Class;
		[Embed(source="../assets/SOUNDS/POWERUPS/SPEED_DOWN.mp3")] public  var Speed_DOWN:Class;

		public var maxspeed:int = 20;
		public var normalspeed:int = 15;
		public var lives:int = 2;                                                              
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
		public var niveau:Level = null;
		public var SUP:FlxSound = new FlxSound();
		public var SDOWN:FlxSound = new FlxSound();
		
		public function Player(x:int, y:int, width:int, height:int, lvl:Level) 
		{
			niveau = lvl;
			super(x, y, ImgPlayer);
			w = width;
			h = height;
			speed = 15;
			loadGraphic(ImgPlayer, true, false, 64, 64);
			nbanim++;
			addAnimation("walkd", [nbanim  + 0, nbanim  + 1, nbanim  + 2, nbanim  + 3], 20, false);
			nbanim += 5;
			addAnimation("walkg", [nbanim  + 0, nbanim  + 1, nbanim  + 2, nbanim  + 3], 20, false);
			nbanim += 5;
			addAnimation("walkhd", [nbanim  + 0, nbanim  + 1, nbanim  + 2, nbanim  + 3], 20, false);
			nbanim += 5;
			addAnimation("walkhg", [nbanim  + 0, nbanim  + 1, nbanim  + 2, nbanim  + 3], 20, false);
			pw_life.loadEmbedded(Get_Life, false, true);
			pw_shield.loadEmbedded(Got_shield, false, true);
			SUP.loadEmbedded(Speed_UP, false, true);
			SDOWN.loadEmbedded(Speed_DOWN, false, true);
		}
		
		override public function update():void {
			super.update();
			// DROITE
			if (lives >= 0) {
				
				
				
				
				
				if (FlxG.keys.pressed("UP") && (FlxG.keys.pressed("RIGHT"))){
					y -= speed;
					x += speed;
					play("walkhd");
				}
				else if (FlxG.keys.pressed("UP") && (FlxG.keys.pressed("LEFT"))) {
					y -= speed;
					x -= speed;
					play("walkhg");
				}
				else if (FlxG.keys.pressed("DOWN") && (FlxG.keys.pressed("LEFT"))){
					y += speed;
					x -= speed;
					play("walkg");
				}
				else if (FlxG.keys.pressed("DOWN") && (FlxG.keys.pressed("RIGHT"))){
					y += speed;
					x += speed;
					play("walkd");
				}
				else if ((FlxG.keys.pressed("RIGHT") || FlxG.keys.pressed("D")) && x < w - frameWidth) {
					x += speed;
					play("walkd");
				}
				// GAUCHE
				else if ((FlxG.keys.pressed("LEFT") || FlxG.keys.pressed("A")) && x > 0) {
					x -= speed;
					play("walkg");
				}
				// HAUT
				else if ((FlxG.keys.pressed("UP") || FlxG.keys.pressed("W")) && y > 0) {
					y -= speed;	
					play("walkhd");
				}
				// BAS
				else if ((FlxG.keys.pressed("DOWN") || FlxG.keys.pressed("Z")) && y < h - frameHeight) {
					y += speed;
					play("walkg");
				}
				
				
				if (FlxG.keys.justReleasedAny() != -1) {
					frame = 0;
				}
				
				if ((pw_speed_timer != null) && (pw_speed_timer.finished)) {
					speed = normalspeed;
					SDOWN.play();
					pw_speed_timer = null;
				}
			}
		}
		
		public function getBuild():void {
			for each (var z:Buildings in buildings.members) {	
				if ((z != null) && (FlxG.overlap(this, z.hitbox))) {
					if (z.take != this) {
						z.timer = new FlxTimer();
						z.timer.start(z.time);
						z.take = this;
						z.sfx_getting.play();
					}
				}
				else if (z.timer != null) {
					z.timer.stop();
					z.take = null;
					z.sfx_getting.stop();
				}
			}
		}
		
		public function getLoot(obj1:Player, obj2:SpawnObjet):void {
			switch(obj2.label){
				case "Jeu":
					if (obj2.spawntype == 1) {
						if (shield == 0) {
							shield++;
							pw_shield.play();
							var vie:FlxSprite = new FlxSprite(299, 53, niveau.ui.ImgShield);
							vie.scrollFactor.x = vie.scrollFactor.y = 0;
							niveau.ui.lives.add(vie);
						}
					}
					else {
						speed = maxspeed;
						SUP.play(); 
						pw_speed_timer = new FlxTimer();
						pw_speed_timer.start(pw_speed_time);
					}
				break;
				case "Hopital":
					if (lives < 2) {
						niveau.ui.lives.members[lives+1].loadGraphic(niveau.ui.ImgLife, true, false, 32, 32);
						lives++;
						niveau.ui.lives.members[lives].scrollFactor.x = niveau.ui.lives.members[lives].scrollFactor.y = 0;
						pw_life.play();
					}
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