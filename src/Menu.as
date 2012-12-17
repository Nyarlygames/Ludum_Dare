package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	import flash.system.System;
	import flash.display.Sprite;
	
	/**
	 * Main menu
	 * @author Jidehem1993
	 */
	public class Menu extends FlxState
	{
		[Embed(source = '../assets/IMAGES/MENU/bg.png')] public var bgPause:Class;
		private var background:FlxSprite;
		
		[Embed(source = '../assets/IMAGES/MENU/newGU.png')] private var newGU:Class;
		[Embed(source = '../assets/IMAGES/MENU/newGS.png')] private var newGS:Class;
		private var newG:FlxSprite;
		
		[Embed(source = '../assets/IMAGES/MENU/howU.png')] private var howU:Class;
		[Embed(source = '../assets/IMAGES/MENU/howS.png')] private var howS:Class;
		private var how:FlxSprite;
		
		private var spacing:uint = 80;
		public var current:uint;
		private var totalOptions:uint = 2;
		
		private var game:Game;
		
		override public function create():void
		{
			background = new FlxSprite(0, 0, bgPause);
			add(background);
			
			newG = new FlxSprite(0, 0, newGS);
			newG.x = (FlxG.width - newG.width) / 2;
			newG.y = FlxG.height / 2;
			add(newG);
			
			how = new FlxSprite(0, 0, howU);
			how.x = (FlxG.width - how.width) / 2;
			how.y = newG.y + spacing;
			add(how);
			
			current = 0;
		}
		
		override public function update():void {
			var modified:Boolean = false;
			// HAUT
			if (FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("W")) {
				if (current > 0) current--;
				else current = totalOptions - 1;
				modified = true;
			}
			// BAS
			if (FlxG.keys.justPressed("DOWN") || FlxG.keys.justPressed("Z")) {
				if (current < totalOptions - 1) current++;
				else current = 0;
				modified = true;
			}
			
			if(modified) {
				switch(current) {
					case 0:
						newG.loadGraphic(newGS);
						how.loadGraphic(howU);
						break;
					case 1:
						newG.loadGraphic(newGU);
						how.loadGraphic(howS);
				}
				newG.x = (FlxG.width - newG.width) / 2;
				newG.y = FlxG.height / 2;
				how.x = (FlxG.width - how.width) / 2;
				how.y = newG.y + spacing;
			}
			
			//VALIDATE
			if (FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE")) {
				switch(current) {
					case 0:
						game = new Game();
						FlxG.switchState(game);
						break;
					case 1:
						FlxG.switchState(new HowToPlay());
						break;
					default:
				}
			}
			super.update();
		}
	}

}