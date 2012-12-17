package
{
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	import org.flixel.FlxGroup;
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
		private var name:String = "";
		public static var paused:Boolean;
		public var pauseMenu:FlxGroup;
		
		public function Game() 
		{
			level = new Level(name, "18+");
			add(level);
			paused = false;
			pauseMenu = new FlxGroup();
		}
		
		override public function update():void {
			// PAUSE
			if(FlxG.keys.justPressed("P")) {
				paused = !paused;
				if (paused) {
					if(level.playtime != null)level.playtime.paused = true;
					if(level.immunity != null)level.immunity.paused = true;
					for each (var build:Buildings in level.builds.members) {
						build.timer.paused = true;
						build.timer_spawn.paused = true;
						build.spawntimer.paused = true;
						build.spawntimeresrb.paused = true;
					}
				} else {
					if(level.playtime != null)level.playtime.start();
					if(level.immunity != null)level.immunity.start();
					for each (var build2:Buildings in level.builds.members) {
						build2.timer.start();
						build2.timer_spawn.start();
						build2.spawntimer.start();
						build2.spawntimeresrb.start();
					}
				}
			}
			if (paused) {
				return pauseMenu.update(); //update() finishes here if paused
			}
			super.update();
			if ((state == 1) && (onstate == false)) {
				
				state = 2;
				onstate = true;
			}
			
			// ESCAPE
			if (FlxG.keys.justPressed("ESCAPE")) {
				System.exit(0);
			}
		}
	}

}