package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxPoint;
	/**
	 * Maps
	 * @author ...
	 */
	public class Map 
	{
		
		public var esrbs:FlxGroup = new FlxGroup();
		public var kids:FlxGroup = new FlxGroup();
		public var builds:FlxGroup = new FlxGroup();
		public var colls:Array = new Array();
		public var maxScore:int = 0;
		public var id:int = 0;
		public var childs:int = 0;
		public var shops:int = 0;
		public var time:int = 0;
		public var bg:String = new String("");
		public var collisionsMap:Array = new Array();
		
		// Crée le groupe d'ennemis à partir d'un fichier
		
		/* FORMAT :
			 * ID STAGE
			 * MAXSCORE
			 * BG ID
			 * Mob/x/y
			 * Buildings/x/y/imgref
		 * */
		public function Map(map:Class) 
		{
			var build:Buildings;
			var k:uint = 0;
			var fileContent:String = new map();
			var lignes:Array = fileContent.split('\n');
			var en:Array;
			var y:int = 0;
			
			for (var i:uint = 0 ; i < Constants.NBTILESHEIGHT ; i++) {
				collisionsMap[i] = [];
				for (var j:uint = 0 ; j < Constants.NBTILESWIDTH ; j++) {
					collisionsMap[i][j] = 0;
				}
			}
			if (lignes != null) {
				id = lignes[0];
				maxScore = lignes[1];
				bg = lignes[2];
			}
			for (i = 3;  i < lignes.length; i++) {
				if (lignes[i] != null)
					en = lignes[i].split('/');
					if (en != null) {
						switch(en[0]) {
							case "Obj":
								childs = en[1];
								shops = en[2];
								time = en[3];
							break;
							case "ESRB":
								esrbs.add(new ESRB(en[1], en[2], null));
							break;
							case "Kid":
								kids.add(new Kid(en[1], en[2]));
							break;
							case "Hopital":
								build = new Buildings(en[1], en[2], 1, en[0], true, 0);
								builds.add(build);
								for (j = en[1] / Constants.TILESIZE ; j < (build.frameWidth / Constants.TILESIZE) + (en[1] / Constants.TILESIZE) ; j++) {
									for (k = en[2] / Constants.TILESIZE ; k < (build.frameHeight / Constants.TILESIZE) + (en[2] / Constants.TILESIZE) ; k++) {
										if ( (collisionsMap[k] != null) && (collisionsMap[k][j] != null))
										collisionsMap[k][j] = 1;
									}
								}
							break;
							case "Jeu":
								build = new Buildings(en[1], en[2], 5, en[0], true, en[3]);
								builds.add(build);
								for (j = en[1] / Constants.TILESIZE ; j < (build.frameWidth / Constants.TILESIZE) + (en[1] / Constants.TILESIZE) ; j++) {
									for (k = en[2] / Constants.TILESIZE ; k < (build.frameHeight / Constants.TILESIZE) + (en[2] / Constants.TILESIZE) ; k++) {
										if ( (collisionsMap[k] != null) && (collisionsMap[k][j] != null))
											collisionsMap[k][j] = 1;
									}
								}
							break;
							case "Checkpoints":
								y = i+1;
								i = lignes.length;
							break;
							default:
								build = new Buildings(en[1], en[2], en[3], en[0], false, 0);
								builds.add(build);
								for (j = en[1] / Constants.TILESIZE ; j < (build.frameWidth / Constants.TILESIZE) + (en[1] / Constants.TILESIZE) ; j++) {
									for (k = en[2] / Constants.TILESIZE ; k < ((build.frameHeight / Constants.TILESIZE) + (en[2] / Constants.TILESIZE)) ; k++) {
										if ( (collisionsMap[k] != null) && (collisionsMap[k][j] != null))
										collisionsMap[k][j] = 1;
									}
								}
						}
					}
			}
			for (y = y;  y < lignes.length; y++) {
				if (lignes[y] != null) {
					en = lignes[y].split('/');
					if (en != null) {
						colls.push(new FlxPoint(en[0], en[1]));
					}
				}
			}
		}
		
	}

}