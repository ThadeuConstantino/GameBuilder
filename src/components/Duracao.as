package components
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import events.AssistenteEvent;
	import events.SliderEvent;
	
	import utils.HudButtons;
	import utils.Slider;

	
	/**
	 * ...
	 * @author ...
	 */
	public class Duracao extends MovieClip 
	{
		public var btContinuar:HudButtons;
		public var mcSlider:Slider;
		
		public function Duracao():void
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
			
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.btContinuar.enabledBt(true);
			this.btContinuar.addEventListener(MouseEvent.MOUSE_UP, handleUpContinuar);
			
			this.mcSlider.addEventListener(SliderEvent.NUM_SELECT_SLIDE, numSelectSlide);
			
			this.mcSlider.mcBarBg.width = 1014;
			this.mcSlider.init(["5","10","15","20","25","30","35","40","45","50","55","60","65","70","75","80","85","90"],"Number");
		}
		
		private function numSelectSlide(e:SliderEvent)
		{
			
		}
		
		private function handleUpContinuar(e:MouseEvent)
		{
			this.btContinuar.enabledBt(false);
			this.btContinuar.removeEventListener(MouseEvent.MOUSE_UP, handleUpContinuar);
			
			//Timeline Assistentes
			this.dispatchEvent(new AssistenteEvent(AssistenteEvent.AVANCA_TIMELINE_ASS));
		}
		
	}

}