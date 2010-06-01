package {
	
	import flash.display.MovieClip;
	import nl.funkymonkey.io.playlist.error.ParseError;
	import nl.funkymonkey.io.playlist.events.ParseEvent;
	
	import nl.funkymonkey.io.playlist.types.IPlayable;
	import nl.funkymonkey.io.playlist.types.FileExtensions;
	import nl.funkymonkey.io.playlist.types.FileHeader;
	
	import nl.funkymonkey.io.playlist.types.b4s.B4SParser;
	
	import nl.funkymonkey.io.playlist.types.m3u.M3UParser;
	import nl.funkymonkey.io.playlist.types.m3u.M3UFile;
	
	import nl.funkymonkey.io.playlist.types.pls.PLSParser;
	import nl.funkymonkey.io.playlist.types.pls.PLSFile;
	
	import nl.funkymonkey.io.playlist.PlaylistReader;
	
		
	public class Packager extends MovieClip{
		
		
		public function Packager(){
			// you need to refer to a master class and all other classes you will be using.
			// for this case, we only want to use ASampleClass
			var a:Array = [ParseError, ParseEvent, IPlayable, FileExtensions, FileHeader, B4SParser, M3UParser, M3UFile, PLSParser, PLSFile, PlaylistReader];
		}
	}
}
