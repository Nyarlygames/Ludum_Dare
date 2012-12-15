package
{
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import flash.system.System;
	
	/**
	 * Game
	 * @author ...
	 */
	public class Game extends FlxState
	{
		private var state:int = 1;
		private var onstate:Boolean = true;
		private var level:Level;
		
		public function Game() 
		{
			level = new Level();
			add(level);
		}
		
		override public function update():void {
			
			super.update();
			if ((state == 1) && (onstate == false)) {
				
				state = 2;
				onstate = true;
			}
			
			// ESCAPE
			if (FlxG.keys.pressed("ESCAPE")) {
				System.exit(0);
			}
		}
	}

}