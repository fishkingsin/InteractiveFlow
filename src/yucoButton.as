﻿
package 
{
	import flash.text.*;
	import flash.display.*;
	import flash.events.*;
	public class yucoButton extends SimpleButton
	{
		var textField1:TextField;
		var textField2:TextField;
		var spriteWidth:int;
		var spriteHeight:int;
		public function yucoButton()
		{

		}
		public function setup(_lable:String ,X:int,Y:int, index:int ,sprites:Array, format1:TextFormat )//Vector.<Sprite>)
		{
			if (sprites.length == 0)
			{
				trace("sprites is empty please insert valid sprites:Vector.<Sprite>");
				return;
			}
			else
			{
				//for each(var s:Sprite in sprites)
				//trace(s);
			}
/*			// constructor code
			var format:TextFormat=new TextFormat();
			//var font:Font1=new Font1();
			format.font = font1.fontName;

			format.color = 0xFFFFFF;
			format.size = 36;
			format.align = TextFormatAlign.LEFT;*/

			if (_lable!="")
			{
				textField1 = new TextField();
				textField2 = new TextField();

				textField1.antiAliasType = AntiAliasType.ADVANCED;
				textField1.embedFonts = true;
				textField1.autoSize = TextFieldAutoSize.CENTER;
				textField1.name = "textField1";
				textField1.mouseEnabled = false;
				textField1.defaultTextFormat = format1;

				textField2.name = "textField2";
				textField2.mouseEnabled = false;
				textField2.defaultTextFormat = format1;
				textField2.antiAliasType = AntiAliasType.ADVANCED;
				textField2.embedFonts = true;
				textField2.autoSize = TextFieldAutoSize.CENTER;
			}
			this.upState = sprites[0];
			(sprites[1]!=null)?this.downState = sprites[1]:this.downState = sprites[0];
			//(sprites[2]!=null)?this.overState = sprites[2]:
			this.overState = sprites[0];
			//(sprites[3]!=null)?this.hitTestState = sprites[3]:
			this.hitTestState = sprites[0];


			if (_lable!="")
			{

				sprites[0].addChild(textField1);
				sprites[0].addEventListener(SmoothingBitmapLoader.INIT,function Inited(e:Event):void{
				  var scale:Number = textField1.width/sprites[0].width;
				  spriteWidth = sprites[0].width;
				  spriteHeight = sprites[0].height;
				  textField1.x = 0;//spriteWidth/2-textField1.width/2;
				  textField1.y = spriteHeight/2-textField1.height/2;
				  });
			}

			if (_lable!="")
			{
				sprites[1].addChild(textField2);
				this.downState.addEventListener(SmoothingBitmapLoader.INIT,function Inited(e:Event):void{
				  var scale:Number = textField2.width/sprites[1].width;
				  spriteWidth = sprites[1].width;
				  spriteHeight = sprites[1].height;
				  //textField2.x = spriteWidth/2-textField2.width/2;
				  textField2.y = spriteHeight/2-textField2.height/2;
				  });
			}

			this.x = X;
			this.y = Y;
			changeText(_lable,format1);

		}

		function changeSprite(sprites:Array)
		{
			this.upState = sprites[0];
			(sprites[1]!=null)?this.downState = sprites[1]:this.downState = sprites[0];
			this.overState = sprites[0];
			this.hitTestState = sprites[0];

			if (textField1)
			{
				sprites[0].addChild(textField1);

				//var scale:Number = textField1.width / sprites[0].width;
				textField1.x = 0;//sprites[0].width / 2 - textField1.width / 2;
				//textField1.y = sprites[0].height / 2 - textField1.height / 2;
				//textField1.x = spriteWidth / 2 ;//- textField1.width / 2;
				//textField1.y = spriteHeight / 2 - textField1.height / 2;
			}
			if (textField2)
			{
				sprites[1].addChild(textField2);
				//var scale:Number = textField2.width / sprites[1].width;
				textField2.x = 0;//sprites[1].width / 2 - textField2.width / 2;
				//textField2.y = sprites[1].height / 2 - textField2.height / 2;
				//textField2.x = spriteWidth / 2 ;//- textField2.width / 2;
				//textField2.y = spriteHeight / 2 - textField2.height / 2;
			}
		}
		function changeText(text:String , format:TextFormat=null):void
		{
			
			
			if (textField1)
			{
				var sbs:DisplayObjectContainer = DisplayObjectContainer(this.upState);
				var tf:TextField = TextField(sbs.getChildByName("textField1"));
				if (format!=null)
				{
					tf.defaultTextFormat = format;
				}
				//tf.x = sbs.width / 2 - tf.width / 2;
				//tf.y = sbs.height / 2 - tf.height / 2;
				//spriteWidth / 2;// - textField1.width / 2;
				//textField1.y = spriteHeight / 2 - textField1.height / 2;
				tf.text = text;
				tf.x = 0;
			}
			if (textField2)
			{
				var sbs:DisplayObjectContainer = DisplayObjectContainer(this.downState);
				var tf:TextField = TextField(sbs.getChildByName("textField2"));
				if (format!=null)
				{
					tf.defaultTextFormat = format;
				}
				//tf.x = sbs.width / 2- tf.width / 2;
				//tf.y = sbs.height / 2 - tf.height / 2;
				//spriteWidth / 2;// - textField2.width / 2;
				//textField2.y = spriteHeight / 2 - textField2.height / 2;
				tf.text = text;
				
				tf.x = 0;
				
			}


		}

	}

}