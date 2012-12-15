package  
{

	import org.flixel.FlxObject;

	/**
	 * Banque d'images
	 * @author ...
	 */
	public class ImgRegistry
	{
		
		
		[Embed(source = '../assets/gfx/bg.png')] public var ImgBG1:Class;
		[Embed(source = '../assets/gfx/building.png')] public var ImgBuilding:Class;
		
		public var assets:Array = new Array();
		
		public function ImgRegistry() 
		{
			assets.push(ImgBG1);
			assets.push(ImgBuilding);
		}
	}

}