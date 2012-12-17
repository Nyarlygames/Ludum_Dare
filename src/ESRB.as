package  
{	
	/**
	 * ESRB
	 * @author ...
	 */
	public class ESRB extends Character 
	{
		[Embed(source = '../assets/ANIMATIONS/ENNEMIS/anim_esrb.png')] public var ImgESRB:Class;
		public var lastdir:uint = 8;
		public var nbanim:int = 1;
		
		public function ESRB(x:int, y:int, img:Class) 
		{
			super(x, y, null);
			loadGraphic(ImgESRB, true, false, 64, 64);
			addAnimation("walkg", [0, 1, 2, 3, 4], 10, true);
			addAnimation("walkbg", [0, 1, 2, 3, 4], 10, true);
			addAnimation("walkb", [0, 1, 2, 3, 4], 10, true);
			nbanim += 5;
			addAnimation("walkd", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			addAnimation("walkbd", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			nbanim+= 5;
			addAnimation("walkhd", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			addAnimation("walkh", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			nbanim += 5;
			addAnimation("walkhg", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			nbanim += 5;
			addAnimation("attack_hd", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			nbanim += 5;
			addAnimation("attack_hg", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			nbanim += 5;
			addAnimation("attack_bg", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			nbanim += 5;
			addAnimation("attack_bg", [nbanim + 0, nbanim + 1, nbanim + 2, nbanim + 3, nbanim + 4], 20, true);
			health = 100;
			attack = 20;
			speed = 8;
		}
		
		override public function update():void {
			if (lastdir != dir) {
				switch(dir) {
					case 0:
						play("walkhg");
						break;
					case 1:
						play("walkh");
						break;
					case 2:
						play("walkhd");
						break;
					case 3:
						play("walkg");
						break;
					case 4:
						play("walkd");
						break;
					case 5:
						play("walkbg");
						break;
					case 6:
						play("walkb");
						break;
					case 7:
						play("walkbd");
						break;
					default:
						break;
				}
			}
			lastdir= dir;
		}
		
	}

}