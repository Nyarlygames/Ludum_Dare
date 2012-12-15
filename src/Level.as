package
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
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
			// Collisions buildings
			for each (var b:Buildings in builds.members) {
				if (b != null){
					b.playerGet(player);
					// loots
					if (b.loot != null)
						FlxG.overlap(player, b.loot, player.getLoot);
					// Collision building => esrb)
					for each (var e:ESRB in esrbs.members) {
						if (e != null){
							b.playerGet(e);
						}
					}
				}
			}
		}
		
	}
}
