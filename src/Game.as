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
		private var pauseMenu:Pause;
		
		public static var transiting:Boolean;
		private var levelRating:uint;
		private var transition:RatingTransition;
		
		public function Game() 
		{
			FlxG.flashFramerate = 30;
			FlxG.framerate = 30;
			level = new Level(name, 0);
			add(level);
			paused = false;
			levelRating = level.ratid;
			transiting = false;
		}
		
		override public function update():void {
			// PAUSE
			if(FlxG.keys.justPressed("P") || (pauseMenu != null && FlxG.keys.justPressed("ENTER") && pauseMenu.current == 0)) {
				paused = !paused;
				if (paused) {
					pauseMenu = new Pause();
					add(pauseMenu);
					triggerPause(true);
				} else {
					remove(pauseMenu);
					pauseMenu = null;
					triggerPause(false);
				}
			}
			//Pause menu management
			if (pauseMenu != null && FlxG.keys.justPressed("ENTER")) {
				if (pauseMenu.current == 1) {
					FlxG.mute = !FlxG.mute;
				} else if (pauseMenu.current == 2) {
					FlxG.resetGame();
				}
			}
			if (paused) {
				return pauseMenu.update(); //update() finishes here if paused
			}
			
			
			//TRANSITION
			if (levelRating != level.ratid) {
				levelRating = level.ratid;
				transiting = true;
				transition = new RatingTransition(levelRating);
				add(transition);
			}
			if (transiting) {
				return transition.update(); //update() finishes here if transiting
			}
			
			//Actual update of this class
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
		
		private function triggerPause(off:Boolean):void {
			if(off) {
				if(level.playtime != null)level.playtime.paused = true;
				if(level.immunity != null)level.immunity.paused = true;
				for each (var build:Buildings in level.builds.members) {
					if(build.timer != null)build.timer.paused = true;
					if(build.timer_spawn != null)build.timer_spawn.paused = true;
					if(build.spawntimer != null)build.spawntimer.paused = true;
					if (build.spawntimeresrb != null) build.spawntimeresrb.paused = true;
					if (level.player.pw_speed_timer != null) level.player.pw_speed_timer.paused = true;
					if (level.totaltime != null)  level.totaltime.paused = true;
				}
			} else {
				if(level.playtime != null)level.playtime.start();
				if(level.immunity != null)level.immunity.start();
				for each (var build2:Buildings in level.builds.members) {
					if(build2.timer != null)build2.timer.start();
					if(build2.timer_spawn != null)build2.timer_spawn.start();
					if(build2.spawntimer != null)build2.spawntimer.start();
					if(build2.spawntimeresrb != null)build2.spawntimeresrb.start();
					if (level.player.pw_speed_timer != null) level.player.pw_speed_timer.start();
					if (level.totaltime != null) level.totaltime.start();
				}
			}
		}
	}

}