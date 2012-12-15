package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ...
	 * @author Jidehem1993
	 */
	public class Character extends FlxSprite 
	{
		
		public var Img:Class;
		public function Character(x:int, y:int, Img:Class) 
		{
			super(x, y, Img);
		}
		
	}

}