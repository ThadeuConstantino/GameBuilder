package components
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import events.AssistenteEvent;
	
	import utils.HudButtons;

	
	/**
	 * ...
	 * @author ...
	 */
	public class Perfil extends MovieClip 
	{
		public var btContinuar:HudButtons;
		
		public function Perfil():void
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