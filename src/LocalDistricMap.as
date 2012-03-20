package 
{

	import flash.media.Video;
	import newcommerce.media.FLVPlayer;
	import newcommerce.media.MediaData;
	import newcommerce.media.MediaEvent;
	import newcommerce.media.MediaSizeEvent;
	import newcommerce.media.MediaTimeEvent;
	import newcommerce.media.MediaCuePointEvent;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.display.*;

	import flash.text.*;

	import net.hires.debug.*;
	import gs.TweenMax;
	import com.yuco.lab.*;
	import flash.utils.ByteArray;

	public class LocalDistricMap extends BaseApp
	{
		//video
		private var flvplayer:FLVPlayerClass;
		private var ss:ScreenSaver;

		private var ssFilePath:String;
		private var vidParent:MovieClip;
		private var format1:TextFormat;
		private var format2:TextFormat;

		var currentVidIndex:uint = 0;
		var minterface:InterfacePraser;
		var oldSprite:Sprite;


		var pages:MovieClip = new MovieClip();

		var currentPage:int = 0;
		var totalPage:int = 4;

		var client:BridgeClient;
		var dropdownList:customDropDownList;
		var fader:Fader;
		public function LocalDistricMap()
		{
			
			super();

			init();
			fader = new Fader(this,new BitmapData(1920 ,1080));
			stage.addChild(fader);
		}
		private function init():void
		{

			addChild(pages);


			pages.addEventListener(MouseEvent.CLICK, btnPressed);
			flvplayer = new FLVPlayerClass();
			flvplayer._player.addEventListener(MediaEvent.STARTED_PLAYING, doMediaStarted);
			flvplayer._player.addEventListener(MediaEvent.FINISHED_PLAYING, doMediaFinished);
			flvplayer._player.addEventListener(MediaEvent.ERROR, doMediaError);
			flvplayer._player.addEventListener(MediaTimeEvent.DURATION, doMediaDuration);
			flvplayer._player.addEventListener(MediaTimeEvent.TIME, doMediaTime);
			flvplayer._player.addEventListener(MediaCuePointEvent.CUE_POINT,function onCuePoint(e:MediaCuePointEvent):void{
											   	Logger.debug("MediaCuePointEvent: "+e.name);
											   });
			CommonProperties.initFont();
			format1 = CommonProperties.format1;
			format2 = CommonProperties.format2;
			minterface = new InterfacePraser ();
			minterface.addEventListener(InterfacePraser.INIT,function insertToPage(e:Event):void
			{
			pages.addChild(minterface.getPageByName("p0"));
			//dropdownList = new customDropDownList(minterface.buttons);
			//minterface.getPageByName("p0").addChild(dropdownList);// = new customDropDownList(minterface.buttons);
			
			});
			/*addChild(new customDropDownList(new SmoothingBitmapLoader("./data/images/btn_6_cn.png"),
			new SmoothingBitmapLoader("./data/images/btn_6_cn.png"),
			new SmoothingBitmapLoader("./data/images/btn_6_cn.png"),
			new SmoothingBitmapLoader("./data/images/btn_6_cn.png"),
			new SmoothingBitmapLoader("./data/images/btn_6_cn.png")));*/
		}
		//=====================================================================================================================================;
		override public function xmlLoaded(event:Event):void
		{

			this.mXML = XML(xmlLoader.data);


			ss = new ScreenSaver(stage,this.mXML.IDLE);




			ssFilePath = this.mXML.SCREENSAVER;
			flvplayer.setLoop(true);
			STATE = PLAYING_SCREEN_SAVER;
			startVid(pages,ssFilePath);
			ss.addEventListener("idel", onIdle);
			ss.addEventListener("reset_idel", function onIdle(e:Event):void 
			{
			//
			//
			});
			pages.addEventListener(MouseEvent.CLICK,function onClick(e:MouseEvent):void
			{
			ss.resetTimeOut();
			});
			//fader = new Fader(this,new BitmapData(stage.width,stage.height));
			//addChild(fader);
			client = new BridgeClient(this.mXML.IP,this.mXML.PORT);
		}
		function onIdle(e:Event):void
		{
			//
			Logger.debug("long onIdle");
			//if (! flvplayer.isPlaying)
			{

				setPageOrder(pages,minterface.getPageByName("p0"),ssFilePath);
				flvplayer.setLoop(true);
				STATE = PLAYING_SCREEN_SAVER;
				startVid(pages,ssFilePath);
			};
			//else
			//{
			Logger.debug("ss.resetTimeOut();");
			ss.resetTimeOut();
			//}
		}

		//=====================================================================================================================================

/*function switchLanguage(language:String , file:String):void
		{
			
			try{
				if(pages.getChildIndex(arr1[0])!= pages.numChildren - 1)
				{
					
				}
			}catch(error:Error)
			{
				if(CommonProperties.LANGUAGE == language)return;
			}
			
			
			CommonProperties.LANGUAGE = language;
			Logger.log(file);
			//var i:int = 0;
			//setPageOrder(pages,pages.arr1[1],pages.numChildren-1);
			switch (CommonProperties.LANGUAGE)
			{
				case CommonProperties.CHINESE_T :
					break;
				case CommonProperties.ENGLISH :
					break;
				
			}
			Logger.debug(STATE);
			Logger.debug(CommonProperties.LANGUAGE);
			switch (STATE)
			{
				case PLAYING_SCREEN_SAVER :
					setPageOrder(pages,arr1[1]);
					minterface.switchButtonLanguage();
					flvplayer.setLoop(false);
					STATE = PLAYING_INTRO;
					startVid(arr1[1],file);
				case PLAYING_INTRO :
					//switchLanguage(CommonProperties.LANGUAGE);
					setPageOrder(pages,arr1[1]);
					Logger.debug(file);
					minterface.switchButtonLanguage();
					flvplayer.setLoop(false);
					STATE = PLAYING_INTRO;
					startVid(arr1[1],file);
					break;
				case PLAYING_PREVIEW :
					setPageOrder(pages,arr1[2]);
					minterface.switchButtonLanguage();
					skipIntro();
					break;
				
				case PLAYING_CONTENT :
					
					setPageOrder(pages,arr1[3],false);
					minterface.switchButtonLanguage();
					Logger.debug("targetButtons.path "+targetButtons.path);
					videoBtnPressed(targetButtons.path,targetButtons.caption);
					break;
				
			}
			
			
		}*/
		function NextPage(file:String,caption:String,next_page:String):void
		{
			Logger.log(caption);

			Logger.debug("going to -----------"+next_page);
			if (next_page!="")
			{
				var tmp = minterface.getPageByName(next_page);

				if (tmp)
				{
					tmp.x = 0;
					tmp.y = 0;
					//if(next_page=="p_1_1_1" || pages.getChildByName("p_1_1_1")!=null)
					setPageOrder(pages,tmp,file,false);

				}
			}
			else
			{
				startVid(pages,file);
			}

		}
		function btnPressed(e:MouseEvent):void
		{

			Logger.log("Pressed Button :name ="+ e.target.name);
			//Logger.log(e.target);


			switch (e.target.name)
			{
				case "home" :

					setPageOrder(pages,minterface.getPageByName("p0"),ssFilePath);
					flvplayer.setLoop(true);
					STATE = PLAYING_SCREEN_SAVER;

					break;
				default :
				if(STATE == PLAYING_SCREEN_SAVER)
				{
					fader.draw(this);
				}
				STATE = PLAYING_CONTENT;
					var targetButtons = e.target as customButton;
					if (targetButtons)
					{

						if (targetButtons.path != "")
						{

							client.sendString(targetButtons.xml.MESSAGE);
							NextPage(targetButtons.path,targetButtons.caption,targetButtons.nextPage);
						}
						else
						{
							client.sendString(targetButtons.xml.MESSAGE);
							NextPage("",targetButtons.caption,targetButtons.nextPage);
						}
					}
					break;
			}


		}

		public function startVid(__parent:MovieClip , path:String , _width:int=1920 , _height:int=1080 , _x:int=0 , _y:int=0):void
		{

			if (__parent!=vidParent)
			{
				stopVid();

				vidParent = __parent;
			}
			Logger.info("path to vid: "+path);
			flvplayer.width = _width;
			flvplayer.height = _height;
			flvplayer.x = _x;
			flvplayer.y = _y;
			try
			{
				vidParent.addChild(flvplayer);

				vidParent.setChildIndex(flvplayer,0);//vidParent.numChildren-1);
				flvplayer.startVid(path);
			}
			catch (error:Error)
			{
				Logger.debug(error.message);
			}


		}
		public function stopVid():void
		{

			flvplayer.stopVid();
			try
			{
				if (vidParent)
				{
					vidParent.removeChild(flvplayer);
				}
			}
			catch (error:Error)
			{
				Logger.debug(error.message);
			}


		}


/*		private function skipIntro()
		{
			stopVid();
			startVid(arr1[2],skipBtn.path,1920,1080,0,0);
			if (STATE != PLAYING_PREVIEW)
			{
				setPageOrder(pages,arr1[2]);
				STATE = PLAYING_PREVIEW;
				flvplayer.setLoop(true);
			}
			
			
			ss.resetTimeOut();
		}*/

		//vimeo
		protected function doMediaStarted(evt:MediaEvent):void
		{
			//ss.stop();
			if (config.debugMode)
			{

				Logger.debug("media started playing");
			}
		}

		protected function doMediaFinished(evt:MediaEvent):void
		{
			Logger.debug(STATE);
			switch (STATE)
			{
				case PLAYING_SCREEN_SAVER :
					if (ss.bPlaying)
					{
						Logger.debug("startVid(arr1[0],ssFilePath);");
						startVid(pages,ssFilePath);

					}
					else
					{
						//ss.resetTimeOut();

					}

					break;
/*case PLAYING_INTRO :
					
					//
					//skipIntro();
					
					break;
				case PLAYING_PREVIEW :
					
					break;
				case PLAYING_CONTENT :
					//skipIntro();
					break;*/
				default :
					stopVid();
					break;
			}
			if (config.debugMode)
			{
				Logger.debug("media finished playing");
			}
		}
		protected function doMediaError(evt:MediaEvent):void
		{
			if (config.debugMode)
			{
				//Logger.debug("media error while playing");
			}
		}
		protected function doMediaDuration(evt:MediaTimeEvent):void
		{

			if (config.debugMode)
			{
				//Logger.debug("media is " + evt.time + " seconds long");
			}
		}
		protected function doMediaTime(evt:MediaTimeEvent):void
		{
			//ss.resetTimeOut();
			if (config.debugMode)
			{
				//Logger.debug("media is at " + evt.time + " seconds");
			}
		}
		function playbackFX(snd:*):void
		{
/*var sound:Sound = snd as Sound;
			sc = sound.play();
			st.volume = 0.5;
			sc.soundTransform = st;*/
		}
		function onCompleteFunction(arg0:*,arg1:*,arg2:*,arg3:*):void
		{
			try
			{
				
				if (arg2!=arg1)
				{
					oldSprite = arg1;
					//   while (arg0.numChildren>0)
					{
						arg0.removeChild(arg1);
					};
				}
				else
				{
					Logger.warning("arg2 == arg1" +arg2.name);
				}
				startVid(arg0,arg3);
				arg0.addChild(arg2);


				//_parent.setChildIndex(sprite,0);
			}
			catch (error:Error)
			{
				Logger.debug(error.message);
			}
		}
		//==================================================================================================================================
		private function setPageOrder(_parent:Sprite , sprite:Sprite,file:String,isFadeIn:Boolean=false,isFade:Boolean=false):void
		{
			//
			if (isFade)
			{

				//fader.draw(_parent);
				var tmp = _parent.getChildAt(_parent.numChildren - 1);
				var tmp_ = tmp.getChildAt(0) as customBackground;
				if (tmp!=sprite)
				{

					//Logger.debug("tmp_.outPt.x ---"+tmp_.outPt.x);
					//TweenMax.to(tmp,(tmp_.outPt.x!=tmp_.inPt.x)?2:0,{x:tmp_.outPt.x,onComplete:onCompleteFunction,onCompleteParams:[_parent,tmp,sprite,file]});
					if (isFadeIn)
					{
						TweenMax.to(tmp,2,{x:-960,onComplete:onCompleteFunction,onCompleteParams:[_parent,tmp,sprite,file]});

						//var tmp2 = sprite.getChildAt(0) as customBackground;
						//Logger.debug("tmp2.inPt.x ---"+tmp2.inPt.x);
						//TweenMax.to(sprite,(tmp2.outPt.x!=tmp2.inPt.x)?2:0,{x:tmp2.inPt.x});
						TweenMax.to(sprite,2,{x:0});
						sprite.x = 960;
					}
					else
					{
						TweenMax.to(tmp,2,{x:960,onComplete:onCompleteFunction,onCompleteParams:[_parent,tmp,sprite,file]});
						TweenMax.to(sprite,2,{x:0});
						sprite.x = -960;
					}

					_parent.addChild(sprite);
					//sprite.x = tmp2.outPt.x;
					flvplayer.setLoop(false);
				}

			}
			else
			{
				while (_parent.numChildren>0)
				{
					_parent.removeChildAt(0);
				}
				_parent.addChild(sprite);
				startVid(_parent as MovieClip,file);
				flvplayer.setLoop(false);

			}

			///_parent.setChildIndex(sprite,_parent.numChildren-1);
		}

	}
}