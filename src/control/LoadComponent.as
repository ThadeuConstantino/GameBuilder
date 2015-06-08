package control{
	import com.greensock.TweenNano;
	
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	import events.MainEvent;
	/**
	 * ...
	 * @author ...
	 */
	public class LoadComponent extends MovieClip {
		
		private var ld:Loader;
		private var arrLoader:Array = [];
		private var typeLoad:String = "";
		
		private var strNome:String = "";
		
		private var blTransicao:Boolean = false;
		
		private static const TIME:Number = .5;
		
		/**
		 * Construtor
		 */
		public function LoadComponent() {
			
			if(!this.hasEventListener(MainEvent.ADD_COMPONENT)){
				this.addEventListener(MainEvent.ADD_COMPONENT, addComponent);
				this.addEventListener(MainEvent.REMOVE_COMPONENT, removeComponent);
			}	
			this.ld = new Loader();
			this.addChild(this.ld);
		}
		
		/**
		 * Funcao que adiciona o componente carregado
		 * 
		 * @param	event evento da classe de eventos personalizada MainEvent
		 */
		private function addComponent(event:MainEvent):void {
			
			this.ld.alpha = 0;
			var loaderContext:LoaderContext = new LoaderContext(false, ApplicationDomain.currentDomain, null);
			var file:File = File.applicationDirectory.resolvePath(event.strUrlAdd + ".swf");
			this.ld.load(new URLRequest(file.url), loaderContext);
			
			this.ld.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete, false, 0, true);
			
		}	
		
		/**
		 * Funcao que remove o componente
		 * 
		 * @param	event evento da classe de eventos personalizada MainEvent
		 */
		private function removeComponent(event:MainEvent):void {
			//while (Main.instance.carregar) {
			//Main.instance.removeChild(Main.instance.carregar);
			//Main.instance.carregar = null;
			//}
			//Main.instance.mainSound.play("3", false, 9999);
			if (event.strUrlAdd != "") {
				//Main.instance.mcMarcaLoad.gotoAndPlay("open");
				TweenNano.to(this.ld, .5, { alpha:.1, onComplete:tweenUnLoadComplete, onCompleteParams:[event] } );
			}else {
				TweenNano.to(this.ld, .5, { alpha:.1, onComplete:tweenUnLoadComplete, onCompleteParams:[event] } );
			}
			
		}
		
		private function tweenUnLoadComplete(event:MainEvent):void 
		{	
			this.ld.unload();
			
			if (event.strUrlAdd != "") 
			{
				
				this.dispatchEvent(new MainEvent(MainEvent.ADD_COMPONENT, event.strUrlAdd, "", true));
			}else {
				this.dispatchEvent(new MainEvent(MainEvent.REMOVE_COMPLETED, "", event.strUrlRemove));
			}
			
			//this.dispatchEvent(new MainEvent(MainEvent.COMPLETE_UNLOAD, "", ""));
		}
		
		
		/**
		 * Funcao ativada quando o Swf termina de carregar, poe ele na tela e inicializa o construtor ( se houver )
		 * 
		 * @param	event
		 */
		private function loaderComplete(event:Event):void {
			
			TweenNano.to(this.ld, LoadComponent.TIME, { alpha:1 } );
		}
		
	}
	
}