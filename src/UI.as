package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	import org.flixel.FlxTimer;
	import org.flixel.FlxU;
	
	/**
	 * ...
	 * @author ...
	 */
	public class UI extends FlxSprite 
	{
		
		[Embed(source = '../assets/IMAGES/HUD/current_rating_7.png')] public var Img7:Class;
		[Embed(source = '../assets/IMAGES/HUD/current_rating_12.png')] public var Img12:Class;
		[Embed(source = '../assets/IMAGES/HUD/current_rating_18.png')] public var Img18:Class;
		[Embed(source = '../assets/IMAGES/HUD/life.png')] public var ImgLife:Class;
		[Embed(source = '../assets/IMAGES/HUD/life_empty.png')] public var ImgLifeEmpty:Class;
		[Embed(source = '../assets/IMAGES/HUD/shield.png')] public var ImgShield:Class;
		[Embed(source = '../assets/IMAGES/HUD/objective_check.png')] public var ImgObjCheck:Class;
		[Embed(source = '../assets/IMAGES/HUD/objective_uncheck.png')] public var ImgObjUncheck:Class;
		public var score:FlxText;
		public var encount:FlxText;
		public var kidcount:FlxText;
		public var life:FlxText;
		public var obje:FlxText;
		public var objs:FlxText;
		public var objt:FlxText;
		public var nben:FlxText;
		public var nbch:FlxText;
		public var components:FlxGroup = new FlxGroup();
		public var level:Level;
		public var offsetx:int = 200;
		public var objectives:FlxSprite;
		public var nbobjs:int = 0;
		public var graphicx:int = 100;
		public var graphicy:int =  100;
		public var rating_sprite:FlxSprite;
		public var lives:FlxGroup = new FlxGroup();
		public var objects:FlxGroup = new FlxGroup;
		
		public function UI(play:Level) 
		{
			level = play;
			// Premier overlay
			super(55, 0);
			makeGraphic(298, 105, 0xfafe9f9f, true);
			scrollFactor.x = scrollFactor.y =  0;
			
			// DEUXIEME OVERLAY
			objectives = new FlxSprite(685,0 );
			objectives.makeGraphic(298, 105, 0xfafe9f9f, true);
			objectives.scrollFactor.x = objectives.scrollFactor.y = 0;
			components.add(objectives);
			
			// SCORE
			score = new FlxText(157, 21, FlxG.width, "Score " + FlxG.score);
			score.setFormat(null, 14, 0xa10000);
			score.scrollFactor.x = score.scrollFactor.y = 0;
			components.add(score);
			
			// OBJECTIF ENFANTS
			obje = new FlxText(740, 18, FlxG.width, "");
			obje.setFormat(null, 14, 0xa10000);
			obje.scrollFactor.x = obje.scrollFactor.y = 0;
			components.add(obje);
			// OBJECTIF SHOPS
			objs = new FlxText(740, 47, FlxG.width, "");
			objs.setFormat(null, 14, 0xa10000);
			objs.scrollFactor.x = objs.scrollFactor.y = 0;
			components.add(objs);
			// OBJECTIF TIME
			objt = new FlxText(740, 75, FlxG.width, "");
			objt.setFormat(null, 14, 0xa10000);
			objt.scrollFactor.x = objt.scrollFactor.y = 0;
			components.add(objt);
			
			
			var objectif:FlxSprite = new FlxSprite (700, 0, ImgObjUncheck);
			objectif.scrollFactor.x = objectif.scrollFactor.y = 0;
			objects.add(objectif);
			objectif = new FlxSprite (700, 32, ImgObjUncheck);
			objectif.scrollFactor.x = objectif.scrollFactor.y = 0;
			objects.add(objectif);
			objectif = new FlxSprite (700, 64, ImgObjUncheck);
			objectif.scrollFactor.x = objectif.scrollFactor.y = 0;
			objects.add(objectif);
			
			var vie:FlxSprite = new FlxSprite(157, 53, ImgLife);
			vie.scrollFactor.x = vie.scrollFactor.y = 0;
			lives.add(vie);
			vie = new FlxSprite(205, 53, ImgLife);
			vie.scrollFactor.x = vie.scrollFactor.y = 0;
			lives.add(vie);
			vie = new FlxSprite(251, 53, ImgLife);
			vie.scrollFactor.x = vie.scrollFactor.y = 0;
			lives.add(vie);
			
			components.add(objects);
			components.add(lives);
			rating_sprite = new FlxSprite(64, 8, Img7);
			rating_sprite.scrollFactor.x = rating_sprite.scrollFactor.y = 0;
			components.add(rating_sprite);
		}
		
		override public function update():void {
			if (!Game.paused) {
				score.text = "Score " + FlxG.score;
				
				if (level.map.childs > 0)
					obje.text = "CONVERT " + level.map.childs + " CHILDREN";
				else if (level.map.childs == 0) {
					FlxG.score += 500;
					obje.text = "CHILDREN CONVERTED.";
					nbobjs++;
					objects.members[0] = new FlxSprite(objects.members[0].x, objects.members[0].y, ImgObjCheck);
					objects.members[0].scrollFactor.x = objects.members[0].scrollFactor.y = 0;
					level.map.childs = -1;
				}
				
				if ((level.playtime != null) && (level.playtime.finished == false))
					objt.text = "SURVIVE : " + FlxU.formatTime	(level.playtime.timeLeft) + " MINUTES.";	
				else if ((level.playtime != null) && (level.playtime.finished)) {
					FlxG.score += 400;
					objt.text = "TIME SURVIVED.";	
					nbobjs++;
					objects.members[2] = new FlxSprite(objects.members[2].x, objects.members[2].y, ImgObjCheck);
					objects.members[2].scrollFactor.x = objects.members[2].scrollFactor.y = 0;
					level.playtime = null;
				}
				
				if (level.map.shops > 0)
					objs.text = "CAPTURE " + level.map.shops + " BUILDINGS.";
				else if (level.map.shops > -1) {
					objs.text = " CAPTURED.";
					FlxG.score += 500;
					objects.members[1] = new FlxSprite(objects.members[1].x, objects.members[1].y, ImgObjCheck);
					objects.members[1].scrollFactor.x = objects.members[1].scrollFactor.y = 0;
					nbobjs++;
					level.map.shops = -1;
				}
			}
		}
	}
}