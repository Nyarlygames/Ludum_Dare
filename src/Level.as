package
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.plugin.photonstorm.FlxCollision;
	
	/**
	 * Level
	 * @author 
	 */
	public class Level extends FlxState
	{	
		[Embed(source = "../maps/map01.txt", mimeType = "application/octet-stream")] public var map1:Class;
		private var player:Player;
		private var kids:FlxGroup = new FlxGroup();
		private var esrbs:FlxGroup = new FlxGroup();
		private var builds:FlxGroup = new FlxGroup();
		private var map:Map = new Map(map1);
		private var background:FlxSprite;
		private var imgs:ImgRegistry = new ImgRegistry;
		
		
		public function Level():void
		{
			background = new FlxSprite(0, 0, imgs.assets[int (map.bg)]);
			add(background);
			// JOUEUR
			player = new Player(0, 0);
			add(player);
			esrbs = map.esrbs;
			kids = map.kids;
			builds = map.builds;
			add(esrbs);
			add(kids);
			add(builds);
		}
		
		override public function update():void {
			super.update();
		}
		
	}
}
