package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText;
	import org.flixel.FlxG;
	
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
			
			// DEUXIEME OVERLAY
			objectives = new FlxSprite(FlxG.width - 2*offsetx, 0);
			objectives.makeGraphic(graphicx, graphicy, 0xaa4E4F4D, true);
			components.add(objectives);
			
			// SCORE
			score = new FlxText(FlxG.width - 2 * offsetx, 0, graphicy, "Score :");
			score.x += score.frameWidth /2;
			score.y += score.frameHeight;
			score.setFormat(null, 14, 0xADAEAC);
			components.add(score);
			
			// OBJECTIF ENFANTS
			obje = new FlxText(FlxG.width - 2 * offsetx, score.frameHeight, graphicy, "");
			obje.x += obje.frameWidth /2;
			obje.y += obje.frameHeight;
			obje.setFormat(null, 14, 0xADAEAC);
			components.add(obje);
			// OBJECTIF SHOPS
			objs = new FlxText(FlxG.width - 2 * offsetx, 2*score.frameHeight, graphicy, "");
			objs.x += objs.frameWidth /2;
			objs.y += objs.frameHeight;
			objs.setFormat(null, 14, 0xADAEAC);
			components.add(objs);
			// OBJECTIF TIME
			objt = new FlxText(FlxG.width - 2 * offsetx, 3*score.frameHeight, graphicy, "");
			objt.x += objt.frameWidth /2;
			objt.y += objt.frameHeight;
			objt.setFormat(null, 14, 0xADAEAC);
			components.add(objt);
			
			// NAME
			name = new FlxText(offsetx, 0, graphicy, "Nom :");
			name.y += name.frameHeight;
			name.setFormat(null, 14, 0xADAEAC);
			components.add(name);
			
			// RATING
			rating = new FlxText(offsetx + graphicx, graphicy - name.frameHeight, graphicy, "");
			rating.y -= rating.frameHeight;
			rating.x -= rating.frameWidth / 2;
			rating.setFormat(null, 14, 0xADAEAC);
			components.add(rating);
		}
		
		override public function update():void {
			/*for (var i:int = 0; i < level.player.lives; i++) {
				var life:FlxSprite = new FlxSprite(offsetx, graphicy - name.frameHeight, ImgLife);
				life.x += i * life.frameWidth;
				life.y -= life.frameHeight;
				components.add(life);
			}*/
			score.text = "Score : " + level.score;
			name.text = level.name;
			rating.text = level.rating;
			obje.text = ""+level.map.childs;
			objs.text = ""+level.map.shops;
			objt.text = "" + level.map.time;			
		}
	}

}