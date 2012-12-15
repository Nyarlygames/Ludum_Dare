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
		[Embed(source = '../assets/gfx/building2.png')] public var ImgBuilding2:Class;
		[Embed(source = '../assets/gfx/spawnobj.png')] public var ImgSpawnObj:Class;
		[Embed(source = '../assets/gfx/hopital.png')] public var ImgHop:Class;
		[Embed(source = '../assets/gfx/building2.png')] public var ImgHop2:Class;
		[Embed(source = '../assets/gfx/spawnobjhop.png')] public var ImgSpawnObjHop:Class;
		[Embed(source = '../assets/gfx/autres.png')] public var ImgAutres:Class;
		[Embed(source = '../assets/gfx/building2.png')] public var ImgAutres2:Class;
		[Embed(source = '../assets/gfx/spawnobjautres.png')] public var ImgSpawnObjAutres:Class;
		
		public var assets:Array = new Array();
		
		public function ImgRegistry() 
		{
			assets.push(ImgBG1);
			assets.push(ImgBuilding);
			assets.push(ImgBuilding2);
			assets.push(ImgSpawnObj);
			assets.push(ImgHop);
			assets.push(ImgHop2);
			assets.push(ImgSpawnObjHop);
			assets.push(ImgAutres);
			assets.push(ImgAutres2);
			assets.push(ImgSpawnObjAutres);
		}
	}

}