class PathWrapper
{
     string path;
}

public class FileRead {
	static PathWrapper @ pathWrapper;
	static FileIO @ fio;

	fun static int readInt(string parameter, int defaultint) {

		// parameter file
		pathWrapper.path + "/live/" + parameter => string filename;

		// instantiate
		

		// open the file
		fio.open( filename, FileIO.READ );

		// default value
		if( !fio.good() )
		{
			fio.close();
			return defaultint;
		}

		string strval;
		int value;

		// read the value
		while( fio => value )
		{
			fio.close();
		    return value;
		}

	}

	fun static void set(string parameter,int value) {
		pathWrapper.path + "/live/" + parameter => string filename;

		// instantiate
		FileIO fout;

		// open the file
		fout.open( filename, FileIO.WRITE );

		// test
		if( !fout.good() )
		{
		    cherr <= "can't open file for writing..." <= IO.newline();
		    return;
		}

		fout.write( value );

		// close the thing
		fout.close();

		return;
	}

	fun static string readString(string parameter, string defaultstring) {

		// parameter file
		pathWrapper.path + "/live/" + parameter => string filename;

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

new FileIO @=> FileRead.fio;

//FileRead fr;

// infinite time loop
//while( true )
//{
//    // print current bpm in seconds
//    <<< "bpm:", fr.readInt("bpm",120) >>>; 
//    <<< "drums:", fr.readString("drums","xx") >>>; 
//    1::second => now;
//}