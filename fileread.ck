// bpm file
me.sourceDir() + "/live/" + "/bpm" => string filename;

// instantiate
FileIO fio;

// open the file
fio.open( filename, FileIO.READ );

// default value
if( !fio.good() )
{
	<<< 100 >>>;
    me.exit();
}

int bpm;

// read the value
while( fio => bpm )
{
    <<< bpm >>>;
}