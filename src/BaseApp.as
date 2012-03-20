package 
{
	import adobe.utils.CustomActions;
	
	import com.greensock.TweenMax;
	import com.yuco.lab.*;
	
	import flash.desktop.*;
	import flash.display.*;
	import flash.events.DataEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	
	import flash.media.Video;
	import flash.net.*;
	import flash.sensors.Accelerometer;
	import flash.system.*;
	
	import flash.text.engine.SpaceJustifier;
	import flash.utils.*;
	
	import net.hires.debug.*;
	
	
	
	public class BaseApp extends MovieClip
	{

		protected var mXML:XML;
		protected var xmlLoader:URLLoader;

		protected static const PLAYING_SCREEN_SAVER:String = "PLAYING_SCREEN_SAVER";
		protected static const PLAYING_INTRO:String = "PLAYING_INTRO";
		protected static const PLAYING_PREVIEW:String = "PLAYING_PREVIEW";
		protected static const PLAYING_CONTENT:String = "PLAYING_CONTENT";


		protected static var STATE:String = PLAYING_SCREEN_SAVER;


		protected var config:LoadConfig;
		protected var stats;
		protected var logger;

		public function BaseApp()
		{
			
			
			config = new LoadConfig(stage,"data/config.txt");
			config.addEventListener(Event.COMPLETE,configureComplete);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressedDown);
			
			initXML();


		}
		//=====================================================================================================================================;
		function configureComplete(e:Event):void
		{
			if (config.debugMode)
			{
				
				stats = new Stats();
				logger = new Logger(Logger.LEVEL_WARNING);
				addChild(stats);
				addChild(logger);
				
				
				logger.x = stage.width / 2;//stats.width;
			}
			
		}

		//=====================================================================================================================================;
		public function initXML():void
		{
			
			//xml = new XML  ;
			var XML_URL:String = "data/config.xml";

			var myXMLURL:URLRequest = new URLRequest(XML_URL);
			xmlLoader = new URLLoader(myXMLURL);
			xmlLoader.addEventListener(Event.COMPLETE,xmlLoaded,false, 0.0, true);


		}
		public function xmlLoaded(event:Event):void
		{
			trace(event.target.data);
		}
		private function keyPressedDown(event:KeyboardEvent):void
		{
			
			var key:uint = event.keyCode;
			Logger.debug(key);
			switch (key)
			{
				
				case 27 :
					NativeApplication.nativeApplication.exit();
					
					break;
				case 8 :
					if (logger)
					{
						logger.clear();
					}
					break;
				
			}
		}

		

	}

}