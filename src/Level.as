package
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxPoint;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxTimer;
	
	/**
	 * Level
	 * @author 
	 */
	public class Level extends FlxState
	{	
			
		[Embed(source = "../maps/map01.txt", mimeType = "application/octet-stream")] public var map1:Class;
		public var player:Player;
		private var kids:FlxGroup = new FlxGroup();
		private var esrbs:FlxGroup = new FlxGroup();
		private var builds:FlxGroup = new FlxGroup();
		public var map:Map = new Map(map1);
		private var background:FlxSprite;
		private var imgs:ImgRegistry = new ImgRegistry;
		private var ui:UI;
		public var score:int = 0;
		public var name:String = "";
		public var rating:String = "";
		public var timecount:FlxTimer;
		public var shopcount:int = 0;
		public var childcount:int = 0;
		
		public function Level(nom:String, rat:String):void
		{
			timecount = new FlxTimer();
			timecount.start(300);
			rating = rat;
			name = nom;
			background = new FlxSprite(0, 0, imgs.assets[int (map.bg)]);
			add(background);
			// JOUEUR
			player = new Player(FlxG.width/2, FlxG.height/2);
			add(player);
			esrbs = map.esrbs;
			kids = map.kids;
			builds = map.builds;
			add(esrbs);
			add(kids);
			add(builds);
			ui = new UI(this);
			add(ui);
			add(ui.components);
		}
		
		override public function update():void {
			super.update();
			// Collisions buildings
			for each (var b:Buildings in builds.members) {
				if (b != null) {
					if (b.taken == false) {
						b.playerGet(player);
					}
					else if (b.validated == false) {
						shopcount++;
						b.validated = true;
						if (shopcount == 3)
							score += 1000;
					}
					// loots
					if (b.loot != null)
						FlxG.overlap(player, b.loot, player.getLoot);
					// Collision building => esrb
					for each (var e:ESRB in esrbs.members) {
						if (e != null){
							b.playerGet(e);
						}
					}
				}
			}
			if ((timecount != null) && (timecount.finished)) {
				score += 800;
			}
			
			/*// Collisions kids
			for each (var k:Kid in kids.members) {
				if (k != null) {
					if (b.validated == false) {
						childcount++;
						k.validated = true;
						if (childcount == 3)
							score += 1000;
					}
					FlxG.overlap(player, b.loot, player.getLoot);
				}
			}*/
			
		}
		
	}
}
