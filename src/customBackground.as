package 
{
	import flash.text.*;
	import flash.display.*;
	import flash.events.*;
	import flash.geom.Point;

	public class customBackground extends yucoButton
	{
		private var xml:XML;
		private var sprites1:Array = [];
		private var sprites2:Array = [];
		public var inPt:Point;
		public var outPt:Point;
		public function customBackground(mxml:XML,index:int)
		{
			mouseEnabled = false;
			xml = mxml;
			this.name = xml.attribute("name");
			trace("create button name = " +this.name);
			var i:int = 0;
			for each (var child:XML in xml.IMAGES.FILE)
			{

				var sBmp:SmoothingBitmapLoader = new SmoothingBitmapLoader(child);
				sBmp.name = this.name;
				if(i==0)sprites1.push(sBmp);
				else if(i==1)sprites2.push(sBmp);
				i++;
			}
			super.setup("",xml.X,xml.Y,index,sprites1,null);
			trace("IN: "+name +" "+ xml.IN.X +" "+ xml.IN.Y);
			trace("OUT: "+name  +" "+ xml.OUT.X +" "+ xml.OUT.Y);
			inPt = new Point(xml.IN.X,xml.IN.Y);
			outPt = new Point(xml.OUT.X,xml.OUT.Y);
		}
		function changeString():void
		{
			if (CommonProperties.LANGUAGE == CommonProperties.CHINESE_T)
			{

				super.changeSprite(sprites1);


			}
			else if (CommonProperties.LANGUAGE==CommonProperties.ENGLISH)
			{

				super.changeSprite(sprites2);
			}
		}

	}

}