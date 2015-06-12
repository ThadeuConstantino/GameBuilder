package components
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import events.AssistenteEvent;
	
	import utils.BoxSelecionado;
	import utils.HudButtons;

	
	/**
	 * ...
	 * @author ...
	 */
	public class Perfil extends MovieClip 
	{
		public var btContinuar:HudButtons;
		public var faixa1:BoxSelecionado;
		public var faixa2:BoxSelecionado;
		public var faixa3:BoxSelecionado;
		public var faixa4:BoxSelecionado;
		
		public var arrAlternativas:Array = [];
		
		//pattern Singleton
		private static var _instance:Perfil;
		public static function get instance():Perfil { return _instance };
		//
		
		public function Perfil():void
		{
			_instance = this;
			
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
			
			this.btContinuar.visible = false;
			this.btContinuar.enabledBt(true);
			this.btContinuar.addEventListener(MouseEvent.MOUSE_UP, handleUpContinuar);
			
			//Inicia validacao do campo Alternativas
			for(var i:int = 1; this.getChildByName("faixa"+i); i++)
			{
				this.arrAlternativas[i-1] = 0;
			}
			
			this.addEventListener(Event.CHANGE, onChangeBox);
		}
		
		private function onChangeBox(e:Event)
		{
			
			this.arrAlternativas[0] = faixa1.Alternativa;
			this.arrAlternativas[1] = faixa2.Alternativa;
			this.arrAlternativas[2] = faixa3.Alternativa;
			this.arrAlternativas[3] = faixa4.Alternativa;
			trace(arrAlternativas)
			if(arrAlternativas.indexOf(0) == -1)
			{
				this.btContinuar.visible = true;
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