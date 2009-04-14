package nl.funkymonkey.utils.io.playlist.types.b4s 
{
	import nl.funkymonkey.utils.io.playlist.FileHeader;				
	/**
	 * B4SParser -- Parses a B4S file
	 * 
	 * @description: Parses a B4S file and returns an PLSFile Object

	 * 
	 * 		
	 * @author Sidney de Koning, sidney@funky-monkey.nl
	 */
	public class B4SParser {

		public function parse( data:String ):void
		{
			// Handle specific parsing of PLS files
			if (FileHeader.checkHeader( data ) ) {
				
				// do the actual parsing, loop through the complete string and search for specific elements
			}
		}
		
		public function get result():void
		{
			// return File object, so we can pass this through to any program that handles loading of music files
		}
	}
}
