package  
{
	import org.flixel.FlxSprite;
	
	/**
	 * Spawn Objet
	 * @author ...
	 */
	public class SpawnObjet extends FlxSprite 
	{
		
		[Embed(source = '../assets/gfx/spawnobj.png')] public var ImgSpawnObj:Class;
		
		public function SpawnObjet(xpos:int, ypos:int) 
		{
			super(xpos, ypos, ImgSpawnObj);
			x -= frameWidth / 2;
			y -= frameHeight / 2;
			
		}
		
	}

}