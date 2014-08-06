public class Saxophone extends MidiInstrument{
	fun void setup() {
		//setInstrument(bt);
	}


	// handler shred for a single voice
	fun void handler(NoteEvent onEvent)
	{
	   	Saxofony m;
		Event off;
	    int note;

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
	        onEvent.velocity / 127.0 => float vel;

	        vel => m.noteOn;

	        off @=> us[note];

	        off => now;
        
        	//null @=> us[note];
        	while(vel >0.01){
        		vel => m.noteOn;
        		vel - 0.01 => vel;	
        	}
        	0 => m.noteOn;
	        
	        
	    }
	}
}