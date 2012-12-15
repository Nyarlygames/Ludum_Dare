package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * ESRB
	 * @author ...
	 */
	public class ESRB extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/esrb.png')] public var ImgESRB:Class;
		public function ESRB(x:int, y:int) 
		{
			super(x, y, ImgESRB);
		}
		
	}

}