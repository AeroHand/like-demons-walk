package {
	import flash.display.MovieClip;

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
		//constructor, you usually will use onLoaded() instead
		
		public function CustomUI() : void {
			trace("start this ui");
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
			this.www.visible=false;
			this.aaa.visible=false;
			this.sss.visible=false;
			this.ddd.visible=false;
			globals.GameInterface.AddKeyInputConsumer();
			this.stage.addEventListener(KeyboardEvent.KEY_DOWN,keyDown);
			this.stage.addEventListener(KeyboardEvent.KEY_UP,keyUp);
			
		}
		    
	   function keyDown(e:KeyboardEvent):void {
		  trace("down") 
		   
	     switch (e.charCode) {
			   case 119:                                 //监听按下事件
			     this.www.visible=true;                  //w按钮变色
				 this.gameAPI.SendServerCommand("UpWalking");  //发送控制台命令 让单位往上走
				 break;
			   case 97:
			     this.aaa.visible=true;
				 this.gameAPI.SendServerCommand("LeftWalking");
				 break;
			   case 115:
			     this.sss.visible=true;
				 this.gameAPI.SendServerCommand("DownWalking");
				 break;
			   case 100:
			     this.ddd.visible=true;
				 this.gameAPI.SendServerCommand("RightWalking");
				 break;
			   
		   }
		 //this.gameAPI.SendServerCommand( "player_key_down " + e.keyCode.toString());  
        }
			
	   function keyUp(e:KeyboardEvent):void {
		  trace("up") 
		   
	     switch (e.charCode) {
			   case 119:  //w
			     this.www.visible=false;
				 this.gameAPI.SendServerCommand("UpWalkingDone");
				 break;
			   case 97:
			     this.aaa.visible=false;
				 this.gameAPI.SendServerCommand("LeftWalkingDone");
				 break;
			   case 115:
			     this.sss.visible=false;
				 this.gameAPI.SendServerCommand("DownWalkingDone");
				 break;
			   case 100:
			     this.ddd.visible=false;
				 this.gameAPI.SendServerCommand("RightWalkingDone");
				 break;
			   
		   }
		   //this.gameAPI.SendServerCommand( "player_key_up " + e.keyCode.toString());
        }
						
		//this handles the resizes - credits to Nullscope
		public function onResize(re:ResizeManager) : * {

		}
	}
}