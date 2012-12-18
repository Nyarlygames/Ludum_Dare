package
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import flash.display.MovieClip;
	import flash.media.SoundMixer;
	import flash.events.Event;
	
	/**
	 * Intro Movie
	 * @author Jidehem1993
	 */
	public class Intro extends FlxState
	{
		[Embed(source = '../assets/ANIMATIONS/introMovie.swf')] private var SwfClass:Class;
		private var movie:MovieClip;
		//This is the length of the cutscene in frames
		private var frameLength:int;
		
		override public function create():void
		{
			movie = new SwfClass();
			
			FlxG.stage.frameRate = 5;
			FlxG.stage.addChild(movie);
			
			frameLength = 100;
			//Adds a listener to the cutscene to call next() after each frame.
			movie.addEventListener(Event.EXIT_FRAME, next);
		}
		
		private function next(e:Event):void
		{
			frameLength--;
			if (frameLength <= 0)
			{
				movie.removeEventListener(Event.EXIT_FRAME, next);
				SoundMixer.stopAll();
				FlxG.stage.removeChild(movie);
				//Enter the next FlxState to switch to
				FlxG.switchState(new Menu());
			}			
		}
		
		override public function update():void {
			if (FlxG.keys.justReleased("ENTER") || FlxG.keys.justReleased("SPACE") || FlxG.keys.justReleased("ESCAPE")) {
				frameLength	= 0;
			}
		}
	} 
}