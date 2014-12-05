package {
	import flash.display.MovieClip;
    import flash.events.MouseEvent;
	//import some stuff from the valve lib
	import ValveLib.Globals;
	import ValveLib.ResizeManager;
	import ValveLib.Events.InputBoxEvent;
	import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    import flash.events.Event;
	
	public class CustomUI extends MovieClip{
		
		//these three variables are required by the engine
		public var gameAPI:Object;
		public var globals:Object;
		public var elementName:String;
		var kg:Number=0;
		//constructor, you usually will use onLoaded() instead
		
		public function CustomUI() : void {
			trace("start this ui");
			
			this.sb.x1.addEventListener(MouseEvent.CLICK,onMenu_x1);
			
			this.sb.tf2.visible=false;
		}

		
		//this function is called when the UI is loaded
		public function onLoaded() : void {			
			//make this UI visible
			visible = true;
			trace("start onloaded");
			
			//let the client rescale the UI
			Globals.instance.resizeManager.AddListener(this);
			
			//this is not needed, but it shows you your UI has loaded (needs 'scaleform_spew 1' in console)
			trace("Custom UI loaded!!!!!!!!");

			this.sb.x1.addEventListener(MouseEvent.CLICK,onMenu_x1);
			
			this.sb.tf2.visible=false;

			
			
			
			
			
			
		}
		    
			
		 public function onMenu_x1(dd:MouseEvent):void
		{
			trace("about");
			//this.mTaskPanel.CreateBtn();
		    if (kg==0) {
			  this.sb.tf2.visible=true;
			  this.sb.tf1.visible=false;
			  kg=1;
			}else {
				this.sb.tf2.visible=false;
				this.sb.tf1.visible=true;
				kg=0;
			}
		   
		 //  this.mTaskPanel.CreateBtn();
			
		}		
	
						
		//this handles the resizes - credits to Nullscope
		public function onResize(re:ResizeManager) : * {
			
			this.sb.x=stage.stageWidth;
			this.sb.y=stage.stageHeight;
			
			this.sb.height=this.sb.height*stage.stageWidth/1000*118/this.sb.width*2;
			
			this.sb.width=stage.stageWidth/1000*118*2;
			

		}
	}
}