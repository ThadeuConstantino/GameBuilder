package components
{
	import flash.display.MovieClip;
	
	public class Timeline extends MovieClip
	{
		private var idTimeline:int = 1;
		
		public function Timeline():void
		{
			
		}
		
		/**
		 * 
		 * @param e
		 * 
		 */			
		public function setStatusBtTimeline(idFrame:int):void
		{
			var bt:MovieClip = this.getChildByName("bt"+idFrame) as MovieClip;
			
		}
	}
}