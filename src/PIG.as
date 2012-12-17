package  
{
	/**
	 * ...
	 * @author ...
	 */
	public class PIG extends ESRB 
	{
		[Embed(source = '../assets/gfx/pig.png')] public var ImgPig:Class;
		
		public function PIG(x:int, y:int) 
		{
			super(x, y, ImgPig);
			health = 50;
			attack = 10;
		}
		
	}

}