package  
{

	import org.flixel.FlxObject;

	/**
	 * Banque d'images
	 * @author ...
	 */
	public class ImgRegistry
	{
		[Embed(source = '../assets/gfx/ph_empty_bg.png')] public var ImgBG1:Class;
		[Embed(source = '../assets/gfx/ph_hospi.png')] public var ImgHop:Class;
		[Embed(source = '../assets/gfx/hb_hospi.png')] public var ImgHop2:Class;
		[Embed(source = '../assets/gfx/ph_coeur.png')] public var ImgSpawnCoeur:Class;
		[Embed(source = '../assets/gfx/ph_magjv.png')] public var ImgJeu:Class;
		[Embed(source = '../assets/gfx/building2.png')] public var ImgJeu2:Class;
		[Embed(source = '../assets/gfx/ph_speed.png')] public var ImgSpawnSpeed:Class;
		[Embed(source = '../assets/gfx/ph_ecoles.png')] public var ImgEcole:Class;
		[Embed(source = '../assets/gfx/ph_serb.png')] public var ImgCentre:Class;
		[Embed(source = '../assets/gfx/ph_fontaine.png')] public var ImgFontaine:Class;
		[Embed(source = '../assets/gfx/ph_maison.png')] public var ImgMaison:Class;
		[Embed(source = '../assets/gfx/spawnobjhop.png')] public var Imgtest:Class;

		public var assets:Array = new Array();
		
		public function ImgRegistry() 
		{
			assets.push(ImgBG1);
			assets.push(ImgHop);
			assets.push(ImgHop2);
			assets.push(ImgSpawnCoeur);
			assets.push(ImgJeu);
			assets.push(ImgJeu2);
			assets.push(ImgSpawnSpeed);
			assets.push(ImgEcole);
			assets.push(ImgCentre);
			assets.push(ImgFontaine);
			assets.push(ImgMaison);
			assets.push(Imgtest);
		}
	}

}