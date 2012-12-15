package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * Player
	 * @author ...
	 */
	public class Player extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/player.png')] public var ImgPlayer:Class;
		public function Player(x:int, y:int) 
		{
			super(x, y, ImgPlayer);
		}
		
	}

}