package model 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	/**
	 * @author UNIVERSIA BRASIL
	 * 
	 */
	public class SoundProxy 
	{
		public static const NAME : String = "SoundProxy";

		private var sounds : Dictionary;
		private var transforms : Dictionary;
		private var channels : Array;

		/**
		 * Construtor
		 * 
		 * @param	url caminho do xml de sons que sera usado
		 */
		public function SoundProxy( url: String) 
		{
			//super(NAME);
			
			this.sounds = new Dictionary();
			this.transforms = new Dictionary();
			this.channels = new Array();
			
			var loader : URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, loaderComplete);			
			loader.load(new URLRequest( url/*"xml/sounds.xml"*/));
			
			
		}

		/**
		 * 
		 * 
		 * @param	event
		 */
		private function channelCompleteHandler(event : Event) : void 
		{
			var index : int = this.channels.indexOf(event.target);
			this.channels.splice(index, 1);
		}

		
		/**
		 * Funcao ativada quando acaba de carregar o XML
		 * @param	event
		 */
		private function loaderComplete(event : Event) : void 
		{
			var xml : XML = new XML(event.target.data);
			
			for each (var soundNode:XML in xml.sound) 
			{
				var id : String = soundNode.@id[0];
				var file : String = soundNode.@file[0];
				var volume : Number = soundNode.@volume[0];				
				var transform : SoundTransform = (volume) ? new SoundTransform(volume / 100) : null;
				
				this.sounds[id] = new Sound(new URLRequest(file));				
				this.transforms[id] = transform;
			}
		}

		/*private function onCompleteSound(event : Event) : void {
			//var arrAux : Array = String(Sound(event.target).url).split("/");
			//DEBUGG AUDIOS NO CASO DE ERRO - Não apagar
			//trace("arquivo Ok: " + arrAux[arrAux.length - 4] +"/"+ arrAux[arrAux.length - 3] +"/"+ arrAux[arrAux.length - 2] +"/"+ arrAux[arrAux.length - 1]);
		}

		private function ioErrorSound(event : IOErrorEvent) : void {
			trace("Arquivo não Existe:");
		}*/

		/**
		 * Funcao que solta o som especificado
		 * 
		 * @param	id id do som a ser executado( em forma de string )
		 * @param	preventConcurrentSounds verdadeiro para dar stop em todos os outros sons
		 * @param	times quantas vezes sera repetido
		 */
		public function play(id : String, preventConcurrentSounds : Boolean = false, times : int = 1) : void 
		{
				if (preventConcurrentSounds)
				{
					this.stopCurrentSounds();
				}
					
				if (this.sounds[id]) 
				{
					var channel : SoundChannel = this.sounds[id].play(0, times, this.transforms[id]);
					channel.addEventListener(Event.SOUND_COMPLETE, channelCompleteHandler);
					
					this.channels.push(channel);
				}
			
		}
	
		/**
		 * para todos os sons
		 */
		public function stopCurrentSounds() : void 
		{
			for (var i : int = 0; i < this.channels.length; i++) 
			{
				this.channels[i].stop();
				this.channels.splice(i, 1);
			}
		}	

	}	
}