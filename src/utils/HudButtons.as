package utils {
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import events.SoundEvent;
	
	import model.Global;
	
	/**
	 * ...
	 * @author ...
	 */
	public class HudButtons extends MovieClip
	{
		public var idNum:int = 0;
		private var posX:Number;
		private var posY:Number;
		
		public function HudButtons() 
		{
			this.gotoAndStop(1);
			this.posX = this.x;
			this.posY = this.y;
		}
		
		/**
		 * Funcao que habilita ou desabilita botao
		 * 
		 * @param	bool true para habilitar, false para desabilitar
		 */
		public function enabledBt(bool:Boolean):void {
			if (bool) {
				this.buttonMode = true;
				if(!this.hasEventListener(MouseEvent.MOUSE_DOWN))this.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
				if(!this.hasEventListener(MouseEvent.MOUSE_UP))this.addEventListener(MouseEvent.MOUSE_UP, onUp);
				if(!this.hasEventListener(MouseEvent.MOUSE_OVER))this.addEventListener(MouseEvent.MOUSE_OVER, onOver);
				if(!this.hasEventListener(MouseEvent.ROLL_OUT))this.addEventListener(MouseEvent.ROLL_OUT, onOut);
			}else {
				this.buttonMode = false;
				this.removeEventListener(MouseEvent.MOUSE_DOWN, onDown);
				this.removeEventListener(MouseEvent.MOUSE_OVER, onOver);
				this.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			}
		}
		
		private function onUp(e:MouseEvent):void 
		{
			
		}
		
		public function removeOut()
		{
			this.removeEventListener(MouseEvent.ROLL_OUT, onOut);
		}
		
		public function desabilitado(status:Boolean):void
		{
			if(status){
				TweenMax.to(this, .01, { colorTransform: { tint:0x000000, tintAmount:0.5 }} );
			}else {
				TweenMax.to(this, .01, { colorTransform: { tint:0x000000, tintAmount:0 }} );
			}
		}
	
		//Listener´s
		/**
		 * Funcao ativada quando houver clique no botao
		 * 
		 * @param	e
		 */
		public function onDown(e:MouseEvent):void 
		{
			
			//this.desabilitado(true);
			this.gotoAndStop(1);
			Global.noLinkage.dispatchEvent(new SoundEvent(SoundEvent.DISPARA_SOM, "2"));
		}
	
		/**
		 * Funcao ativada quando houver over no botao
		 * 
		 * @param	e
		 */
		public function onOver(e:MouseEvent):void 
		{
			this.gotoAndStop(2);
		}
		
		public function stateRemoveOut(value:Boolean) 
		{
			if (value) {
				this.removeEventListener(MouseEvent.ROLL_OUT, onOut);
			}else {
				this.addEventListener(MouseEvent.ROLL_OUT, onOut);
			}
		}
		
		/**
		 * Funcao ativada quando houver out no botao
		 * 
		 * @param	e
		 */
		public function onOut(e:MouseEvent):void 
		{
			
			this.gotoAndStop(1);
		}
		
	}

}