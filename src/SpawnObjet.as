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
		public var spawntype:int = 0;
		
		public function SpawnObjet(xpos:int, ypos:int, lab:String, index:int, spawn:int) 
		{
			spawntype = spawn;
			id = index;
			super(xpos, ypos, imgs.assets[id +3 + spawn]);
			x -= frameWidth / 2;
			label = lab;
		}
		
	}

}