package nl.funkymonkey.utils.io.playlist.error 
{	/**
	 * Parsing Error - thrown when FileHeader do not match with input File
	 * 	 * @author Sidney de Koning, sidney@funky-monkey.nl	 */	public class ParseError extends Error {
		public function ParseError( message:String = "" ) {			super( message , 0 );		}
	}}