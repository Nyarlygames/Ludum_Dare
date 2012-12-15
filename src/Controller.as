package 
{
	import flash.events.Event;
	
	/**
	 * Pathfinders
	 * @author Jidehem1993
	 */
	public class Controller
	{
		private const squareWidth:uint = 50;
		private const squareHeight:uint = 50;
		private const mazeWidth:uint = 5;
		private const mazeHeight:uint = 5;
		
		private var player:Sprite;
		private var enemy:Sprite;
		
		private var mazeArray:Array = new Array(
			[0, 0, 0, 0, 0],
			[0, 0, 0, 0, 0],
			[0, 0, 1, 0, 0],
			[0, 3, 1, 2, 0],
			[0, 0, 0, 0, 0]
		);
		
		public function Controller():void 
		{
			
		}
		
		/*
		 * Finds a value in a "two-dimensional" array
		 */
		private function findIndexInArray(value:Object,array:Array):Array {
			var occurences:Array = new Array();
			
			for (var i:uint = 0 ; i < mazeWidth ; i++) {
				for (var j:uint = 0 ; j < mazeHeight ; j++) {
					if (array[j][i] == value) {
						occurences.push(j,i);
					}
				}
			}
			return occurences;
		}
		
		
		
		/*
		 * Display tiles following the maze map
		 */
		private function createMaze():void {
			for (var i:uint = 0 ; i < mazeWidth ; i++) {
				for (var j:uint = 0 ; j < mazeHeight ; j++) {
					switch(mazeArray[j][i]) {
						case 0://Space
							var space:Sprite = new Sprite();
							space.graphics.beginFill(0x0000FF);
							space.graphics.drawRect(i * squareWidth, j * squareHeight, squareWidth, squareHeight);
							space.graphics.endFill();
							addChild(space);
							break;
						case 1://Block
							var block:Sprite = new Sprite();
							block.graphics.beginFill(0xCCCCCC);
							block.graphics.drawRect(i * squareWidth, j * squareHeight, squareWidth, squareHeight);
							block.graphics.endFill();
							addChild(block);
							break;
						case 2://Player
							player = new Sprite();
							player.graphics.beginFill(0x00FF00);
							player.graphics.drawCircle((i + 1 / 2) * squareWidth, (j + 1 / 2) * squareHeight, squareWidth / 2);
							addChild(player);
							break;
						case 3://Enemy
							enemy = new Sprite();
							enemy.graphics.beginFill(0xFF0000);
							enemy.graphics.drawCircle((i + 1 / 2) * squareWidth, (j + 1 / 2) * squareHeight, squareWidth / 2);
							addChild(enemy);
							break;
					}
					
				}
			}
		}
		
		/*
		 * Determines the distance between the player and every other square
		 * Returns a two-dimensionnal array corresponding with the map
		 */
		private function distanceCalculator():Array {
			//Create an array with the dimensions of the map array
			var distanceArray:Array = new Array();
			
			//Fill array of distances with 0 on empty tiles and 999 on blocked tiles so that they won't be chosen as path
			for (var j:uint = 0 ; j < mazeHeight ; j++) {
				distanceArray[j] = [];
				for (var i:uint = 0 ; i < mazeWidth ; i++) {
					if(mazeArray[j][i] == 1) {
						distanceArray[j][i] = 999;
					} else {
						distanceArray[j][i] = 0;
					}
				}
			}
			
			var count:uint = 0;
			
			distanceArray[findIndexInArray(2, mazeArray)[0]][findIndexInArray(2, mazeArray)[getSquare(player)]] = ++count;//Find hero
			
			while(findIndexInArray(0, distanceArray).length != 0) {
				var centerIndex:Array = findIndexInArray(count++, distanceArray);
				for (i = 0 ; i < centerIndex.length ; i += 2) {
					if(centerIndex[i] != null && centerIndex[i+1] != null) {
						//Fill the neighbors with the incrementing count gives the distance
						if(distanceArray[centerIndex[i] - 1] != null) {
							if (distanceArray[centerIndex[i] - 1][centerIndex[i+1] - 1] != null && distanceArray[centerIndex[i] - 1][centerIndex[i+1] - 1] == 0) {
								distanceArray[centerIndex[i] - 1][centerIndex[i+1] - 1] = count;
							}
							if (distanceArray[centerIndex[i] - 1][centerIndex[i+1]] != null && distanceArray[centerIndex[i] - 1][centerIndex[i+1]] == 0) {
								distanceArray[centerIndex[i] - 1][centerIndex[i+1]] = count;
							}
							if (distanceArray[centerIndex[i] - 1][centerIndex[i+1] + 1] != null && distanceArray[centerIndex[i] - 1][centerIndex[i+1] + 1] == 0) {
								distanceArray[centerIndex[i] - 1][centerIndex[i+1] + 1] = count;
							}
						}
						if(distanceArray[centerIndex[i]] != null) {
							if (distanceArray[centerIndex[i]][centerIndex[i+1] - 1] != null && distanceArray[centerIndex[i]][centerIndex[i+1] - 1] == 0) {
								distanceArray[centerIndex[i]][centerIndex[i+1] - 1] = count;
							}
							if (distanceArray[centerIndex[i]][centerIndex[i+1] + 1] != null && distanceArray[centerIndex[i]][centerIndex[i+1] + 1] == 0) {
								distanceArray[centerIndex[i]][centerIndex[i+1] + 1] = count;
							}
						}
						if(distanceArray[centerIndex[i] + 1] != null) {
							if (distanceArray[centerIndex[i] + 1][centerIndex[i+1] - 1] != null && distanceArray[centerIndex[i] + 1][centerIndex[i+1] - 1] == 0) {
								distanceArray[centerIndex[i] + 1][centerIndex[i+1] - 1] = count;
							}
							if (distanceArray[centerIndex[i] + 1][centerIndex[i+1]] != null && distanceArray[centerIndex[i] + 1][centerIndex[i+1]] == 0) {
								distanceArray[centerIndex[i] + 1][centerIndex[i+1]] = count;
							}
							if (distanceArray[centerIndex[i] + 1][centerIndex[i+1] + 1] != null && distanceArray[centerIndex[i] + 1][centerIndex[i+1] + 1] == 0) {
								distanceArray[centerIndex[i] + 1][centerIndex[i+1] + 1] = count;
							}
						}
					}
				}
			}
			return distanceArray;
		}
		
		/*
		 * Uses the distance array to guide ennemies toward player
		 */
		private function pathfinder(stalker:Object,distanceArray:Array):void {
			trace(stalker.y);
		}
	}
}