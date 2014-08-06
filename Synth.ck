public class Synth extends MidiInstrument{
	fun void setup() {
		//setInstrument(bt);
	}


	// handler shred for a single voice
	fun void handler(NoteEvent onEvent)
	{
	   	Moog m;
		Event off;
	    int note;

	    0.01 => m.modDepth;
	    0.8 => m.modSpeed;
	    0.2 => m.filterQ;

		m => g;

	    // inifinite time loop
	    while( true )
	    {
	        onEvent => now;
	        //if(on.note == 34){
	        //	startRec();
	        //	continue;
	        //}
	        onEvent.note @=> note;
	        // dynamically repatch
	        //s => g;

	        Std.mtof( note ) => m.freq;

	        //1 => s.noteOn;
	        onEvent.velocity / 127.0 => m.noteOn;

	        off @=> us[note];

	        off => now;
        
        	//null @=> us[note];

	        0 => m.noteOn;
	        
	    }
	}
}