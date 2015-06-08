package{
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class EditorTexto extends MovieClip
	{
		//Declarations
		public var btnB:MovieClip;
		public var btnI:MovieClip;
		public var btnU:MovieClip;
		
		public var btnAlD:MovieClip;
		public var btnAlL:MovieClip;
		
		public var btnCode:MovieClip;
		public var input_txt:TextField;
		
		public function EditorTexto()
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			var abc:TextField = new TextField();
			input_txt = abc;
			
			abc.width = 1000;
			abc.height = 500;
			abc.x = 10;
			abc.y = 10;
			abc.htmlText='Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit lobortis nisl ut aliquip ex ea commodo consequat.';
			abc.border = true;
			abc.wordWrap = true;
			abc.useRichTextClipboard = true;
			abc.multiline = true;
			abc.type = TextFieldType.INPUT;
			abc.background = true;
			abc.alwaysShowSelection = true;
			abc.backgroundColor = 0xFFFFFF;
			abc.doubleClickEnabled = true;
			abc.alwaysShowSelection = true;
			
			var my_fmt:TextFormat = input_txt.getTextFormat(0, input_txt.text.length);
			my_fmt.size = 18;
			input_txt.setTextFormat(my_fmt, 0, input_txt.text.length);
			
			addChild(abc);
			
			btnB.addEventListener(MouseEvent.CLICK, onBClick);
			btnI.addEventListener(MouseEvent.CLICK, onIClick);
			btnU.addEventListener(MouseEvent.CLICK, onUClick);
			
			btnCode.addEventListener(MouseEvent.CLICK, onCodeClick);
			
		}
		
		private function onCodeClick(e:MouseEvent):void 
		{
			trace(input_txt.htmlText)
		}
		
		private function onBClick(e:MouseEvent):void 
		{
			if ((input_txt.selectionBeginIndex == 0) && (input_txt.selectionEndIndex == 0)) return;
			if (input_txt.selectionBeginIndex == input_txt.selectionEndIndex) return; 
			var my_fmt:TextFormat = input_txt.getTextFormat(input_txt.selectionBeginIndex, input_txt.selectionEndIndex);
			my_fmt.size = 18;
			my_fmt.bold = !my_fmt.bold;
			input_txt.setTextFormat(my_fmt, input_txt.selectionBeginIndex, input_txt.selectionEndIndex);
		}
		
		private function onIClick(e:MouseEvent):void 
		{
			if ((input_txt.selectionBeginIndex == 0) && (input_txt.selectionEndIndex == 0)) return;
			if (input_txt.selectionBeginIndex == input_txt.selectionEndIndex) return; 
			var my_fmt:TextFormat = input_txt.getTextFormat(input_txt.selectionBeginIndex, input_txt.selectionEndIndex);
			my_fmt.size = 18;
			my_fmt.italic = !my_fmt.italic;
			input_txt.setTextFormat(my_fmt, input_txt.selectionBeginIndex, input_txt.selectionEndIndex);
		}
		
		private function onUClick(e:MouseEvent):void 
		{
			if ((input_txt.selectionBeginIndex == 0) && (input_txt.selectionEndIndex == 0)) return;
			if (input_txt.selectionBeginIndex == input_txt.selectionEndIndex) return; 
			var my_fmt:TextFormat = input_txt.getTextFormat(input_txt.selectionBeginIndex, input_txt.selectionEndIndex);
			my_fmt.size = 18;
			my_fmt.underline = !my_fmt.underline;
			input_txt.setTextFormat(my_fmt, input_txt.selectionBeginIndex, input_txt.selectionEndIndex);
		}
		
		private function onAlLClick(e:MouseEvent):void 
		{
			if ((input_txt.selectionBeginIndex == 0) && (input_txt.selectionEndIndex == 0)) return;
			if (input_txt.selectionBeginIndex == input_txt.selectionEndIndex) return; 
			var my_fmt:TextFormat = input_txt.getTextFormat(input_txt.selectionBeginIndex, input_txt.selectionEndIndex);
			my_fmt.size = 18;
			my_fmt.align = TextFieldAutoSize.LEFT;
			input_txt.setTextFormat(my_fmt, input_txt.selectionBeginIndex, input_txt.selectionEndIndex);
		}
		private function onAlDClick(e:MouseEvent):void 
		{
			if ((input_txt.selectionBeginIndex == 0) && (input_txt.selectionEndIndex == 0)) return;
			if (input_txt.selectionBeginIndex == input_txt.selectionEndIndex) return; 
			var my_fmt:TextFormat = input_txt.getTextFormat(input_txt.selectionBeginIndex, input_txt.selectionEndIndex);
			my_fmt.size = 18;
			my_fmt.align = TextFieldAutoSize.RIGHT;
			input_txt.setTextFormat(my_fmt, input_txt.selectionBeginIndex, input_txt.selectionEndIndex);
		}
		
	}
}