package utils{
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.URLRequest;
	import flash.net.URLRequestHeader;
	import com.greensock.TweenNano;
	import events.MainEvent;
	import model.Global;
	
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
		
		private static const TIME:Number = 1;
		
		/**
		 * Construtor
		 */
		public function LoadComponent() {
			if(!Main.instance.hasEventListener(MainEvent.ADD_COMPONENT)){
				Main.instance.addEventListener(MainEvent.ADD_COMPONENT, addComponent);
				Main.instance.addEventListener(MainEvent.REMOVE_COMPONENT, removeComponent);
			}
		}
		
		/**
		 * Funcao que adiciona o componente carregado
		 * 
		 * @param	event evento da classe de eventos personalizada MainEvent
		 */
		private function addComponent(event:MainEvent):void {
			//Main.instance.carregar = new Carregando();
			//Main.instance.addChild(Main.instance.carregar);
			
			//Main.instance.mainSound.stopCurrentSounds();
			//trace(Vars.faseAtual)
			this.ld = new Loader();
			this.arrLoader.push(ld);
			
			var arr:Array = event.strUrlAdd.split("/");
			var nome:String = arr[arr.length - 1];
			this.typeLoad = arr[arr.length - 1];
			
			this.ld.alpha = 0;
			
			this.strNome = event.strUrlAdd;
			
			this.ld.name = nome;
			
			//Global.noLinkage.mcLoad.visible = true;
			
			if (event.blTransicao) {
				//Main.instance.mcMarcaLoad.gotoAndPlay("close");
			}
			
			var request:URLRequest = new URLRequest(Global.urlInfo +"/"+ event.strUrlAdd + ".swf");
			request.requestHeaders.push(new URLRequestHeader("pragma", "no-cache"));
			request.requestHeaders.push(new URLRequestHeader("Expires", "Thu, 01 Jan 1970 00:00:00 GMT, -1"));
			request.requestHeaders.push(new URLRequestHeader("Cache-Control", "no-cache, no-store, must-revalidate"));
			
			//Main.instance.debug(arr1.join("/") +"/"+ event.strUrlAdd + ".swf")
			this.ld.load(request);	

			this.ld.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderComplete);
			this.ld.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, loaderProgress);
			this.ld.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, loaderIOError);
			
			//if (this.strNome.indexOf("Aviso") == -1) Main.instance.mcMarcaLoad.gotoAndPlay("open");
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
				TweenNano.to(this.ld, .5, { alpha:0, onComplete:tweenUnLoadComplete, onCompleteParams:[event] } );
			}else {
				TweenNano.to(this.ld, .5, { alpha:0, onComplete:tweenUnLoadComplete, onCompleteParams:[event] } );
			}
			
		}
		
		private function tweenUnLoadComplete(event:MainEvent):void 
		{	
			var arr:Array = event.strUrlRemove.split("/");
			var nome:String = arr[arr.length - 1];
			for (var i:int = 0; i < this.arrLoader.length; i++) {
				if (this.arrLoader[i] != null) {
					if (this.arrLoader[i].name == nome) {
						var l:Loader = this.arrLoader[i] as Loader;
						l.unload();
						l = null;
						this.arrLoader[i] = l;

						//TweenLite.to(this.arrLoader[i], LoadComponent.TIME, { alpha:0, onComplete:tweenUnload, onCompleteParams:[i] } );
						break;
					}
				}
			}
			if (this.ld) {
				this.ld.visible = false;
				 this.ld.unload();
			}
			if (event.strUrlAdd != "") 
			{
				this.dispatchEvent(new MainEvent(MainEvent.ADD_COMPONENT, event.strUrlAdd, ""));
			}else {
				Global.noLinkage.dispatchEvent(new MainEvent(MainEvent.REMOVE_COMPLETED, "", event.strUrlRemove));
			}
			
			//this.dispatchEvent(new MainEvent(MainEvent.COMPLETE_UNLOAD, "", ""));
		}
		
		private function tweenUnload(i:int):void {
			Loader(this.arrLoader[i]).unload();
			this.arrLoader[i] = "null";
			
			//trace(this.arrLoader);
		}
		/**
		 * Funcao reservada para loaders, inativa por hora
		 * 
		 * @param	event
		 */
		private function loaderProgress(event:ProgressEvent):void {
			//Main.instance.carregar.bar.scaleX = Number(Math.round(Number(event.bytesLoaded / event.bytesTotal)));
			//trace("Loading -  " + String(Math.round(Number(event.bytesLoaded / event.bytesTotal) )));
		}
		
		/**
		 * Funcao ativada quando o Swf termina de carregar, poe ele na tela e inicializa o construtor ( se houver )
		 * 
		 * @param	event
		 */
		private function loaderComplete(event:Event):void {
			//while(Main.instance.carregar) {
				//Main.instance.removeChild(Main.instance.carregar);
				//Main.instance.carregar = null;
			//}
			
			//Global.noLinkage.mcLoad.visible = false;
			
			Main.instance.insertChildHolder(this.ld);
			TweenNano.to(this.ld, LoadComponent.TIME, { alpha:1 } );
		}
		
		/**
		 * Inativo
		 * 
		 * @param	event
		 */
		private function loaderIOError(event:IOErrorEvent):void {
			trace("LoadError Main");
		}
		
	}

}