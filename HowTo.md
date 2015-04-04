Checkout the latest source in SVN. For SVN programs I recommend:
  * Windows:http://tortoisesvn.tigris.org/
  * Mac: http://versionsapp.com/

Instructions are [here on howto checkout with SVN](http://code.google.com/p/as3plsreader/source/checkout).

In three steps you are good to go. (More examples on how to use in the test package in trunk)

  * 1) Import appropriate files.
  * 2) Set the source property to a playlist file.
  * 3) Handle the event.

like so and you are good to go :)

```
// import appropriate files
import nl.funkymonkey.utils.io.playlist.PlaylistReader;
import flash.filesystem.*;

// make a reference to a file on the desktop
var plsFile:File = File.desktopDirectory.resolvePath( "default.pls" ); // Or playlist.m3u

// instanciate new PlayListReader object with file reference
var pls:PlaylistReader = new PlaylistReader( );
pls.addEventListener( ParseEvent.FILE_PARSED , parsedPlaylist, false, 0, true );
pls.source = plsFile;	
```

And handle the event, like so:

```
private function parsedPlaylist( evt : ParseEvent) : void {
			
	var playlistFile : Array = evt.fileData as Array;
	Logger.info("file with extension " + evt.extension.toString() + " succesfully parsed.");
	Logger.info("====== M3U FILE   " + playlistFile.toString() + " ======");

	for (var i : int = 0;i < playlistFile.length; ++i) {
		Logger.info("====== M3U Item no# " + (i + 1) + " of " + playlistFile.length + " ======");
		Logger.info("** file  	 : " + IPlayable(playlistFile[i]).file);
		Logger.info("** title 	 : " + IPlayable(playlistFile[i]).title);
		Logger.info("** length	 : " + IPlayable(playlistFile[i]).length);
		Logger.info("** isStream : " + IPlayable(playlistFile[i]).isStream);
	}
}
```

Happy coding :)