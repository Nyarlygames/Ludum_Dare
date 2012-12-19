package  
{
	import org.flixel.FlxG;
	import org.flixel.FlxState;
	import org.flixel.FlxSprite;
	
	/**
	 * Pause menu
	 * @author Jidehem1993
	 */
	public class Pause extends FlxState
	{
		[Embed(source = '../assets/IMAGES/PAUSE/bg.png')] public var bgPause:Class;
		private var background:FlxSprite;
		
		[Embed(source = '../assets/IMAGES/PAUSE/resumeU.png')] private var resumeU:Class;
		[Embed(source = '../assets/IMAGES/PAUSE/resumeS.png')] private var resumeS:Class;
		private var resume:FlxSprite;
		
		[Embed(source = '../assets/IMAGES/PAUSE/muteU.png')] private var muteU:Class;
		[Embed(source = '../assets/IMAGES/PAUSE/muteS.png')] private var muteS:Class;
		private var mute:FlxSprite;
		
		[Embed(source = '../assets/IMAGES/PAUSE/quitU.png')] private var quitU:Class;
		[Embed(source = '../assets/IMAGES/PAUSE/quitS.png')] private var quitS:Class;
		private var quit:FlxSprite;
		
		private var spacing:uint = 80;
		public var current:uint;
		private var totalOptions:uint = 3;
		
		public function Pause()
		{
			FlxG.width = 1024;
			FlxG.height = 768;
			background = new FlxSprite(0, 0, bgPause);
			background.scrollFactor.x = 0;
			background.scrollFactor.y = 0;
			background.x = (FlxG.width - background.width) / 2;
			background.y = (FlxG.height - background.height) / 2;
			add(background);
			
			resume = new FlxSprite(0, 0, resumeS);
			resume.scrollFactor.x = 0;
			resume.scrollFactor.y = 0;
			resume.x = (FlxG.width - resume.width) / 2;
			resume.y = FlxG.height / 2 - resume.height;
			add(resume);
			
			mute = new FlxSprite(0, 0, muteU);
			mute.scrollFactor.x = 0;
			mute.scrollFactor.y = 0;
			mute.x = (FlxG.width - mute.width) / 2;
			mute.y = resume.y + spacing;
			add(mute);
			
			quit = new FlxSprite(0, 0, quitU);
			quit.scrollFactor.x = 0;
			quit.scrollFactor.y = 0;
			quit.x = (FlxG.width - quit.width) / 2;
			quit.y = mute.y + spacing;
			add(quit);
			
			current = 0;
		}
		
		override public function update():void {
			var modified:Boolean = false;
			// HAUT
			if (FlxG.keys.justPressed("UP") || FlxG.keys.justPressed("W")) {
				if (current > 0) current--;
				else current = totalOptions - 1;
				modified = true;
			}
			// BAS
			if (FlxG.keys.justPressed("DOWN") || FlxG.keys.justPressed("Z")) {
				if (current < totalOptions - 1) current++;
				else current = 0;
				modified = true;
			}
			
			if(modified) {
				switch(current) {
					case 0:
						resume.loadGraphic(resumeS);
						mute.loadGraphic(muteU);
						quit.loadGraphic(quitU);
						break;
					case 1:
						resume.loadGraphic(resumeU);
						mute.loadGraphic(muteS);
						quit.loadGraphic(quitU);
						break;
					case 2:
						resume.loadGraphic(resumeU);
						mute.loadGraphic(muteU);
						quit.loadGraphic(quitS);
						break;
					default:
				}
				resume.x = (FlxG.width - resume.width) / 2;
				resume.y = FlxG.height / 2 - resume.height;
				mute.x = (FlxG.width - mute.width) / 2;
				mute.y = resume.y + spacing;
				quit.x = (FlxG.width - quit.width) / 2;
				quit.y = mute.y + spacing;
			}
		}
	}

}