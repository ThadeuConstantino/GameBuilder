package events
{
	import flash.events.Event;

	public class MainEvent extends Event 
	{
		public static const ADD_COMPONENT:String = "addComponent";
		public static const REMOVE_COMPONENT:String = "removeComponent";
		public static const REMOVE_COMPLETED:String = "removeCompleted";
		
		public var strUrlAdd:String;
		public var strUrlRemove:String;
		public var blTransicao:Boolean;
		
		public function MainEvent(type:String="", urlAdd:String = "", urlRemove:String = "", transicao:Boolean = false) 
		{
			super(type, true, false);
			//public vars
			this.strUrlAdd = urlAdd;
			this.strUrlRemove = urlRemove;
			this.blTransicao = transicao;
		}
	}
}
