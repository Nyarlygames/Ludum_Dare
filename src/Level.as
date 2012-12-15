package
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	/**
	 * Level
	 * @author 
	 */
	public class Level extends FlxState
	{	
		private var player:Player;
		private var kids:FlxGroup = new FlxGroup();
		private var esrbs:FlxGroup = new FlxGroup();
		
		public function Level():void
		{
			// JOUEUR
			player = new Player(0, 0);
			add(player);
			// ENFANTS
			kids.add(new Kid(100, 0));
			add(kids);
			// ESRB
			esrbs.add(new ESRB(200, 0));
			add(esrbs);
		}
		
	}
}
