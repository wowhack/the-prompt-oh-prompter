class PathWrapper
{
     string path;
}

public class FileRead {
	static PathWrapper @ pathWrapper;

	fun int readInt(string parameter, int defaultint) {

		// parameter file
		pathWrapper.path + "/live/" + parameter => string filename;

		<<< filename >>>;

		// instantiate
		FileIO fio;

		// open the file
		fio.open( filename, FileIO.READ );

		// default value
		if( !fio.good() )
		{
			<<< fio >>>;
			fio.close();
			return defaultint;
		}

		int value;

		// read the value
		while( fio => value )
		{
			fio.close();
			<<< value >>>;
		    return value;
		}

	}

	fun string readString(string parameter, string defaultstring) {

		// parameter file
		pathWrapper.path + "/live/" + parameter => string filename;

		<<< filename >>>;

		// instantiate
		FileIO fio;

		// open a file
		fio.open( filename, FileIO.READ );

		// ensure it's ok
		if( !fio.good() )
		{
			fio.close();
		    return defaultstring;
		}

		string value;

		// loop until end
		while( fio => value )
		{
			fio.close();
			<<< value >>>;
			return value;
		}
	}

}

if( me.args() ) {
	new PathWrapper @=> FileRead.pathWrapper;
	me.arg(0) @=> FileRead.pathWrapper.path;
} else {
	new PathWrapper @=> FileRead.pathWrapper;
	me.sourceDir() @=> FileRead.pathWrapper.path;
}

//FileRead fr;

// infinite time loop
//while( true )
//{
//    // print current bpm in seconds
//    <<< "bpm:", fr.readInt("bpm",120) >>>; 
//    <<< "drums:", fr.readString("drums","xx") >>>; 
//    1::second => now;
//}