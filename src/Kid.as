package  
{
	
	/**
	 * KID
	 * @author ...
	 */
	public class Kid extends Character
	{
		
		[Embed(source = '../assets/gfx/kid.png')] public var ImgKid:Class;
		public var validated:Boolean = false;
		
		public function Kid(x:int, y:int) 
		{
			super(x, y, ImgKid);
		}
	}

}