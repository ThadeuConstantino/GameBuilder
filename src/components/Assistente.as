package components{
	import com.greensock.TweenNano;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import events.AssistenteEvent;
	import events.MainEvent;
	
	import model.Global;

	
	/**
	 * ...
	 * @author ...
	 */
	public class Assistente extends MovieClip 
	{
		private var ld:Loader;
		public var bgMarca:MovieClip;
		public var mcTopBar:MovieClip;
		
		public var mcHolder:MovieClip;
		public var loadingFiles:MovieClip;
		
		public var objSwf:*;
		
		//pattern Singleton
		private static var _instance:Assistente;
		public static function get instance():Assistente { return _instance };
		//
		
		public function Assistente() 
		{
			Global.noLinkage = this;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
			
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.addEventListener(AssistenteEvent.ADD_COMPONENT, addComponent);
			this.addEventListener(AssistenteEvent.REMOVE_COMPONENT, removeComponent);
		}
		
		//Faz a inserção de telas no simulador
		public function insertChildHolder(_ld:Loader):void
		{			
			this.addChild(_ld);
		}
		
		private function addComponent(event:MainEvent):void 
		{
			var ClassReference:Class = getDefinitionByName("Mc" + event.strUrlAdd) as Class;
			this.objSwf = new ClassReference();
			this.objSwf.alpha = 0;
			
			this.mcHolder.addChild(this.objSwf);

			TweenNano.to(this.objSwf, .5, { alpha:1 } );
		}	
		
		
		private function removeComponent(event:AssistenteEvent):void 
		{	
			if (event.strUrlAdd != "") {
				TweenNano.to(this.objSwf, .5, { alpha:0, onComplete:tweenUnLoadComplete, onCompleteParams:[event] } );
			}else {
				TweenNano.to(this.objSwf, .5, { alpha:0, onComplete:tweenUnLoadComplete, onCompleteParams:[event] } );
			}
			
		}
		
		private function tweenUnLoadComplete(event:AssistenteEvent):void 
		{	
			this.mcHolder.removeChild(this.objSwf);
			this.objSwf = null;
			
			if (event.strUrlAdd != "") 
			{	
				this.dispatchEvent(new AssistenteEvent(AssistenteEvent.ADD_COMPONENT, event.strUrlAdd, "", true));
			}else {
				this.dispatchEvent(new AssistenteEvent(AssistenteEvent.REMOVE_COMPLETED, "", event.strUrlRemove));
			}
			
		}
	}

}