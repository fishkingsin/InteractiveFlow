package 
{
	import gs.TweenMax;
	import flash.display.*;
	import flash.events.*;

	public class customDropDownList extends Sprite
	{

		public var items:Vector.<customButton> = new Vector.<customButton>();

		public var isDropped = false;
		public function customDropDownList(arg:Vector.<customButton>)
		{
			// constructor code

			var count:int = 0;
			var prevy:int = 0;
			for (var i:int; i < arg.length; i++)
			{
				var mc = arg[i];

				if (i==0)
				{
					mc.addEventListener(MouseEvent.CLICK, function onClicked(e:MouseEvent):void{
					 onClick();
					
					 });

				}
				else	
				{
					 mc.addEventListener(MouseEvent.CLICK,function _onClicked(e:MouseEvent)
						 {
							 closeList();
							 dispatchEvent(new Event("CLOSE"));
						 });

					items.push(mc);
				}
				addChild(mc);
				setChildIndex(mc,0);
				mc.y = 0;
			}

		}
		function closeList():void
		{
			if (isDropped)
			{
				isDropped = false;
				for (var i:int; i < items.length; i++)
				{
					var mc = items[i];
					TweenMax.to(mc,1,{y:0,onUpdate:onUpdateFunction});
				}
			}
		}
		function onClick():void
		{
			isDropped = ! isDropped;
			if (isDropped)
			{
				for (var i:int; i < items.length; i++)
				{
					var mc = items[i];
					TweenMax.to(mc,1,{y:mc.height*(i+1),onUpdate:onUpdateFunction});
				}

			}
			else
			{
				for (var i:int; i < items.length; i++)
				{
					var mc = items[i];
					TweenMax.to(mc,1,{y:0,onUpdate:onUpdateFunction});
				}
			}
		}
		function onUpdateFunction()
		{
			dispatchEvent(new Event("UPDATE"));
		}
		public function pushParent(mc:Sprite):void
		{
/*removeChild(_parent);
			_parent = mc;
			addChild(_parent);*/

		}
		public function pushItem(mc:Sprite):void
		{
/*items.push(mc);
			addChild(mc);*/

		}
		public function pushItems(_items:Vector.<SmoothingBitmapLoader> ):void
		{
/*items = _items;*/
		}

	}

}