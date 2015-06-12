package components
{
	import flash.events.Event;
	
	import utils.HudButtons;

	
	/**
	 * ...
	 * @author ...
	 */
	public class Objetivo extends QuizSimples 
	{
		public var btContinuar:HudButtons;
		
		public function Objetivo():void
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
			
			this.initBt(this.btContinuar);
		}
		
	}

}