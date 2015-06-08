package events
{
	import flash.events.Event;

	public class SoundEvent extends Event 
	{
		public static const DISPARA_SOM:String = "disparaSom";
		
		public var id:String;
		public var preventConcurrentSounds:Boolean;
		public var times:int;
		
		public function SoundEvent(type:String="", id:String="", boolStop:Boolean=false, times:int=1) 
		{
			super(type, true, false);
			//public vars
			this.id = id;
			this.preventConcurrentSounds = boolStop;
			this.times = times;
		}
	}
}
