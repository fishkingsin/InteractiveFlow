package 
{
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.xml.*;

	import net.hires.debug.*;
	public class InterfacePraser extends EventDispatcher
	{
		public static const INIT = "initLoad";
		private var mXML:XML;
		private var xmlLoader:URLLoader;
		public var pages:Vector.<Sprite> = new Vector.<Sprite>();
		public var children:Vector.<Sprite> = new Vector.<Sprite>();
		public var buttons:Vector.<customButton> = new Vector.<customButton>();
		public var bgs:Vector.<customBackground> = new Vector.<customBackground>();
	
		
		public function InterfacePraser()
		{
			// constructor code
			initXML();
		}
		public function initXML():void
		{
			//xml = new XML  ;
			var XML_URL:String = "data/config.xml";

			var myXMLURL:URLRequest = new URLRequest(XML_URL);
			xmlLoader = new URLLoader(myXMLURL);
			xmlLoader.addEventListener(Event.COMPLETE,xmlLoaded,false, 0.0, true);


		}
		public function switchButtonLanguage():void
		{
			for each (var btn:customButton in buttons)
			{
				btn.changeString();
			}
			for each (var bg:customBackground in bgs)
			{
				bg.changeString();
			}
		}
		//=====================================================================================================================================
		public function xmlLoaded(event:Event):void
		{
			this.mXML = XML(xmlLoader.data);

			parseMessages(mXML);

		}
		//=====================================================================================================================================
		private function parseMessages(node:XML):void
		{
			var pageNum:int = 0;
			for each (var page:XML in node.PAGE)
			{
				Logger.debug("page ---------"+pageNum);

				var buttonNum:int = 0;
				var pageMC:Sprite = new Sprite();
				Logger.debug("page name---------"+pageMC.name);
				pageMC.name = page.attribute("name");
				pages.push(pageMC);
				for each (var bg:XML in page.BACKGROUND)
				{
					var _bg = new customBackground(bg,pageNum);
					pageMC.addChild(_bg);
					bgs.push(_bg);
				}
				for each (var button:XML in page.BUTTON)
				{
					Logger.debug("button ---------"+buttonNum);
					buttonNum++;
					var btn = new customButton(button,buttonNum);

					pageMC.addChild(btn);
					if (btn.name != "title")
					{
						buttons.push(btn);
					}//Logger.debug(button);
					
				}
				
				for each (var list_:XML in page.LIST)
				{
					var list:Vector.<customButton> = new Vector.<customButton>();
					for each (var list_button:XML in list_.BUTTON)
					{
						//Logger.debug("button ---------"+buttonNum);
						buttonNum++;
						var btn = new customButton(list_button,buttonNum);
						
					
						if (btn.name != "title")
						{
							list.push(btn);
						}
					}
					var dropList = new customDropDownList(list);
					dropList.addEventListener("UPDATE",function onUpdateFunction(e:Event):void
											  {
												  
												  for(var i:int = 1; i< children.length; i++){
													var child:Sprite = children[i];
													child.y = children[i-1].y+children[i-1].height;
													}
											  });
					dropList.addEventListener("CLOSE",function onCloseFunction(e:Event):void
											  {
												  
												  for(var i:int = 0; i< children.length; i++){
													var child:customDropDownList = children[i] as customDropDownList;
													child.closeList();
													}
											  });
					children.push(dropList);
					pageMC.addChild(dropList);
					dropList.x = list_.X;
					dropList.y = list_.Y;
				}
				
				



				//addChild(pageMC);
				pageNum++;
			}
			dispatchEvent(new Event(INIT));

		}
		public function getPageByName(m_name:String):Sprite
		{
			for each (var mc:Sprite in pages)
			{

				if (m_name==mc.name)
				{

					return mc;

				}
			}
			return null;
		}

	}


}