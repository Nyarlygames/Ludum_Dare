package  
{
	import org.flixel.FlxSprite;
	import org.flixel.FlxG;  
	/**
	 * Mother class of every character class
	 * @author Jidehem1993
	 */
	public class Character extends FlxSprite 
	{
		public var Img:Class;
		
		public function Character(x:int, y:int, Img:Class) 
		{
			super(x, y, Img);
		}
		
		override public function update():void {
			
			if (x < 0)
				x = 0;
			if (x > FlxG.worldBounds.width - frameWidth)
				x = FlxG.worldBounds.width - frameWidth;
			if (y < 0)
				y = 0;
			if (y > FlxG.worldBounds.height - frameHeight)
				y = FlxG.worldBounds.height - frameHeight;
		}
		
		/*
		 * Find square of the object from its coordinates
		 */
		public function getSquare():Array {
			return [Math.round(this.y / Constants.TILESIZE),Math.round(this.x / Constants.TILESIZE)];
		}
		
		/*
		 * Find path w/ the array of distances
		 */
		public function findPath(array:Array):void {
			var minVal:uint = 1000;
			var dir:uint = 8;
			if (array[this.getSquare()[0] - 1] != null) {
				if (array[this.getSquare()[0] - 1][this.getSquare()[1] - 1] != null && array[this.getSquare()[0] - 1][this.getSquare()[1] - 1] < minVal) {
					minVal = array[this.getSquare()[0] - 1][this.getSquare()[1] - 1];
					dir = 0;
				}
				if (array[this.getSquare()[0] - 1][this.getSquare()[1]] != null && array[this.getSquare()[0] - 1][this.getSquare()[1]] < minVal) {
					minVal = array[this.getSquare()[0] - 1][this.getSquare()[1]];
					dir = 3;
				}
				if(array[this.getSquare()[0] - 1][this.getSquare()[1] + 1] != null && array[this.getSquare()[0] - 1][this.getSquare()[1] + 1] < minVal) {
					minVal = array[this.getSquare()[0] - 1][this.getSquare()[1] + 1];
					dir = 2;
				}
			}
			if (array[this.getSquare()[0]] != null) {
				if (array[this.getSquare()[0]][this.getSquare()[1] - 1] != null && array[this.getSquare()[0]][this.getSquare()[1] - 1] < minVal) {
					minVal = array[this.getSquare()[0]][this.getSquare()[1] - 1];
					dir = 6;
				}
				if(array[this.getSquare()[0]][this.getSquare()[1] + 1] != null && array[this.getSquare()[0]][this.getSquare()[1] + 1] < minVal) {
					minVal = array[this.getSquare()[0]][this.getSquare()[1] + 1];
					dir = 1;
				}
			}
			if (array[this.getSquare()[0] + 1] != null) {
				if (array[this.getSquare()[0] + 1][this.getSquare()[1] - 1] != null && array[this.getSquare()[0] + 1][this.getSquare()[1] - 1] < minVal) {
					minVal = array[this.getSquare()[0] + 1][this.getSquare()[1] - 1];
					dir = 5;
				}
				if (array[this.getSquare()[0] + 1][this.getSquare()[1]] != null && array[this.getSquare()[0] + 1][this.getSquare()[1]] < minVal) {
					minVal = array[this.getSquare()[0] + 1][this.getSquare()[1]];
					dir = 4;
				}
				if (array[this.getSquare()[0] + 1][this.getSquare()[1] + 1] != null && array[this.getSquare()[0] + 1][this.getSquare()[1] + 1] < minVal) {
					minVal = array[this.getSquare()[0] + 1][this.getSquare()[1] + 1];
					dir = 7;
				}
			}
			
			var speed:int = 1;
			
			switch(dir) {
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