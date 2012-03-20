package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	public class SmoothingBitmapLoader extends Sprite
	{
		public static const INIT = "initLoad";
		private var imgbase;
		public var imgLoader;
		private var _url:String;
		public function SmoothingBitmapLoader(url)
		{
			imgbase = new Sprite();
			imgLoader = new Loader();
			_url = url;
			try
			{
				imgLoader.load(new URLRequest(url));
				trace(url);
				imgLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteHandler);
				imgLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onErroreHandler);
				addChild(imgbase);
			}
			catch (err:Error)
			{
				trace(url);
				trace(err.message);
			}
		}
		private function onErroreHandler(e:IOErrorEvent)
		{
			trace(_url);
		}
		private function onCompleteHandler(e:Event)
		{
			try
			{
				imgbase.addChild(imgLoader);
				var str:String = new String(_url);
				if (_url.search(".swf") > 0)
				{
				}
				else if ( _url.search(".png")>0 || _url.search(".jpg")>0)
				{

					var bmp = Bitmap(imgLoader.content);
					bmp.smoothing = true;

				}

				dispatchEvent(new Event(INIT));
			}
			catch (err:Error)
			{
				trace(err.message);
			}
		}
	}
}