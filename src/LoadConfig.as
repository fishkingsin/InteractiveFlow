package {
	import flash.events.*;
	import flash.utils.*;
	import flash.net.*;
	import flash.display.*;
	import flash.ui.*;
	public class LoadConfig  extends EventDispatcher {
		public var debugMode:Boolean;
		var __stage:Stage;
		public var isMouseHide:Boolean;

		public function LoadConfig(_stage:Stage, fn:String = null) {
			__stage=_stage;
			var ldr:URLLoader = new URLLoader();
			ldr.dataFormat=URLLoaderDataFormat.VARIABLES;
			ldr.addEventListener(IOErrorEvent.IO_ERROR, ldrError);
			ldr.addEventListener(Event.COMPLETE, ldrComplete);
			if(fn!=null)
			{
				ldr.load(new URLRequest(fn));
			}
			else
			{
				ldr.load(new URLRequest("config.txt"));
			}
			isMouseHide = false;
	}
		private function ldrComplete(e:Event) {
			
			var urlVar:URLVariables=new URLVariables(e.target.data);

			if (urlVar.debugMode!=null) {
				if (urlVar.debugMode.toLowerCase()=="true") {

					debugMode=true;
					
				}
			}
			if (urlVar.alwaysOnTop!=null) {
				if (urlVar.alwaysOnTop.toLowerCase()=="true") {
					__stage.nativeWindow.alwaysInFront=true;
				}
			}
			if(urlVar.FullScreen!=null)
			{
				if (urlVar.FullScreen.toLowerCase()=="true") {
					__stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
					__stage.scaleMode = StageScaleMode.EXACT_FIT;
					__stage.align = StageAlign.TOP_LEFT;
					trace("Enter Full Screen");
				}	
			}
			if (urlVar.hideMouse!=null) {
				if (urlVar.hideMouse.toLowerCase()=="true") {
					__stage.nativeWindow.activate();
					__stage.nativeWindow.orderToBack();
					__stage.nativeWindow.orderToFront();
					Mouse.hide();
					isMouseHide = true;
				}
			}

			if (urlVar.startX!=null) {
				__stage.nativeWindow.x=int(urlVar.startX);
			}
			if (urlVar.startX!=null) {
				__stage.nativeWindow.y=int(urlVar.startY);
			}if (urlVar.startW!=null) {
				__stage.nativeWindow.width=int(urlVar.startW);
			}
			if (urlVar.startH!=null) {
				__stage.nativeWindow.height=int(urlVar.startH);
			}
			dispatchEvent( new Event( Event.COMPLETE, true ) );

		}



		private function ldrError(e:Event) {
			trace("Error loading config.txt");
		}
	}
}