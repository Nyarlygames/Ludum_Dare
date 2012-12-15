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
		 * Uses the distance array to guide ennemies toward player
		 */
		private function pathfinder(stalker:Object,distanceArray:Array):void {
			trace(stalker.y);
		}
	}
}