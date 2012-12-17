package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	import flash.system.System;
	import flash.display.Sprite;
	
	/**
	 * HTP menu
	 * @author Jidehem1993
	 */
	public class HowToPlay extends FlxState
	{
		private var pages:Array;
		[Embed(source = '../assets/IMAGES/TUTORIAL/hit.png')] public var n0:Class;
		[Embed(source = '../assets/IMAGES/TUTORIAL/kids.png')] public var n1:Class;
		[Embed(source = '../assets/IMAGES/TUTORIAL/buildings.png')] public var n2:Class;
		[Embed(source = '../assets/IMAGES/TUTORIAL/hospital.png')] public var n3:Class;
		[Embed(source = '../assets/IMAGES/TUTORIAL/games.png')] public var n4:Class;
		private var background:FlxSprite;
		
		public var current:uint;
		private var totalOptions:uint = 5;
		
		private var game:Game;
		
		public function HowToPlay():void
		{
			pages = new Array();
			
			pages.push(n0);
			pages.push(n1);
			pages.push(n2);
			pages.push(n3);
			pages.push(n4);
			
			current = 0;
			
			background = new FlxSprite(0, 0, pages[0]);
			add(background);
		}
		
		override public function update():void {
			var modified:Boolean = false;
			
			//GO RIGHT
			if (FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("SPACE") || FlxG.keys.justPressed("RIGHT")) {
				if (current == totalOptions - 1) {
					game = new Game();
					FlxG.switchState(game);
				} else {
					current++;
					modified = true;
				}
			}
			
			//GO LEFT
			if (FlxG.keys.justPressed("LEFT")) {
				if (current != 0) {
					 current--;
					 modified = true;
				}
			}
			
			if(modified) {
				background.loadGraphic(pages[current]);
			}
			
			//ESCAPE
			if (FlxG.keys.justPressed("ESCAPE")) {
				FlxG.resetGame();
			}
			
			super.update();
		}
	}

}