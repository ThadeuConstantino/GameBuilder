package {
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import events.MainEvent;
	import events.SoundEvent;
	
	import model.Global;
	
	import utils.LoadComponent;
	import utils.URLAbsoluto;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Main extends MovieClip 
	{
		private var ld:Loader;
		public var bg:MovieClip;
		public var mcTopBar:MovieClip;
		
		public var mcHolder:MovieClip;
		public var loadingFiles:LoadComponent;
		
		public var objSwf;
		
		//Sounds
		//private var sons:SoundProxy;
		
		//pattern Singleton
		private static var _instance:Main;
		public static function get instance():Main { return _instance };
		//
		
		public function Main() 
		{
			_instance = this;
			Global.noLinkage = this;
			this.addEventListener(Event.ADDED_TO_STAGE, init);
		}
			
		/**
		 * 
		 * @param e
		 * 
		 */
		private function disparaSom(e:SoundEvent):void 
		{
			//this.sons.play(e.id, e.preventConcurrentSounds, e.times );
		}
		
		private function init(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			this.bg.visible = false;
			
			Global.urlInfo = URLAbsoluto(loaderInfo) + "/bin";
			
			//this.sons = new SoundProxy( Global.urlInfo + "xml/sounds.xml" );
			//this.addEventListener(SoundEvent.DISPARA_SOM, disparaSom);
			
			//Loading SWFs externos
			this.loadingFiles = new LoadComponent();
			this.addChild(this.loadingFiles);
			
			//Inicia Assistente
			this.loadingFiles.dispatchEvent(new MainEvent(MainEvent.ADD_COMPONENT, "Logo"));
		}
		
		/**
		 * 
		 * @param _ld
		 * 
		 */
		
		//Faz a inserção de telas no Root no Simulador
		public function insertChildHolder(_ld:Loader):void
		{		
			this.mcHolder.addChild(_ld);
		}
		
		
	}

}