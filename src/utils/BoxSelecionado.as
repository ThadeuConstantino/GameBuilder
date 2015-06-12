package utils
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class BoxSelecionado extends MovieClip
	{
		private var _idAlternativa:int = 0;
		
		public function BoxSelecionado()
		{
			this.initSelect();
		}
		
		private function initSelect()
		{
			for(var j:int=1; this.getChildByName("bt"+j); j++)
			{
				var bt:HudButtons = this.getChildByName("bt"+j) as HudButtons;
				bt.idNum = j;
				bt.enabledBt(true);
				bt.addEventListener(MouseEvent.MOUSE_DOWN, handleDownBt);	
			}
		}
		
		private function cleanBts()
		{
			for(var j:int=1; this.getChildByName("bt"+j); j++)
			{
				var bt:HudButtons = this.getChildByName("bt"+j) as HudButtons;
				bt.idNum = j;
				bt.gotoAndStop(1);
				bt.enabledBt(true);
				bt.addEventListener(MouseEvent.MOUSE_DOWN, handleDownBt);	
			}
		}
		
		private function handleDownBt(e:MouseEvent):void
		{
			this.cleanBts();
			
			var bt:HudButtons = e.currentTarget as HudButtons;
			bt.enabledBt(false);
			bt.removeEventListener(MouseEvent.MOUSE_DOWN, handleDownBt);
			bt.gotoAndStop(3);
			
			this.Alternativa = bt.idNum;
			this.dispatchEvent(new Event(Event.CHANGE, true));
		}
		
		//Getter Setter
		public function set Alternativa(value:int):void { this._idAlternativa = value; } 
		public function get Alternativa():int { return this._idAlternativa; } 
	}
}