package  
{
	import org.flixel.FlxGroup;
	/**
	 * Maps
	 * @author ...
	 */
	public class Map 
	{
		
		public var esrbs:FlxGroup = new FlxGroup();
		public var kids:FlxGroup = new FlxGroup();
		public var builds:FlxGroup = new FlxGroup();
		public var maxScore:int = 0;
		public var id:int = 0;
		public var childs:int = 0;
		public var shops:int = 0;
		public var time:int = 0;
		public var bg:String = new String("");
		
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
			var fileContent:String = new map();
			var lignes:Array = fileContent.split('\n');
			var en:Array;
			if (lignes != null) {
				id = lignes[0];
				maxScore = lignes[1];
				bg = lignes[2];
			}
			for (var i:int = 3;  i < lignes.length; i++) {
				if (lignes[i] != null)
					en = lignes[i].split('/');
					if (en != null) {
						switch(en[0]){
							case "Obj":
								childs = en[1];
								shops = en[2];
								time = en[3];
							break;
							case "ESRB":
								esrbs.add(new ESRB(en[1], en[2]));
							break;
							case "Kid":
								kids.add(new Kid(en[1], en[2]));
							break;
							case "Hopital":
								builds.add(new Buildings(en[1], en[2], en[3], en[0], true));
							break;
							case "Jeu":
								builds.add(new Buildings(en[1], en[2], en[3], en[0], true));
							break;
							case "Ecole":
								builds.add(new Buildings(en[1], en[2], en[3], en[0], false));
							break;
							case "Centre":
								builds.add(new Buildings(en[1], en[2], en[3], en[0], false));
							break;
							case "Fontaine":
								builds.add(new Buildings(en[1], en[2], en[3], en[0], false));
							break;
							case "Maison":
								builds.add(new Buildings(en[1], en[2], en[3], en[0], false));
							break;
							default:
						}
					}
			}
		}
		
	}

}