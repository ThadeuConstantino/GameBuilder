package utils {
	

	/**
	 * @author thadeu.santos
	 */
	
		
		public function URLAbsoluto(loaderInfo):String{
			var str:String = loaderInfo.url;
			var arr1:Array = str.split("/");
			arr1.pop();
			
			str = arr1.join("/");
		
			return str;
		}
	
}
