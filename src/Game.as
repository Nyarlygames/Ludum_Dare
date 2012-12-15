package
{
	import flash.net.NetStreamPlayOptions;
	import org.flixel.FlxState;
	import org.flixel.FlxG;
	
	/**
	 * Game
	 * @author ...
	 */
	public class Game extends FlxState
	{
		public var state:int = 1;
		public var onstate:Boolean = true;
		
		public function Game() 
		{
			new Level();
		}
		
		override public function update():void {
			
			super.update();
			if ((state == 1) && (onstate == false)) {
				
				state = 2;
				onstate = true;
			}
		}
	}

}