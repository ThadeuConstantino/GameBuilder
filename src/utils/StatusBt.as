package utils
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import components.Assistente;
	import components.Timeline;
	
	public class StatusBt extends MovieClip
	{
		public var idNum:int = 0;
		public var blFeito:Boolean = false;
		
		public static const ATUAL:int = 2;
		public static const FEITO:int = 3;
		public static const OVER:int = 4;
		
		public function setEnabled(bool:Boolean)
		{
			if(bool)
			{
				this.blFeito = true;
				this.buttonMode = true;
				this.addEventListener(MouseEvent.MOUSE_OVER, handleOver);
				this.addEventListener(MouseEvent.MOUSE_OUT, handleOut);
				this.addEventListener(MouseEvent.MOUSE_DOWN, handleDownSB);
			}else
			{
				this.blFeito = false;
				this.buttonMode = false;
				this.removeEventListener(MouseEvent.MOUSE_OVER, handleOver);
				this.removeEventListener(MouseEvent.MOUSE_OUT, handleOut);
				this.removeEventListener(MouseEvent.MOUSE_DOWN, handleDownSB);
			}
		}
		
		private function handleOver(e:MouseEvent)
		{
			e.currentTarget.gotoAndStop(StatusBt.OVER);
		}
		
		private function handleOut(e:MouseEvent)
		{
			e.currentTarget.gotoAndStop(blFeito ? StatusBt.FEITO : StatusBt.ATUAL);
		}
		
		private function handleDownSB(e:MouseEvent)
		{
			trace("1")
			Timeline.instance.statusBotaoAtual();
			trace("2")
			Assistente.instance.valorEtapaAtual = e.currentTarget.idNum-1;
			trace("3")
			Assistente.instance.removeTelaAtual();
			trace("4")
		}
	}
}