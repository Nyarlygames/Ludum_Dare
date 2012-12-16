package  
{
	import org.flixel.FlxSprite;
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
			if ((this.getSquare() != null) && (this.getSquare()[0] != null) && (this.getSquare()[1] != null)
				&& (array != null) && ((array[this.getSquare()[0] - 1]) != null) && (array[this.getSquare()[0] - 1][this.getSquare()[1] - 1])){
			var minVal:uint = array[this.getSquare()[0] - 1][this.getSquare()[1] - 1];
			var dir:uint = 0;
			if (array[this.getSquare()[0] - 1][this.getSquare()[1] + 1] <= minVal) {
				minVal = array[this.getSquare()[0] - 1][this.getSquare()[1] + 1];
				dir = 2;
			}
			if (array[this.getSquare()[0] + 1][this.getSquare()[1] - 1] <= minVal) {
				minVal = array[this.getSquare()[0] + 1][this.getSquare()[1] - 1];
				dir = 5;
			}
			if (array[this.getSquare()[0] + 1][this.getSquare()[1] + 1] <= minVal) {
				minVal = array[this.getSquare()[0] + 1][this.getSquare()[1] + 1];
				dir = 7;
			}
			if (array[this.getSquare()[0]][this.getSquare()[1] + 1] <= minVal) {
				minVal = array[this.getSquare()[0]][this.getSquare()[1] + 1];
				dir = 1;
			}
			if (array[this.getSquare()[0] - 1][this.getSquare()[1]] <= minVal) {
				minVal = array[this.getSquare()[0] - 1][this.getSquare()[1] - 1];
				dir = 3;
			}
			if (array[this.getSquare()[0]][this.getSquare()[1] - 1] <= minVal) {
				minVal = array[this.getSquare()[0]][this.getSquare()[1] - 1];
				dir = 6;
			}
			if (array[this.getSquare()[0] + 1][this.getSquare()[1]] <= minVal) {
				minVal = array[this.getSquare()[0] + 1][this.getSquare()[1]];
				dir = 4;
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
			}
		}
		}
	}

}