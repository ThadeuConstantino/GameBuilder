package events
{
	import flash.events.Event;

	public class AssistenteEvent extends Event 
	{
		public static const ADD_COMPONENT:String = "addComponentAss";
		public static const REMOVE_COMPONENT:String = "removeComponentAss";
		public static const REMOVE_COMPLETED:String = "removeCompletedAss";
		
		public static const AVANCA_TIMELINE_ASS:String = "AvancaTimelineAss";
		
		public static const VOLTA_TIMELINE_ASS:String = "VoltaTimelineAss";
		
		
		public var strUrlAdd:String;
		public var strUrlRemove:String;
		
		public var idTimelineAss:int;
		
		/**
		 * 
		 * @param type
		 * @param urlAdd
		 * @param urlRemove
		 * @param idTimeline
		 * 
		 */
		public function AssistenteEvent(type:String="", urlAdd:String = "", urlRemove:String = "", idTimeline:int = -1) 
		{
			super(type, true, false);
			//public vars
			this.strUrlAdd = urlAdd;
			this.strUrlRemove = urlRemove;
			this.idTimelineAss = idTimeline;
		}
	}
}
