package nl.funkymonkey.utils.io.playlist.types.pls 
{
	import nl.funkymonkey.firelog.core.Logger;
	import nl.funkymonkey.utils.io.playlist.error.ParseError;
	import nl.funkymonkey.utils.io.playlist.types.FileExtensions;
	import nl.funkymonkey.utils.io.playlist.types.FileHeader;		
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

		private static const NEEDLE_NO_OF_ENTRIES:String = "NumberOfEntries=";		private static const NEEDLE_FILE:String = "File";		private static const NEEDLE_TITLE:String = "Title";		private static const NEEDLE_LENGTH:String = "Length";		private static const NEEDLE_NEWLINE:String = "\n";
		private static var _parsedFile:Array;
		
		public static function parse( data:String ):Array {
			
			_parsedFile = new Array( );
			// Handle specific parsing of PLS files
			if (FileHeader.checkHeader( data , FileExtensions.PLS ) ) 
			{	
				// do the actual parsing, loop through the complete string and search for specific elements
				// return an Array with file objects or custom PLS Objects				
				var noOfEntriesPos:int = data.search( NEEDLE_NO_OF_ENTRIES );
				
				if(noOfEntriesPos != -1) 
				{
					var noOfEntriesMarker:int = data.indexOf( NEEDLE_NEWLINE , noOfEntriesPos );
					
					var noOfEntries:String = data.substring( noOfEntriesPos + NEEDLE_NO_OF_ENTRIES.length , noOfEntriesMarker );					var entriesLength:int = int( noOfEntries );
					
					for (var i:Number = 1; i < entriesLength +1 ; i++ ) {
						
						var fileNeedle:String 	= NEEDLE_FILE + i + "=";
						var titleNeedle:String 	= NEEDLE_TITLE + i + "=";
						var lengthNeedle:String = NEEDLE_LENGTH + i + "=";
						
						var filePosition:Number 		= data.search( fileNeedle );				
						var secondFilePosition:Number 	= data.search( fileNeedle );
						var titlePosition:Number 		= data.search( titleNeedle );
						var lengthPosition:Number 		= data.search( lengthNeedle );
				
						var fileEntry:String = data.substring( filePosition + fileNeedle.length , titlePosition-1 );
						var titleEntry:String = data.substring( titlePosition + titleNeedle.length , lengthPosition-1 );
						
						// FIXME -- Somehow i cant get the value of Length= out
						var lengthEntry:String = data.substring( lengthPosition + lengthNeedle.length , secondFilePosition -1);
						
						//Logger.info( NEEDLE_FILE 	+ i + "=" + fileEntry );
						//Logger.info( NEEDLE_TITLE 	+ i + "=" + titleEntry );
						//Logger.info( NEEDLE_LENGTH 	+ i + "=" + lengthEntry );
						
						var plsFile: PLSFile = new PLSFile();
						plsFile.title = titleEntry;						plsFile.file = fileEntry;						plsFile.length = int(lengthEntry);
						
						_parsedFile.push( plsFile );						
					}
				}
			} 
			else 
			{
				throw new ParseError( "Specified file is not a PLS file, make sure you pass through the correct file" );
			}
			
			return _parsedFile;
		}
	}
}
