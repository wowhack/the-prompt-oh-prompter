public class Organ extends MidiInstrument{
	fun void setup() {
		//setInstrument(bt);
	}


	// handler shred for a single voice
	fun void handler(NoteEvent onEvent)
	{
	   	BeeThree bt;
		Event off;
	    int note;

		bt => g;

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

	        Std.mtof( note ) => bt.freq;

	        //1 => s.noteOn;
	      	onEvent.velocity / 127.0 => float vel;

	        vel => bt.noteOn;

	        off @=> us[note];

	        off => now;
        
        	//null @=> us[note];

	        while(vel >0.0001){
        		vel => bt.noteOn;
        		vel - 0.0001 => vel;	
        	}
        	0 => bt.noteOn;
	        
	    }
	}
}


