package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	import org.flixel.FlxTimer;
	import org.flixel.plugin.photonstorm.FlxVelocity;
	/**
	 * KID
	 * @author ...
	 */
	public class Kid extends Character
	{
		
		[Embed(source = '../assets/gfx/kid.png')] public var ImgKid:Class;
		public var validated:Boolean = false;
		public var moving:FlxTimer = new FlxTimer();
		private var speed:int = 2;
		public var rand:int = -1;
		
		public function Kid(x:int, y:int) 
		{
			super(x, y, ImgKid);
			moving.start(1);
		}
		
		
		public function behave(array:Array):void {
			
			var minVal:uint = 999;
			var dir:int = 8;
			var dirs:Array = new Array();
			if ((rand == -1) || (moving.finished) || (array[this.getSquare()[0]][this.getSquare()[1]] == 999)) {
				if (array[this.getSquare()[0]][this.getSquare()[1]])
				moving.start(1);
				if (array[this.getSquare()[0] - 1] != null) {
					if (array[this.getSquare()[0] - 1][this.getSquare()[1] - 1] != null && array[this.getSquare()[0] - 1][this.getSquare()[1] - 1] != minVal) {
						dir = 0;
						dirs.push(dir);
					}
					if (array[this.getSquare()[0] - 1][this.getSquare()[1]] != null && array[this.getSquare()[0] - 1][this.getSquare()[1]] != minVal) {
						dir = 3;
						dirs.push(dir);
					}
					if(array[this.getSquare()[0] - 1][this.getSquare()[1] + 1] != null && array[this.getSquare()[0] - 1][this.getSquare()[1] + 1] != minVal) {
						dir = 2;
						dirs.push(dir);
					}
				}
				if (array[this.getSquare()[0]] != null) {
					if (array[this.getSquare()[0]][this.getSquare()[1] - 1] != null && array[this.getSquare()[0]][this.getSquare()[1] - 1] != minVal) {
						dir = 6;
						dirs.push(dir);
					}
					if (array[this.getSquare()[0]][this.getSquare()[1] + 1] != null && array[this.getSquare()[0]][this.getSquare()[1] + 1] != minVal) {
						dir = 1;
						dirs.push(dir);
					}
				}
				if (array[this.getSquare()[0] + 1] != null) {
					if (array[this.getSquare()[0] + 1][this.getSquare()[1] - 1] != null && array[this.getSquare()[0] + 1][this.getSquare()[1] - 1] != minVal) {
						dir = 5;
						dirs.push(dir);
					}
					if (array[this.getSquare()[0] + 1][this.getSquare()[1]] != null && array[this.getSquare()[0] + 1][this.getSquare()[1]] != minVal) {
						dir = 4;
						dirs.push(dir);
					}
					if (array[this.getSquare()[0] + 1][this.getSquare()[1] + 1] != null && array[this.getSquare()[0] + 1][this.getSquare()[1] + 1] != minVal) {
						dir = 7;
						dirs.push(dir);
					}
				}
			if (dir != 8)
				rand = dirs[Math.floor(Math.random() * (dirs.length -1))];
			}
			switch(rand) {
				case 0:
					this.x -= speed;
					this.y -= speed;
					break;
				case 1:
					this.y -= speed;
					break;
				case 2:
					this.x += speed;
					this.y -= speed;
					break;
				case 3:
					this.x -= speed;
					break;
				case 4:
					this.x += speed;
					break;
				case 5:
					this.x -= speed;
					this.y += speed;
					break;
				case 6:
					this.y += speed;
					break;
				case 7:
					this.x += speed;
					this.y += speed;
					break;
				default:
					this.x -= speed;
					this.y -= speed;
				}
		}
	}

}