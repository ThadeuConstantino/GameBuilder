package components
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import events.AssistenteEvent;
	
	import utils.HudButtons;
	
	public class QuizSimples extends MovieClip
	{
		private var btContinuar:HudButtons;
		
		public function initBt(btC:HudButtons):void 
		{
			this.btContinuar = btC;
			
			this.btContinuar.visible = false;
			this.btContinuar.enabledBt(true);
			this.btContinuar.addEventListener(MouseEvent.MOUSE_UP, handleUpContinuar);
			
			this.clickBotão();
		}
		
		public function clickBotão():void
		{
			for(var i:int = 1; this.getChildByName("bt"+i); i++)
			{
				var bt:MovieClip = this.getChildByName("bt"+i) as MovieClip;
				bt.id = i;
				bt.buttonMode = true;
				bt.gotoAndStop(1);
				if(!bt.hasEventListener(MouseEvent.MOUSE_OVER)) bt.addEventListener(MouseEvent.MOUSE_OVER, handleOverBt);
				if(!bt.hasEventListener(MouseEvent.MOUSE_OUT)) bt.addEventListener(MouseEvent.MOUSE_OUT, handleOutBt);
				if(!bt.hasEventListener(MouseEvent.MOUSE_DOWN)) bt.addEventListener(MouseEvent.MOUSE_DOWN, handleDownBt);
			}
		}
		public function handleOverBt(e:MouseEvent)
		{
			e.currentTarget.gotoAndStop(2);
		}
		public function handleOutBt(e:MouseEvent)
		{
			e.currentTarget.gotoAndStop(1);
		}
		public function handleDownBt(e:MouseEvent)
		{
			this.clickBotão();
			this.btContinuar.visible = true;
		
			e.currentTarget.buttonMode = false;
			e.currentTarget.gotoAndStop(3);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_OVER, handleOverBt);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_OUT, handleOutBt);
			e.currentTarget.removeEventListener(MouseEvent.MOUSE_DOWN, handleDownBt);
		}
		
		public function handleUpContinuar(e:MouseEvent)
		{
			this.btContinuar.enabledBt(false);
			this.btContinuar.removeEventListener(MouseEvent.MOUSE_UP, handleUpContinuar);
			
			//Timeline Assistentes
			this.dispatchEvent(new AssistenteEvent(AssistenteEvent.AVANCA_TIMELINE_ASS));
		}
	}
}