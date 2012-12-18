package  
{
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
	
	/**
	 * ...
	 * @author ...
	 */
	public class GameOver extends FlxState 
	{
		
		[Embed(source = '../assets/IMAGES/GAME_OVER/game_over.png')] public var ImgGameOver:Class;
		[Embed(source="../assets/MUSIC/GAME_OVER_MUSIC.mp3")] public var Game_Over:Class;
		public var mus_gameover:FlxSound = new FlxSound();
		
		public function GameOver() 
		{
			add(new FlxSprite(0, 0, ImgGameOver));
			mus_gameover.loadEmbedded(Game_Over, false, true);
			mus_gameover.play();
		}
		
		override public function update():void {
			if (FlxG.keys.justReleased("ENTER") || FlxG.keys.justReleased("SPACE")) {
				FlxG.switchState(new Game());				
			}
		}
		
	}

}