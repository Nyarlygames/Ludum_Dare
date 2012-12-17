package  
{
	import flash.utils.Timer;
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	import org.flixel.FlxTimer;

	/**
	 * What appears on screen when rating goes up
	 * @author Jidehem1993
	 */
	public class RatingTransition extends FlxState
	{	
		[Embed(source = '../assets/IMAGES/MAIN/rTo12.png')] private var rTo12:Class;
		[Embed(source = '../assets/IMAGES/MAIN/rTo18.png')] private var rTo18:Class;
		private var background:FlxSprite;
		
		private var timer:FlxTimer;
		private var timerIsStarted:Boolean;
		
		public function RatingTransition(rating:uint)
		{ 
			if(rating == 1) {
				background = new FlxSprite(0, 0, rTo12);
			} else if (rating == 2) {
				background = new FlxSprite(0, 0, rTo18);
			}
 			background.scrollFactor.x = 0;
			background.scrollFactor.y = 0;
			add(background);
			
			timer = new FlxTimer();
			timerIsStarted = false;
			
			FlxG.camera.zoom = 6;
		}
		
		override public function update():void {
			if (FlxG.camera.zoom > 1) {
				FlxG.camera.zoom -= 0.2;
			} else {
				FlxG.camera.zoom = 1;
				if (!timerIsStarted) {
					timerIsStarted = true;
					timer.start(0.5);
				} else {
					if(timer.finished) {
						remove(background);
						Game.transiting = false;
					}
				}
			}
		}
	}

}