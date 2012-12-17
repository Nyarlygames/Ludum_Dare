package  
{

	import org.flixel.FlxObject;

	/**
	 * Banque d'images
	 * @author ...
	 */
	public class ImgRegistry
	{
		[Embed(source = '../assets/IMAGES/ENVIRONMENTS/background.png')] public var ImgBG1:Class;
		[Embed(source = '../assets/IMAGES/BUILDINGS/hospital_normal.png')] public var ImgHop:Class;
		[Embed(source = '../assets/IMAGES/BUILDINGS/hospital_converted.png')] public var ImgHop2:Class;
		[Embed(source = '../assets/IMAGES/hb_hospi.png')] public var ImgHopHB:Class;
		[Embed(source = '../assets/IMAGES/POWERUP/life_floor.png')] public var ImgSpawnCoeur:Class;
		[Embed(source = '../assets/IMAGES/BUILDINGS/market.png')] public var ImgJeu:Class;
		[Embed(source = '../assets/IMAGES/BUILDINGS/market_converted.png')] public var ImgJeu2:Class;
		[Embed(source = '../assets/IMAGES/hb_jeu.png')] public var ImgJeuHB:Class;
		[Embed(source = '../assets/IMAGES/ph_speed.png')] public var ImgSpawnSpeed:Class;
		[Embed(source = '../assets/IMAGES/POWERUP/shield_floor.png')] public var ImgSpawnShield:Class;
		[Embed(source = '../assets/IMAGES/BUILDINGS/school.png')] public var ImgEcole:Class;
		[Embed(source = '../assets/IMAGES/BUILDINGS/serb.png')] public var ImgCentre:Class;
		[Embed(source = '../assets/IMAGES/BUILDINGS/ph_fontaine.png')] public var ImgFontaine:Class;
		[Embed(source = '../assets/IMAGES/BUILDINGS/house.png')] public var ImgMaison:Class;

		public var assets:Array = new Array();
		
		public function ImgRegistry() 
		{
			assets.push(ImgBG1);
			assets.push(ImgHop);
			assets.push(ImgHop2);
			assets.push(ImgHopHB);
			assets.push(ImgSpawnCoeur);
			assets.push(ImgJeu);
			assets.push(ImgJeu2);
			assets.push(ImgJeuHB);
			assets.push(ImgSpawnSpeed);
			assets.push(ImgSpawnShield);
			assets.push(ImgEcole);
			assets.push(ImgCentre);
			assets.push(ImgFontaine);
			assets.push(ImgMaison);
		}
	}

}