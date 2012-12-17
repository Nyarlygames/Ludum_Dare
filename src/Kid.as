package  
{
	import org.flixel.FlxPoint;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	/**
	 * KID
	 * @author ...
	 */
	public class Kid extends Character
	{
		
		[Embed(source = '../assets/gfx/kid.png')] public var ImgKid:Class;
		public var validated:Boolean = false;
		
		public function Kid(x:int, y:int) 
		{
			super(x, y, ImgKid);
		}
		
		
		public function behave(colls:Array):void {
			var minval:int = -1;
			var house:FlxPoint = null;
			
			for (var i:int = 0; i < colls.length; i ++) {
				if (FlxVelocity.distanceToPoint(this, colls[i]) < minval) {
					minval = FlxVelocity.distanceToPoint(this, colls[i]);
					house = colls[i];
				}
				trace(minval);
				//if ((minval > -1) && (house != null))
					
			}
			
		}
	}

}