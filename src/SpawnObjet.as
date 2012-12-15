package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * Spawn Objet
	 * @author ...
	 */
	public class SpawnObjet extends FlxSprite 
	{

		public var label:String = "";
		public var id:int = 0;
		private var imgs:ImgRegistry = new ImgRegistry;
		
		public function SpawnObjet(xpos:int, ypos:int, lab:String, index:int) 
		{
			id = index;
			super(xpos, ypos, imgs.assets[id +2]);
			x -= frameWidth / 2;
			y -= frameHeight / 2;
			label = lab;
		}
		
	}

}