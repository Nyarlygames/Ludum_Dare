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
		public var timer:FlxTimer = new FlxTimer();
		private var timer_spawn:FlxTimer = new FlxTimer();
		public var time:int = 2;
		private var team:Boolean = false;
		public var take:FlxSprite = null;
		public var taken:Boolean = false;
		public var loot:SpawnObjet;
		public var id:int = 1;
		private var spawntime:int = 15;
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
		public var spawntype:int = 0;
		
		public function Buildings(x:int, y:int, index:int, lab:String, truth:Boolean, spawn:int) 
		{
			super(x, y, imgs.assets[index]);
			if (truth) {
				hitbox = new FlxSprite(x, y + frameHeight, imgs.assets[index + 2]);
				hitbox.immovable = true;
				spawntype = spawn;
			}
			label = lab;
			immovable = true;
			lootable = truth;
			id = index;
		}
		
		override public function update():void {
			super.update();
			if ((timer != null) && (timer.finished) && (take != null)) {
				team = !team;
				if (team)
					loadGraphic(imgs.assets[id+1]);
				else
					loadGraphic(imgs.assets[id]);
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
			loot = new SpawnObjet(x + frameWidth / 2, y + frameHeight, label, id, spawntype);
			FlxG.state.add(loot);
		}
		
		public function getTakeCoord(x:int):Array {
			return [Math.round((this.y + this.frameHeight) / Constants.TILESIZE),Math.round(this.x/ Constants.TILESIZE),Math.round(x/ Constants.TILESIZE)];
		}
	}

}