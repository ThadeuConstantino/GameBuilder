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
	public class Desafios extends MovieClip 
	{
		public var btContinuar:HudButtons;
		public var mcSlider:Slider;
		
		private var mtxResposta = [[6],[6,8],[8,3],[8,3,1,5],[1,2,3,4,5,7,8]];
		
		public function Desafios():void
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
			this.mcSlider.init(["Muito Fácil","Fácil","Moderado","Difícil","Muito Difícil"]);
		}
		
		private function numSelectSlide(e:SliderEvent)
		{
			var resp:Array = mtxResposta[e.idNum];
				
			for(var i:int=1; this.getChildByName("bt"+i); i++)
			{
				var bt:MovieClip = this.getChildByName("bt"+i) as MovieClip;
				bt.gotoAndStop(1);
				
				if(resp.indexOf(i) != -1) bt.gotoAndStop(2);
			}
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