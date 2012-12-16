package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxTimer;
	import org.flixel.FlxG;
	
	/**
	 * Bâtiments
	 * @author ...
	 */
	public class Buildings extends FlxSprite
	{
		private var imgs:ImgRegistry = new ImgRegistry();
		private var timer:FlxTimer = new FlxTimer();
		private var timer_spawn:FlxTimer = new FlxTimer();
		private var time:int = 2;
		private var team:Boolean = false;
		private var take:FlxSprite = null;
		public var taken:Boolean = false;
		public var loot:SpawnObjet;
		public var id:int = 1;
		private var spawntime:int = 2;
		public var label:String = "";
		public var validated:Boolean = false;
		public var lootable:Boolean = false;
		public var hitbox:FlxSprite = null;
		public var spawnkid:int = 2;
		public var spawnesrb:int = 2;
		public var bspawnkid:Boolean = false;
		public var bspawnesrb:Boolean = false;
		public var spawntimer:FlxTimer = new FlxTimer();
		public var spawntimeresrb:FlxTimer = new FlxTimer();
		
		public function Buildings(x:int, y:int, index:int, lab:String, truth:Boolean) 
		{
			if (truth) {
				hitbox = new FlxSprite(x, y, imgs.assets[index + 1]);
				hitbox.immovable = true;
			}
			super(x, y, imgs.assets[index]);
			label = lab;
			immovable = true;
			lootable = truth;
			id = index;
		}
		
		override public function update():void {
			super.update();
			if ((timer != null) && (timer.finished) && (take != null)) {
				team = !team;
				/*
				if (team)
					loadGraphic(imgs.assets[id+1]);
				else
					loadGraphic(imgs.assets[id]);*/
				timer = null;
				taken = true;
				spawnobj();
				timer_spawn.start(spawntime);
			}
			if ((taken == true) && (timer_spawn.finished)) {
				if ((loot != null) && (loot.exists == false) && (lootable == true)) 
					spawnobj();
				timer_spawn.start(spawntime);
			}
			
			
			
		}
		
		public function spawnobj():void {
			loot = new SpawnObjet(x + frameWidth/2, y + frameHeight/2, label, id);
			FlxG.state.add(loot);
		}
		
		
		public function playerGet(source:FlxSprite):void {
			if (FlxCollision.pixelPerfectCheck(source, this) && (take != source)) {
				timer = new FlxTimer();
				timer.start(time);
				take = source;
			}
			else if ((timer != null) && !FlxCollision.pixelPerfectCheck(source, this) && (take == source)) {
				if (timer != null)
					timer.stop();
				take = null;
			}
		}
	}

}