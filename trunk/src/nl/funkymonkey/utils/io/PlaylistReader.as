package nl.funkymonkey.utils.io.playlist 
{
	import flash.events.*;
	import flash.filesystem.*;
	import AirLogger;
	
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
	 * @author Sidney de Koning, sidney@funky-monkey.nl
	 */
	public class PlaylistReader 
	{
		// CONSTANTS AND STATICS
		private static var VERSION		:String = "1.0.0";
		private static var AUTHOR		:String = "Sidney de Koning";
		//
		private var _file				:File;
		private var _fileStream			:FileStream;
		private var _fileData			:String;
		//		
		function PlaylistReader( )
		{			
			AirLogger.init("playlistTest.txt");
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
		
		private function parsePLS():void
		{
			// Handle specific parsing of PLS files
			// Find position of NumberOfEntries
			var numberOfEntriesNeedle:String = "NumberOfEntries=";
			var numberOfEntriesPosition:Number = _fileData.search(numberOfEntriesNeedle);
			_fileStream.position = numberOfEntriesPosition;

			var numberOfEntriesMarker:String 	= _fileData.substring(_fileStream.position, _fileStream.position + numberOfEntriesNeedle.length + 2);
			var numberOfEntries:String 			= numberOfEntriesMarker.substr(numberOfEntriesNeedle.length, numberOfEntriesNeedle.length-2);
			var numberOfE:Number 				= Number(numberOfEntries);
			
			for (var i:Number = 1; i < numberOfE + 1; i++ )
			{
				// loop numberOfE times through file, search for first occurence of:
				// "File" + i +"=" until loop hits "Title" (2 chars before)
				// "Title" + i +"=" until loop hits "Length" (2 chars before)
				// "Length" + i +"="
				// everytime update the position property
				_fileStream.position = 0;
				//
				var fileMarkerNeedle:String 		= "File" 	+ i +"=";
				var secondFileMarkerNeedle:String 	= "File" 	+ i+1 +"=";
				var titleMarkerNeedle:String 		= "Title" 	+ i +"=";
				var lengthMarkerNeedle:String 		= "Length" 	+ i +"=";
				
				var filePosition:Number 		= _fileData.search(fileMarkerNeedle);				
				var secondFilePosition:Number 	= _fileData.search(fileMarkerNeedle);
				var titlePosition:Number 		= _fileData.search(titleMarkerNeedle);
				var lengthPosition:Number 		= _fileData.search(lengthMarkerNeedle);
				
				var fileEntry:String 	= _fileData.substring(filePosition + fileMarkerNeedle.length, titlePosition-2);
				var titleEntry:String 	= _fileData.substring(titlePosition + titleMarkerNeedle.length, lengthPosition - 2);
				// FIXME: Fix the final iteration of this loop for the length property we want to get out
				// TODO:  Maybe use regexp to get values out and loop through them?
				var lengthEntry:String 	= _fileData.substring(lengthPosition + lengthMarkerNeedle.length, secondFilePosition);
				
				//AirLogger.log("POSITION OF " +"File"+ i +"="+ "   : " + filePosition);
				//AirLogger.log("POSITION OF " +"Title"+ i +"="+ "  : " + titlePosition);
				//AirLogger.log("POSITION OF " +"Length"+ i +"="+ " : " + lengthPosition);
				AirLogger.log( "FILE   : " + fileEntry );
				AirLogger.log( "TITLE  : " + titleEntry );
				//AirLogger.log( "LENGHT : " + lengthEntry );
				//AirLogger.newLine();
			}
			_fileStream.close();
		}
		
		private function parseM3U():void
		{
			AirLogger.log("Function Call: parseM3U");
			// Handle specific parsing of M3U files
			AirLogger.log(_fileData);
			//_numberOfEntries = _fileStream.readMultiByte(_fileStream.bytesAvailable, File.systemCharset);
			//_fileStream.close();
		}
		
		private function parseXSPF():void
		{
			// Handle specific parsing of XSPF files
			//_fileStream.close();
		}
		
		public function get extension():String
		{
			return _file.extension;			
		}
		
		public function get version():String
		{
			return VERSION;
		}
		
		private function handleFileReadComplete(evt:Event):void
		{
			AirLogger.log("Binary file loaded --> ASYNC");

			AirLogger.log(extension.toUpperCase());
			_fileData = _fileStream.readMultiByte(_fileStream.bytesAvailable, File.systemCharset);

			switch(extension.toUpperCase())
			{
				case "PLS":
					parsePLS();
				break;
				case "M3U":
					parseM3U();
				break;
				case "XSPF":
					parseXSPF();
				break;
			}
		}
		
		private function handleFileOpenComplete(evt:Event):void
		{
			
		}
		private function handleProgress(evt:ProgressEvent):void
		{
			AirLogger.log(_fileStream.position +" :: "+ _fileStream.bytesAvailable);
		}
		
		private function handleIOError(ioError:IOErrorEvent):void
		{
			// POSSIBLE SCENARIOS:
			// The file does not exist; you do not have adequate permissions to open the file; 
			// you are opening a file for read access, and you do not have read permissions; 
			// or you are opening a file for write access, and you do not have write permissions.
		}
	}
}
