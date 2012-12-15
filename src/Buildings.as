package  
{
	import org.flixel.FlxSprite;
	/**
	 * Bâtiments
	 * @author ...
	 */
	public class Buildings extends FlxSprite
	{
		private var imgs:ImgRegistry = new ImgRegistry();
		
		public function Buildings(x:int, y:int, id:int) 
		{
			super(x, y, imgs.assets[id]);
		}
		
		
	}

}