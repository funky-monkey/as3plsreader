package nl.funkymonkey.utils.io.playlist.events 
{	import flash.events.Event;
	import flash.filesystem.File;		
	/**	 * @author sidneydekoning	 */	public class ParseEvent extends Event {
		public static const FILE_PARSED:String = "ParseEvent.FILE_PARSED";
		private var _extension:String;
		private var _parsedFile:File;

		
		public function ParseEvent(eType : String, parsedFile:File, extension:String, pBubbles : Boolean = false, eCancelable : Boolean = false) 
		{
			super(eType, pBubbles, eCancelable);
			
			_parsedFile = parsedFile;
			_extension = extension;
		}
		
		public function get fileData():File {
			return _parsedFile;
		}
		
		public function get extension():String {
			return _extension;
		}

		override public function clone():Event
		{
			return new ParseEvent(type, _parsedFile, _extension, bubbles, cancelable);
		}
	}}