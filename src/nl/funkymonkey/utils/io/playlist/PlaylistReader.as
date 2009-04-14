package nl.funkymonkey.utils.io.playlist 
{
	import nl.funkymonkey.utils.io.playlist.events.ParseEvent;
	import nl.funkymonkey.utils.io.playlist.types.pls.PLSParser;
	
	import flash.events.*;
	import flash.filesystem.*;	
	/**
	 * PlaylistReader -- Reads in a PLS, M3U or XSPF
	 * 
	 * @description: Reads in playlist formats async manner
	 * 
	 * TODO: 
	 * 		- Add support for B4S  -- WinAmp3 XML Based playlist format
	 * 		- Add support for M3U  -- WinAmp3 XML Based playlist format
	 * 		- Add support for XSPF -- WinAmp3 XML Based playlist format
	 * 		- Maybee nice to return the user with a custom PLSFile Object containing file's size, type, name, location, 
	 * 		extension and duration (PLS extends File)
	 * 		- Check during parsing if loaded file is truly of input type -- else throw error
	 * 
	 * NOTES:
	 * 
	 * FIXME:
	 * 
	 * USE:
	 * 
	 * // import appropriate files
	 * import nl.funkymonkey.utils.io.playlist.PlaylistReader;
	 * import flash.filesystem.*;
	 * 
	 * // make a reference to a file on the desktop
	 * var plsFile:File = File.desktopDirectory.resolvePath("default.pls");
	 * 
	 * // instanciate new PlayListReader object with file reference
	 * var pls:PlaylistReader = new PlaylistReader();
	 * pls.addEventListener(ParseEvent.FILE_PARSED, parsedPLS, false, 0, true);
	 * pls.source = plsFile;
	 * 
	 * private function parsedPLS( evt:ParseEvent):void {
	 * 		var plsFile:PLSFile = evt.target.fileData as PLSFile.
	 * 		
	 * }
	 * 
	 * 		
	 * @author Sidney de Koning, sidney@funky-monkey.nl
	 */
	public class PlaylistReader extends EventDispatcher {
		// CONSTANTS AND STATICS
		private static var VERSION	:String = "1.0.1";
		private static var AUTHOR	:String = "Sidney de Koning";
		//
		private var _file			:File;
		private var _fileStream		:FileStream;
		private var _fileData		:String;
		//		
		//
		function PlaylistReader( ) {			
		}
		
		public function set source( value:File ):void
		{
			_file = value;			
			load();			
		}
		
		public function get result():void
		{
			// return File object, so we can pass this through to any program that handles loading of music files
		}
		
		private function load():void
		{
			_fileStream = new FileStream();
			_fileStream.addEventListener(Event.COMPLETE, 			handleFileReadComplete);
			_fileStream.addEventListener(Event.OPEN, 				handleFileOpenComplete);
			_fileStream.addEventListener(ProgressEvent.PROGRESS, 	handleProgress);
			_fileStream.addEventListener(IOErrorEvent.IO_ERROR, 	handleIOError);
			
			_fileStream.openAsync(_file, FileMode.READ);
		}
		
		public function get source():File
		{
			return _file;
		}
			
		
		private function handleFileReadComplete(evt:Event):void
		{
			trace("Binary file loaded --> ASYNC");
			trace(extension.toUpperCase());
			
			doFileParse( );
		}
		
		
		private function doFileParse():void {
			
			_fileData = _fileStream.readMultiByte(_fileStream.bytesAvailable, File.systemCharset);

			var fileObj:File;
			switch(extension.toUpperCase())
			{
				case "PLS":
					// Handle specific parsing of PLS files
					fileObj = PLSParser.parse( _fileData );
					break;
				case "M3U":
					// Handle specific parsing of M3U files
					fileObj = PLSParser.parse( _fileData );
					break;
				case "XSPF":
					// Handle specific parsing of XSPF files
					fileObj = PLSParser.parse( _fileData );
					break;
			}
			
			dispatchEvent(new ParseEvent(ParseEvent.FILE_PARSED, fileObj, extension));
		}

		
		private function handleFileOpenComplete(evt:Event):void
		{
			
		}
		private function handleProgress(evt:ProgressEvent):void
		{
			trace(_fileStream.position +" :: "+ _fileStream.bytesAvailable);
		}
		
		private function handleIOError(ioError:IOErrorEvent):void
		{
			// POSSIBLE SCENARIOS:
			// The file does not exist; you do not have adequate permissions to open the file; 
			// you are opening a file for read access, and you do not have read permissions; 
			// or you are opening a file for write access, and you do not have write permissions.
		}
		
		public function get extension():String
		{
			return _file.extension;			
		}
		
		public function get version():String
		{
			return VERSION;
		}
		
		public function get author():String
		{
			return AUTHOR;
		}
	}
}
