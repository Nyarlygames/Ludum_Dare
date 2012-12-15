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
		[Embed(source = '../assets/gfx/building2.png')] public var ImgBuilding2:Class;
		private var imgs:ImgRegistry = new ImgRegistry();
		private var timer:FlxTimer = new FlxTimer();
		private var timer_spawn:FlxTimer = new FlxTimer();
		private var time:int = 2;
		private var team:Boolean = false;
		private var take:FlxSprite = null;
		private var taken:Boolean = false;
		public var loot:SpawnObjet;
		private var id:int = 1;
		private var spawntime:int = 10;
		
		public function Buildings(x:int, y:int, index:int) 
		{
			super(x, y, imgs.assets[index]);
			id = index;
		}
		
		override public function update():void {
			super.update();
			if ((timer != null) && (timer.finished) && (take != null)) {
				team = !team;
				if (team)
					loadGraphic(ImgBuilding2);
				else
					loadGraphic(imgs.assets[id]);
				timer = null;
				taken = true;
				spawnobj();
				timer_spawn.start(spawntime);
			}
			
			if ((taken == true) && (timer_spawn.finished)) {
				if ((loot != null) && (loot.exists == false)) 
					spawnobj();
				timer_spawn.start(spawntime);
			}
			
		}
		
		public function spawnobj():void {
			loot = new SpawnObjet(x + frameWidth/2, y + frameHeight/2);
			FlxG.state.add(loot);
		}
		
		
		public function playerGet(source:FlxSprite):void {
			if (FlxCollision.pixelPerfectCheck(source, this) && (take != source)) {
				timer = new FlxTimer();
				timer.start(time);
				take = source;
			}
			else if (/*batiment repris qu'une seule fois--*/(timer != null)/*--*/ && !FlxCollision.pixelPerfectCheck(source, this) && (take == source)) {
				if (timer != null)
					timer.stop();
				take = null;
			}
		}
	}

}