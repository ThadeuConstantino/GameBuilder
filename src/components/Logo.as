package components
{
	import com.greensock.TweenNano;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import events.MainEvent;
	
	import model.Global;
	
	public class Logo extends MovieClip
	{
		public var logo:MovieClip;
		
		public function Logo()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			
			TweenNano.to(this.logo, 1, {delay:1, alpha:0, onComplete:tweenComplete});
		}
		
		private function tweenComplete()
		{
			Global.noLinkage.loadingFiles.dispatchEvent(new MainEvent(MainEvent.REMOVE_COMPONENT, "Menu", "Logo"));
		}
	}
}