package events
{
	import flash.events.Event;

	public class SliderEvent extends Event 
	{
		public static const NUM_SELECT_SLIDE:String = "numSelectSlide";
		
		public var idNum:int = 0;
		
		public function SliderEvent(type:String="", id:int = 0) 
		{
			super(type, true, false);
			
			//public vars
			this.idNum = id;
		}
	}
}
