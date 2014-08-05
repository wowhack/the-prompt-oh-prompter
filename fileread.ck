public class FileRead {

	fun int readInt(string parameter, int defaultint) {

		// parameter file
		me.sourceDir() + "/live/" + parameter => string filename;

		// instantiate
		FileIO fio;

		// open the file
		fio.open( filename, FileIO.READ );

		// default value
		if( !fio.good() )
		{
			return defaultint;
		}

		int value;

		// read the value
		while( fio => value )
		{
		    return value;
		}

	}

	fun string readString(string parameter, string defaultstring) {

		// parameter file
		me.sourceDir() + "/live/" + parameter => string filename;

		// instantiate
		FileIO fio;

		// open a file
		fio.open( filename, FileIO.READ );

		// ensure it's ok
		if( !fio.good() )
		{
		    return defaultstring;
		}

		string value;

		// loop until end
		while( fio => value )
		{
			return value;
		}
	}

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