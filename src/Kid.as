package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * KID
	 * @author ...
	 */
	public class Kid extends Character 
	{
		
		[Embed(source = '../assets/gfx/kid.png')] public var ImgKid:Class;
		public function Kid(x:int, y:int) 
		{
			super(x, y, ImgKid);
		}
	}

}