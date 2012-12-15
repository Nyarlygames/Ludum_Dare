package  
{
	import org.flixel.FlxSprite;
	/**
	 * Mother class of every character class
	 * @author Jidehem1993
	 */
	public class Character extends FlxSprite 
	{
		public var Img:Class;
		
		public function Character(x:int, y:int, Img:Class) 
		{
			super(x, y, Img);
		}
		
		/*
		 * Find square of the object from its coordinates
		 */
		public function getSquare():Array {
			return [Math.round(this.x / Constants.NBTILESWIDTH),Math.round(this.y / Constants.NBTILESHEIGHT)];
		}
	}

}