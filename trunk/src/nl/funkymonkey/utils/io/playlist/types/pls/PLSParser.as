package nl.funkymonkey.utils.io.playlist.types.pls 
{
	import nl.funkymonkey.firelog.core.Logger;
	import nl.funkymonkey.utils.io.playlist.FileHeader;
	import nl.funkymonkey.utils.io.playlist.error.ParseError;	
	/**
	 * PLSParser -- Parses a PLS file
	 * 
	 * @description: Parses a PLS file and returns an PLSFile Object
	 * 
	 * NOTES:
	 * 
	 * Kijk goed naar http://code.google.com/p/as3corelib/source/browse/trunk/src/com/adobe/fileformats/vcard/VCardParser.as
	 * als manier om te parsen, string functies als search
	 * 
	 * For complete pls file specification see below:
	 * 
	 * "[playlist]": 
	 * Signifies that this is a PLS playlist. This is case sensitive.
	 * 
	 * "File#=":
	 * Location of the file in any of the formats described above. This is also case sensitive. 
	 * Also the # sign after "File" signifies what file number it is. 
	 * The first file in the playlist is "File1", the second is "File2" and so on.
	 * 
	 * "Title#=": 
	 * Title to display. This is usually the title read from the file name or ID3 tags. 
	 * Like the other fields, this is case sensitive. This also can be the name of a stream. 
	 * Like "File#" the pound sign (#) is replaced by the entry number that is in the PLS playlist.
	 * 
	 * "Length#=": 
	 * Length in seconds, this is also case sensitive. On the last entry there is a negative one, 
	 * this is usually seen on streams, it tells the program to ignore the time entry. 
	 * Like "File#" the pound sign (#) is replaced by the entry number that is in the PLS playlist.
	 * 
	 * "NumberOfEntries=#": 
	 * The total number of entries in the playlist. 
	 * This should match the last number on the "File#", "Title#", and "Length#" fields. 
	 * Also case sensitive.
	 * 
	 * "Version=2": 
	 * This required entry near the bottom tells the player what format the PLS is in. 
	 * Older versions of the PLS playlist format did not include this. Like everything else, 
	 * it is case sensitive.
	 * 
	 * EXAMPLE FILE:
	 * 
	 * [playlist]
	 * File1=C:\My Music\Pink Floyd\1979---The_Wall_CD1\1.In_The_Flesh.mp3
	 * Title1=Pink Floyd - In The Flesh
	 * Length1=199
	 * File2=C:\My Music\Pink Floyd\1979---The_Wall_CD1\10.One_Of_My_Turns.mp3
	 * Title2=Pink Floyd - One Of My Turns
	 * Length2=217
	 * NumberOfEntries=2
	 * Version=2
	 * 
	 *  
	 * FIXME:
	 * 
	 * 
	 * 
	 * 		
	 * @author Sidney de Koning, sidney@funky-monkey.nl
	 */
	public class PLSParser {
		private static var _parsedFile:Array;						public static function parse( data:String ):Array
		{
			_parsedFile = new Array();
			// Handle specific parsing of PLS files
			if (FileHeader.checkHeader( data ) ) {	
							
				// do the actual parsing, loop through the complete string and search for specific elements
				// return an Array with file objects or custom PLS Objects
				Logger.info(data);
				_parsedFile.push(data);
			} else {
				throw new ParseError( "Specified file is not a PLS file, make sure you pass through the correct file");
			}
			
			return _parsedFile;
		}
		
		
//		private function parsePLS():void
//		{
//			// Handle specific parsing of PLS files
//			// Find position of NumberOfEntries
//			var numberOfEntriesNeedle:String = "NumberOfEntries=";
//			var numberOfEntriesPosition:Number = _fileData.search(numberOfEntriesNeedle);
//			_fileStream.position = numberOfEntriesPosition;
//
//			var numberOfEntriesMarker:String 	= _fileData.substring(_fileStream.position, _fileStream.position + numberOfEntriesNeedle.length + 2);
//			var numberOfEntries:String 			= numberOfEntriesMarker.substr(numberOfEntriesNeedle.length, numberOfEntriesNeedle.length-2);
//			var numberOfE:Number 				= Number(numberOfEntries);
//			
//			for (var i:Number = 1; i < numberOfE + 1; i++ )
//			{
//				// loop numberOfE times through file, search for first occurence of:
//				// "File" + i +"=" until loop hits "Title" (2 chars before)
//				// "Title" + i +"=" until loop hits "Length" (2 chars before)
//				// "Length" + i +"="
//				// everytime update the position property
//				_fileStream.position = 0;
//				//
//				var fileMarkerNeedle:String 		= "File" 	+ i +"=";
//				var secondFileMarkerNeedle:String 	= "File" 	+ i+1 +"=";
//				var titleMarkerNeedle:String 		= "Title" 	+ i +"=";
//				var lengthMarkerNeedle:String 		= "Length" 	+ i +"=";
//				
//				var filePosition:Number 		= _fileData.search(fileMarkerNeedle);				
//				var secondFilePosition:Number 	= _fileData.search(fileMarkerNeedle);
//				var titlePosition:Number 		= _fileData.search(titleMarkerNeedle);
//				var lengthPosition:Number 		= _fileData.search(lengthMarkerNeedle);
//				
//				var fileEntry:String 	= _fileData.substring(filePosition + fileMarkerNeedle.length, titlePosition-2);
//				var titleEntry:String 	= _fileData.substring(titlePosition + titleMarkerNeedle.length, lengthPosition - 2);
//				// FIXME: Fix the final iteration of this loop for the length property we want to get out
//				// TODO:  Maybe use regexp to get values out and loop through them?
//				var lengthEntry:String 	= _fileData.substring(lengthPosition + lengthMarkerNeedle.length, secondFilePosition);
//				
//				Logger.info("POSITION OF " +"File"+ i +"="+ "   : " + filePosition);
//				Logger.info("POSITION OF " +"Title"+ i +"="+ "  : " + titlePosition);
//				Logger.info("POSITION OF " +"Length"+ i +"="+ " : " + lengthPosition);
//				Logger.info( "FILE   : " + fileEntry );
//				Logger.info( "TITLE  : " + titleEntry );
//				Logger.info( "LENGHT : " + lengthEntry );
//			}
//			_fileStream.close();
//		}
	}
}
