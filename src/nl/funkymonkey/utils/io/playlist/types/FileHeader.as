package nl.funkymonkey.utils.io.playlist.types 
{	/**
	 * FileHeader -- Constants to check file headers for parsing
	 * 
	 * @description: Constants to check file headers for parsing
	 * 		
	 * @author Sidney de Koning, sidney@funky-monkey.nl
	 */
	public class FileHeader 
	{
		// CONSTANTS AND STATICS
		public static const PLS_FILE:String = "[playlist]";		public static const B4S_FILE:String = "[b4s]";
		//
		
		public static function checkHeader( head:String, extension:String ):Boolean {
			
			var headerCheck:Boolean = false;
			
			switch(extension.toUpperCase()) {
				
				case "PLS":
					if(head.indexOf(PLS_FILE) != -1) {
						headerCheck = true;
					}
					break;
				case "B4S":
					if(head.indexOf(B4S_FILE) != -1) {
						headerCheck = true;
					}
					break;
			}
			return headerCheck;
		}
	}
}
