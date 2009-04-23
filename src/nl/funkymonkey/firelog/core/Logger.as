package nl.funkymonkey.firelog.core
{
	import flash.events.StatusEvent;	import flash.net.LocalConnection;	import flash.system.System;	import flash.utils.getQualifiedClassName;		//
	public final class Logger {

		private static const LOCAL_CONNECTION:LocalConnection = new LocalConnection( );
		//
		public static const LOCAL_CONNECTION_NAME:String = "_LogReaderLC";
		public static const CLEAR_METHOD:String = "clear";
		public static const OUTPUT_METHOD:String = "output";
		
		
		private static var _hasListeners:Boolean = false;		private static var _isLogging:Boolean = true;
		//
		
		public static function onStatusHandler(evt:StatusEvent):void {
			switch (evt.level) 
			{
				case "status":
					trace( "Firelog status : up & running" );
					break;
				case "error":
					trace( "Could not send command over LocalConnection" );
					break;
			}
		}

		
		public static function get isLogging():Boolean {
			return _isLogging;
		}

		
		public static function set isLogging(value:Boolean):void {
			_isLogging = value;
		}

		
		private static function send(pInput:*, level:String):void {
			
			if(!_hasListeners) {
				LOCAL_CONNECTION.addEventListener(StatusEvent.STATUS, onStatusHandler);				
			}
			if(_isLogging) {
				LOCAL_CONNECTION.send( LOCAL_CONNECTION_NAME , OUTPUT_METHOD , pInput.toString( ) , level );
			}
		}

		
		public static function clear():void {
			LOCAL_CONNECTION.send( LOCAL_CONNECTION_NAME , CLEAR_METHOD );
		}

		
		public static function fatal(pInput:*):void {
			send( pInput , FilterLevel.FATAL );
		}

		
		public static function error(pInput:*):void {
			send( pInput , FilterLevel.ERROR );
		}

		
		public static function warn(pInput:*):void {
			send( pInput , FilterLevel.WARN );
		}

		
		public static function info(pInput:*):void {
			send( pInput , FilterLevel.INFO );
		}

		
		public static function debug(pInput:*):void {
			send( pInput , FilterLevel.DEBUG );
		}

		
		public static function memoryUsage():String {
								var currentMemValue:uint = System.totalMemory;
			var message:String = "Memory Snapshot: " + Math.round( currentMemValue / 1024 / 1024 * 100 ) / 100 + " MB (" + Math.round( currentMemValue / 1024 ) + " kb)";
			return message;
		}

		
		public function toString():String {
			return "[" + getQualifiedClassName( this ).match( "[^:]*$" )[0] + "]";
		}
	}
}