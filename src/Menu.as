package
{
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	 
	/**
	 * Menu state
	 * @author 
	 */
	public class Menu extends FlxState
	{
		
		/**
		 * Create the menu state
		 */
		override public function create():void
		{
			var title:FlxText = new FlxText(FlxG.width / 2 - 50, FlxG.height / 2 - 200, 100, "Ludum Dare #25");
			title.setFormat(null, 16, 0x044071);
			add(title);
		}
		
		/**
		 * Update the state
		 */
		override public function update():void
		{
			super.update();
			
			if (FlxG.keys.pressed("SPACE")) {
				FlxG.switchState(new Game());
			}
		}
	}
}
