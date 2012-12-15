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
		private var name:String = "Bertrand";
		
		public function Game() 
		{
			level = new Level(name, "18+");
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