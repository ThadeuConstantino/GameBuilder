package events
{
	import flash.events.Event;

	public class AssistenteEvent extends Event 
	{
		public static const ADD_COMPONENT:String = "addComponentAss";
		public static const REMOVE_COMPONENT:String = "removeComponentAss";
		public static const REMOVE_COMPLETED:String = "removeCompletedAss";
		
		public var strUrlAdd:String;
		public var strUrlRemove:String;
		public var blTransicao:Boolean;
		
		public function AssistenteEvent(type:String="", urlAdd:String = "", urlRemove:String = "", transicao:Boolean = false) 
		{
			super(type, true, false);
			//public vars
			this.strUrlAdd = urlAdd;
			this.strUrlRemove = urlRemove;
			this.blTransicao = transicao;
		}
	}
}
