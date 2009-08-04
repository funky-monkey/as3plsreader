package nl.funkymonkey.utils.io.playlist.types.m3u {
	import nl.funkymonkey.utils.io.playlist.types.FileExtensions;	
	import nl.funkymonkey.utils.io.playlist.types.FileHeader;
	import nl.funkymonkey.utils.io.playlist.error.ParseError;					

	/**
	 * M3UParser -- Parses a M3U file
	 * 
	 * @description: Parses a M3U file and returns an PLSFile Object
	 * 
	 * More information on the M3U format
	 * @see http://hanna.pyxidis.org/tech/m3u.html	 * @see http://en.wikipedia.org/wiki/M3U
	 * @see http://forums.winamp.com/showthread.php?threadid=65772	 * @see http://schworak.com/programming/music/playlist_m3u.asp
	 * 
	 * File Extended M3U
	 * 
	 * #EXTM3U
	 * #EXTINF:233,Everclear - So Much For The Afterglow
	 * Alternative\everclear_SMFTA.mp3
	 * #EXTINF:227,Weird Al - Everything You Know Is Wrong
	 * Comedy\Weird_Al_Everything_You_Know_Is_Wrong.mp3
	 * #EXTINF:187,Weird Al Yankovic - This is the Life
	 * Weird_Al_This_Is_The_Life.mp3
	 * #EXTINF:129,Weird Al: Bad Hair Day - Gump
	 * http://www.site.com/~user/gump.mp3
	 * #EXTINF:-1,My Cool Stream
	 * http://www.site.com:8000/listen.pls
	 * 		
	 * @author Sidney de Koning, sidney@funky-monkey.nl
	 */
	public class M3UParser {

		private static const NEEDLE_FILE_BEGIN:String = FileExtensions.M3U;		private static const NEEDLE_FILE:String = "#EXTINF:";
		private static const NEEDLE_SEPERATOR:String = ",";
		private static const NEEDLE_NEWLINE:String = "\n";
		
		public function parse( data:String ):void {
			// Handle specific parsing of PLS files
			if (FileHeader.checkHeader( data, FileExtensions.M3U ) ) {
				
				// do the actual parsing, loop through the complete string and search for specific elements
			} else {
				throw new ParseError( "Specified file is not a M3U file, make sure you pass through the correct file" );
			}
		}

		public function get result():void {
			// return File object, so we can pass this through to any program that handles loading of music files
		}
	}
}
