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
		
		[Embed(source = '../assets/gfx/life.png')] public var ImgLife:Class;
		public var score:FlxText;
		public var name:FlxText;
		public var rating:FlxText;
		public var life:FlxText;
		public var obje:FlxText;
		public var objs:FlxText;
		public var objt:FlxText;
		public var components:FlxGroup = new FlxGroup();
		public var level:Level;
		public var offsetx:int = 200;
		public var objectives:FlxSprite;
		public var graphicx:int = 200;
		public var graphicy:int = 100;
		
		public function UI(play:Level) 
		{
			level = play;
			// Premier overlay
			super(offsetx, 0)
			makeGraphic(graphicx, graphicy, 0xaa4E4F4D, true);
			scrollFactor.x = scrollFactor.y =  0;
			
			// DEUXIEME OVERLAY
			objectives = new FlxSprite(FlxG.width - 2*offsetx,0 );
			objectives.makeGraphic(graphicx, graphicy, 0xaa4E4F4D, true);
			objectives.scrollFactor.x = objectives.scrollFactor.y = 0;
			components.add(objectives);
			
			// SCORE
			score = new FlxText(FlxG.width - 2 * offsetx, 0, graphicy, "Score :");
			score.y += score.frameHeight;
			score.setFormat(null, 14, 0xADAEAC);
			score.scrollFactor.x = score.scrollFactor.y = 0;
			components.add(score);
			
			// OBJECTIF ENFANTS
			obje = new FlxText(FlxG.width - 2 * offsetx, score.frameHeight, graphicy +10, "");
			obje.y += obje.frameHeight;
			obje.setFormat(null, 14, 0xADAEAC);
			obje.scrollFactor.x = obje.scrollFactor.y = 0;
			components.add(obje);
			// OBJECTIF SHOPS
			objs = new FlxText(FlxG.width - 2 * offsetx, 2*score.frameHeight, graphicy, "");
			objs.y += objs.frameHeight;
			objs.setFormat(null, 14, 0xADAEAC);
			objs.scrollFactor.x = objs.scrollFactor.y = 0;
			components.add(objs);
			// OBJECTIF TIME
			objt = new FlxText(FlxG.width - 2 * offsetx, 3*score.frameHeight, graphicy + 100, "");
			objt.y += objt.frameHeight;
			objt.setFormat(null, 14, 0xADAEAC);
			objt.scrollFactor.x = objt.scrollFactor.y = 0;
			components.add(objt);
			
			// NAME
			name = new FlxText(offsetx, 0, graphicy, "Nom :");
			name.y += name.frameHeight;
			name.setFormat(null, 14, 0xADAEAC);
			name.scrollFactor.x = name.scrollFactor.y = 0;
			components.add(name);
			
			// RATING
			rating = new FlxText(offsetx + graphicx, graphicy - name.frameHeight, graphicy, "");
			rating.y -= rating.frameHeight;
			rating.x -= rating.frameWidth / 2;
			rating.setFormat(null, 14, 0xADAEAC);
			rating.scrollFactor.x = rating.scrollFactor.y = 0;
			components.add(rating);
			
			// LIVES
			life = new FlxText(offsetx, graphicy - name.frameHeight, graphicy, "");
			life.y -= life.frameHeight;
			life.setFormat(null, 14, 0xADAEAC);
			life.scrollFactor.x = life.scrollFactor.y = 0;
			components.add(life);
		}
		
		override public function update():void {
			/*for (var i:int = 0; i < level.player.lives; i++) {
				var life:FlxSprite = new FlxSprite(offsetx, graphicy - name.frameHeight, ImgLife);
				life.x += i * life.frameWidth;
				life.y -= life.frameHeight;
				components.add(life);
			}*/
			life.text = "Vies : "+level.player.lives;
			score.text = "Score : " + level.score;
			name.text = level.name;
			rating.text = level.rating;
			if (level.map.childs > -1)
				obje.text = "Enfants : " + level.map.childs;
			else
				obje.text = "Enfants validés";
			if (level.playtime.timeLeft > -1)
				objt.text = "Time : " + FlxU.formatTime	(level.playtime.timeLeft);	
			else
				objt.text = "Temps validé";
				
			if (level.map.shops > -1)
				objs.text = "Shops : " + level.map.shops;
			else
				objt.text = "Shops validés";
		}
	}

}