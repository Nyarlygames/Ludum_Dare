package  
{
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxTimer;
	
	/**
	 * Bâtiments
	 * @author ...
	 */
	public class Buildings extends FlxSprite
	{
		[Embed(source = '../assets/gfx/building2.png')] public var ImgBuilding2:Class;
		private var imgs:ImgRegistry = new ImgRegistry();
		private var timer:FlxTimer = new FlxTimer();
		private var time:int = 2;
		private var team:Boolean = false;
		private var take:FlxSprite = null;
		private var id:int = 1;
		
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
			}
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