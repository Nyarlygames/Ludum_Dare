package  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	import org.flixel.plugin.photonstorm.FlxCollision;
	import org.flixel.FlxTimer;
	import org.flixel.FlxG;
	import org.flixel.FlxSound;
	
	/**
	 * Bâtiments
	 * @author ...
	 */
	public class Buildings extends FlxSprite
	{
		[Embed(source="../assets/SOUNDS/SHOP/POP_POWERUP.mp3")] public  var POP:Class;
		[Embed(source="../assets/SOUNDS/SHOP/GETTING_BUILDING.mp3")] public  var GETTING:Class;
		[Embed(source="../assets/SOUNDS/SHOP/GOT_BUILDING.mp3")] public  var GOT:Class;
		private var imgs:ImgRegistry = new ImgRegistry();
		public var timer:FlxTimer = new FlxTimer();
		public var timer_spawn:FlxTimer = new FlxTimer();
		public var time:int = 2;
		private var team:Boolean = false;
		public var take:FlxSprite = null;
		public var taken:Boolean = false;
		public var loot:SpawnObjet;
		public var id:int = 1;
		private var spawntime:int = 7;
		public var label:String = "";
		public var validated:Boolean = false;
		public var lootable:Boolean = false;
		public var hitbox:FlxSprite = null;
		public var spawnkid:int = 10;
		public var spawnesrb:int = 10;
		public var bspawnkid:Boolean = false;
		public var bspawnesrb:Boolean = false;
		public var spawntimer:FlxTimer = new FlxTimer();
		public var spawntimeresrb:FlxTimer = new FlxTimer();
		public var spawntype:int = 0;
		public var rating:Array = null;
		public var ratid:int = 0;
		public var sfx_got:FlxSound = new FlxSound();
		public var sfx_getting:FlxSound = new FlxSound();
		public var sfx_pop:FlxSound = new FlxSound();
		
		public function Buildings(x:int, y:int, index:int, lab:String, truth:Boolean, spawn:int) 
		{
			super(x, y);
			if (lab == "Fontaine") {
				loadGraphic(imgs.assets[index], true, false, 352, 224);
				addAnimation("fontaine", [0, 1, 2, 3, 4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25], 26, true);
				play("fontaine");
			}
			else
				loadGraphic(imgs.assets[index]);
			if (truth) {
				var offsety:int = 20;
				hitbox = new FlxSprite(x, y + frameHeight + offsety);
				if (lab == "Jeu")
					hitbox.loadGraphic(imgs.assets[index +2], true, false, 384, 64);
				else if (lab == "Hopital")
					hitbox.loadGraphic(imgs.assets[index +2], true, false, 320, 64);
				hitbox.addAnimation("animhb", [0, 1, 2, 3, 4, 5, 6], 15, true);
				hitbox.play("animhb");
				hitbox.immovable = true;
				spawntype = spawn;
			}
			label = lab;
			immovable = true;
			lootable = truth;
			id = index;
			sfx_getting.loadEmbedded(GETTING, true, true);
			sfx_got.loadEmbedded(GOT, false, true);
			sfx_pop.loadEmbedded(POP, false, true);
		}
		
		override public function update():void {
			super.update();
			if ((timer != null) && (timer.finished) && (take != null)) {
				sfx_getting.stop();
				sfx_got.play();
				team = !team;
				if (team)
					loadGraphic(imgs.assets[id+1]);
				else
					loadGraphic(imgs.assets[id]);
				timer = null;
				taken = true;
				spawnobj();
				timer_spawn.start(spawntime);
			}
			if ((taken == true) && (timer_spawn.finished)) {
				if ((loot != null) && (loot.exists == false) && (lootable == true)) 
					spawnobj();
				timer_spawn.start(spawntime);
			}
		}
		
		public function spawnobj():void {
			loot = new SpawnObjet(x + frameWidth / 2, y + frameHeight, label, id, spawntype);
			sfx_pop.play();
			FlxG.state.add(loot);
		}
		
		public function updateRating(lvl:Level):void {
			var esrbr:int = 0;
			var kidr:int = 0;
			
			if ((label == "Ecole") && (rating != null)) {
				if (lvl.kids.length > kidr)
					this.spawnkid = rating[ratid][5];
				else
					this.spawnkid = rating[ratid][4];
			}
			else if ((label == "Centre") && (rating != null)) {
				if (lvl.esrbs.length > esrbr)
					this.spawnesrb = rating[ratid][5];
				else
					this.spawnesrb = rating[ratid][4];
			}
		}
		
		public function getTakeCoord(x:int):Array {
			return [Math.round((this.y + this.frameHeight) / Constants.TILESIZE),Math.round(this.x/ Constants.TILESIZE),Math.round(x/ Constants.TILESIZE)];
		}
	}

}