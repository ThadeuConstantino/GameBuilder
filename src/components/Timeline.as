package components
{
	import flash.display.MovieClip;
	
	import utils.StatusBt;
	
	public class Timeline extends MovieClip
	{
		private var idTimeline:int = 1;
		
		public static const ATUAL:int = 2;
		public static const FEITO:int = 3;
		public static const OVER:int = 4;
		
		//pattern Singleton
		private static var _instance:Timeline;
		public static function get instance():Timeline { return _instance };
		//
		
		public function Timeline():void
		{
			_instance = this;
		}

		public function statusBotaoAtual():void
		{
			var btAtual:StatusBt = this.getChildByName("bt"+this.idTimeline) as StatusBt;
			
			btAtual.gotoAndStop(btAtual.blFeito ? Timeline.FEITO : 1);
		}
		
		public function setStatusBtTimeline(idFrame:int):void
		{
			this.idTimeline = idFrame;
			
			var btAtual:StatusBt = this.getChildByName("bt"+idFrame) as StatusBt;
			btAtual.setEnabled(false);
			btAtual.gotoAndStop(Timeline.ATUAL);
			
			for(var i:int=1; this.getChildByName("bt"+i); i++){
				var btPrev:StatusBt = this.getChildByName("bt"+i) as StatusBt;
				btPrev.idNum = i;
				
				if(i < idFrame){
					btPrev.gotoAndStop(Timeline.FEITO);
					btPrev.setEnabled(true);
				}
			}
		}
	}
}