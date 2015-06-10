package components
{
	import com.greensock.TweenNano;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.utils.getDefinitionByName;
	
	import events.AssistenteEvent;
	
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
		public var mcTimeline:Timeline;
		
		public var mcHolder:MovieClip;
		public var loadingFiles:MovieClip;
		
		public var objSwf:*;
		
		//Qual o arquivo estou atualmente na tela de Assistente
		public var intEtapaAtual:int = 0;
		
		//pattern Singleton
		private static var _instance:Assistente;
		public static function get instance():Assistente { return _instance };
		//
		
		public function Assistente():void
		{
			if (Global.noLinkage == null) _instance = Global.noLinkage = this;
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
			
			this.addEventListener(AssistenteEvent.ADD_COMPONENT, addComponent);
			this.addEventListener(AssistenteEvent.REMOVE_COMPONENT, removeComponent);
			
			this.addEventListener(AssistenteEvent.AVANCA_TIMELINE_ASS, avantaTimelineAss);
			
			//Timeline Assistentes
			this.dispatchEvent(new AssistenteEvent(AssistenteEvent.ADD_COMPONENT, Global.timelineAssistente[this.intEtapaAtual]));
		}
		
		/**
		 * 
		 * @param e
		 * @return 
		 * 
		 */		
		private function avantaTimelineAss(e:AssistenteEvent)
		{
			this.intEtapaAtual = this.intEtapaAtual + 1;
			
			this.dispatchEvent(new AssistenteEvent(AssistenteEvent.REMOVE_COMPONENT, Global.timelineAssistente[this.intEtapaAtual]));
		}
		
		/**
		 * 
		 * @param _ld
		 * 
		 */		
		public function insertChildHolder(_ld:Loader):void
		{			
			this.addChild(_ld);
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function addComponent(event:AssistenteEvent):void 
		{
			var ClassReference:Class = getDefinitionByName(event.strUrlAdd) as Class;
			this.objSwf = new ClassReference();
			this.objSwf.x += stage.width;
			
			this.mcHolder.addChild(this.objSwf);
			
			TweenNano.to(this.objSwf, .5, { x:0 } );
		}
		
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function removeComponent(event:AssistenteEvent):void 
		{	
			var fileAntigo:* = this.objSwf;
			TweenNano.to(this.objSwf, .5, { x:-stage.width, onComplete:removeFileAntigo, onCompleteParams:[fileAntigo]});
			
			this.tweenUnLoadComplete(event);
		}
		
		private function removeFileAntigo(fileAntigo:*)
		{
			this.mcHolder.removeChild(fileAntigo);
			fileAntigo = null;
		}
		/**
		 * 
		 * @param event
		 * 
		 */		
		private function tweenUnLoadComplete(event:AssistenteEvent):void 
		{	
			if (event.strUrlAdd != "") 
			{	
				this.dispatchEvent(new AssistenteEvent(AssistenteEvent.ADD_COMPONENT, event.strUrlAdd, ""));
			}else {
				this.dispatchEvent(new AssistenteEvent(AssistenteEvent.REMOVE_COMPLETED, "", event.strUrlRemove));
			}
			
		}
	}
	
}