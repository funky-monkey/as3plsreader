package nl.funkymonkey.utils.io.playlist.types.pls 
{	/**
	 * 
	 * PLS File - Same properties as one entry in a PLS playlist
	 * 	 * @author sidneydekoning	 */	public class PLSFile {
		private var _url:String;		private var _length:int;
		private var _title:String;

		
		public function PLSFile() {
			// does notting		}

		
		public function set file(pValue:String):void {
			_url = pValue;
		}

		
		public function set title(pValue:String):void {
			_title = pValue;
		}

		
		public function set length(pValue:int):void {
			_length = pValue;
		}

		
		public function get file():String {
			return _url;
		}

		
		public function get length():int {
			return _length;
		}

		
		public function get title():String {
			return _title;
		}
	}}