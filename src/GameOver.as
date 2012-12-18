package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameOver extends FlxState 
	{
		
		[Embed(source = '../assets/IMAGES/GAME_OVER/game_over.png')] public var ImgGameOver:Class;
		public function GameOver() 
		{
			add(new FlxSprite(0, 0, ImgGameOver));
		}
		
		override public function update():void {
			if (FlxG.keys.justReleased("ENTER") || FlxG.keys.justReleased("SPACE")) {
				FlxG.switchState(new Game());				
			}
		}
		
	}

}