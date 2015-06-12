package utils
{
	import com.greensock.TweenNano;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	import events.SliderEvent;
	
	public class Slider extends MovieClip
	{
		private var mcBox:*;
		public var mcBarBg:MovieClip;
		public var arrMarcasSL:Array = [];
		public var arrMarcaX:Array = [];
		
		private var arrPosAntes:Array = [];
		private var arrPosDepois:Array = [];
			
		private var numMedia:Number = 0;
		
		private var tipo:String = "";
		
		public static var INIT_SLIDE:int = 3;
		public static const PADDING:int = 5;
		
		public function Slider(){}
		
		/**
		 * 
		 * @param arrTxt
		 * 
		 */		
		public function init(arrTxt:Array, tipo:String=""):void
		{
			this.tipo = tipo;
			this.cliqueBox();
			this.montaGuias(arrTxt);
		}
		
		/**
		 * 
		 * @param arrTxt
		 * 
		 */		
		private function montaGuias(arrTxt:Array):void
		{
			var media:Number = mcBarBg.width/(arrTxt.length+1);
				
			for(var i:int=0; i < arrTxt.length + 2; i++)
			{
				if(i != 0 && i != arrTxt.length+1) {
					var marcaSL:* = new MarcaSL();
					marcaSL.x = media * (i);
					
					this.addChild(marcaSL);
					this.arrMarcasSL.push(marcaSL);
					this.arrMarcaX.push(marcaSL.x);
					
					marcaSL.txt.text = arrTxt[this.arrMarcasSL.length-1];
					arrPosAntes.push(0);
					arrPosDepois.push(0);
				}
			}
			
			this.numMedia = (arrMarcaX[1] - arrMarcaX[0])/2;
			
			for(var j:int=0; j < this.arrMarcasSL.length; j++)
			{
				if(j == 0)
				{
					arrPosAntes[j] = 0;
					arrPosDepois[j] = this.arrMarcaX[j] + numMedia;
				}else if(j == this.arrMarcasSL.length-1){
					arrPosAntes[j] = this.arrMarcaX[j] - numMedia;
					arrPosDepois[j] = this.mcBarBg.width;
				}else{
					arrPosAntes[j] = this.arrMarcaX[j] - numMedia;
					arrPosDepois[j] = this.arrMarcaX[j] + numMedia;
				}
			}

			this.setChildIndex(this.mcBox, this.numChildren-1);
			
			//InitSlide
			this.initSlide();
		}
		
		private function initSlide()
		{
			Slider.INIT_SLIDE = Math.round(this.arrMarcaX.length/2);
			
			this.mcBox.x = this.arrMarcaX[Slider.INIT_SLIDE-1];
			
			if(this.tipo == "Number") 
			{
				var marcaTxt:MovieClip = this.arrMarcasSL[Slider.INIT_SLIDE-1] as MovieClip;
				this.mcBox.txt.text = marcaTxt.txt.text;
			}
			
			this.dispatchEvent(new SliderEvent(SliderEvent.NUM_SELECT_SLIDE, Slider.INIT_SLIDE));
		}
		
		/**
		 * 
		 * 
		 */		
		private function cliqueBox():void
		{
			this.mcBox = this.tipo == "Number" ? new McNum : new McBox();
			this.addChild(this.mcBox);
			this.mcBox.x = this.mcBox.width /2;
			
			this.mcBox.buttonMode = true;
			this.mcBox.addEventListener(MouseEvent.MOUSE_DOWN, handleDownBox);
		}
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function handleDownBox(e:MouseEvent):void
		{
			var rect:Rectangle = new Rectangle(this.mcBox.width /2, 0, (this.mcBarBg.width - (this.mcBox.width + Slider.PADDING)), 0);
			this.mcBox.startDrag(false, rect);
			stage.addEventListener(MouseEvent.MOUSE_UP, handleUpBox);
		}		
		/**
		 * 
		 * @param e
		 * 
		 */		
		private function handleUpBox(e:MouseEvent):void
		{
			for(var i:int=0; i < this.arrMarcaX.length; i++)
			{
				if(this.mcBox.x >= this.arrPosAntes[i] && this.mcBox.x < this.arrPosDepois[i])
				{
					TweenNano.to(this.mcBox, .2, {x:this.arrMarcaX[i]});
					
					//Caso seja um Slider do tipo Number
					if(this.tipo == "Number") 
					{
						var marcaTxt:MovieClip = this.arrMarcasSL[i] as MovieClip;
						this.mcBox.txt.text = marcaTxt.txt.text;
					}
						
					this.dispatchEvent(new SliderEvent(SliderEvent.NUM_SELECT_SLIDE, i));
				}
			}
			
			this.mcBox.stopDrag();
			stage.removeEventListener(MouseEvent.MOUSE_UP, handleUpBox);
		}
			
		
	}
}