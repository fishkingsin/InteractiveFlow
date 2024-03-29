﻿package  {
	import flash.text.*;
	public class CommonProperties {
		[Embed (source="./assets/Gotham-Medium_0.ttf", fontFamily="Gotham-Medium")]
		public var f1:String;
		
		[Embed (source="./assets/DFT_R3.ttc", fontFamily="DFT_R3")]
		public var f2:String;
		
		public static const CHINESE_T:String = "CHINESE_T";
		public static const ENGLISH:String = "ENGLISH";

		public static var LANGUAGE:String = CHINESE_T;
		public static var format1:TextFormat;
		public static var format2:TextFormat;
		public static var allButton:Vector.<yucoButton> = new Vector.<yucoButton>();
		
		
		public static function initFont():void 
		{
			format1 = new TextFormat();
			format2 = new TextFormat();
		
			
			//var font1:Font1=new Font1();
			format1.font = "Gotham-Medium";

			format1.color = 0xFFFFFF;
			format1.size = 36;
			format1.align = TextFormatAlign.LEFT;
			
			
			//var font2:Font2=new Font2();
			format2.font = "DFT_R3";//font2.fontName;

			format2.color = 0xFFFFFF;
			format2.size = 36;
			format2.align = TextFormatAlign.LEFT;
		}
	}
	
}
