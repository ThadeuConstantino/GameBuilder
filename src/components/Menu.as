package components
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import events.MainEvent;
	
	import model.Global;
	
	import utils.HudButtons;
	
	public class Menu extends MovieClip
	{
		public var bt:HudButtons;
		
		public function Menu()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.bt.enabledBt(true);
			this.bt.addEventListener(MouseEvent.MOUSE_DOWN, handleDownBt);
			
		}
		
		private function handleDownBt(e:MouseEvent)
		{
			this.bt.enabledBt(false);
			this.bt.removeEventListener(MouseEvent.MOUSE_DOWN, handleDownBt);
			this.tweenComplete();
		}
		
		private function tweenComplete()
		{
			if(Global.noLinkage)Global.noLinkage.loadingFiles.dispatchEvent(new MainEvent(MainEvent.REMOVE_COMPONENT, "Assistente", "Menu"));
		}
	}
}