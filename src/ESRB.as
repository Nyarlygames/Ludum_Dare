package  
{	
	/**
	 * ESRB
	 * @author ...
	 */
	public class ESRB extends Character 
	{
		
		[Embed(source = '../assets/gfx/esrb.png')] public var ImgESRB:Class;
		[Embed(source = '../assets/gfx/SRB_GB.png')] public var ImgESRBGB:Class;
		[Embed(source = '../assets/gfx/SRB_GH.png')] public var ImgESRBGH:Class;
		[Embed(source = '../assets/gfx/SRB_DB.png')] public var ImgESRBDB:Class;
		[Embed(source = '../assets/gfx/SRB_DH.png')] public var ImgESRBDH:Class;
		[Embed(source = '../assets/gfx/SRB_G_at.png')] public var ImgESRBGAT:Class;
		[Embed(source = '../assets/gfx/SRB_D_at.png')] public var ImgESRBDAT:Class;
		public function ESRB(x:int, y:int) 
		{
			super(x, y, ImgESRB);
		}
		
		override public function update():void {
			switch(dir) {
				//HAUT
				case 0:
					loadGraphic(ImgESRBGH, true, false, 64, 64);
					addAnimation("walkhg", [0, 1, 2, 3, 4], 5, false);
					play("walkhg");
				break;
				case 1:
					loadGraphic(ImgESRBDH, true, false, 64, 64);
					addAnimation("walkh", [0, 1, 2, 3, 4], 5, false);
					play("walkh");
				break;
				case 2:
					loadGraphic(ImgESRBDH, true, false, 64, 64);
					addAnimation("walkhd", [0, 1, 2, 3, 4], 5, false);
					play("walkhd");
				break;
				
				// G/D
				case 3:
					loadGraphic(ImgESRBGB, true, false, 64, 64);
					addAnimation("walkg", [0, 1, 2, 3, 4], 5, false);
					play("walkg");
				break;
				case 4:
					loadGraphic(ImgESRBDB, true, false, 64, 64);
					addAnimation("walkd", [0, 1, 2, 3, 4], 5, false);
					play("walkd");
				break;
				
				// BAS
				case 5:
					loadGraphic(ImgESRBGB, true, false, 64, 64);
					addAnimation("walkbg", [0, 1, 2, 3, 4], 5, false);
					play("walkbg");
				break;
				case 6:
					loadGraphic(ImgESRBGB, true, false, 64, 64);
					addAnimation("walkb", [0, 1, 2, 3, 4], 5, false);
					play("walkb");
				break;
				case 7:
					loadGraphic(ImgESRBDB, true, false, 64, 64);
					addAnimation("walkbd", [0, 1, 2, 3, 4], 5,false);
					play("walkbd");
				break;
				default:
					trace("ERREUR");
			}

		}
		
	}

}