public class MidiInstrument{
	
	MidiIn min;
	MidiMsg msg;

	int device;

	class NoteEvent extends Event{
	    int note;
	    int velocity;
	}

	// the event
	NoteEvent on;
	// array of ugen's handling each note
	Event @ us[128];

	StkInstrument s;
	Gain g =>JCRev r => dac;
	.1 => g.gain;
	.01 => r.mix;


	// handler shred for a single voice
	fun void handler()
	{
	    Event off;
	    int note;

	    // inifinite time loop
	    while( true )
	    {
	        on => now;
	        if(on.note == 34){
	        	startRec();
	        	continue;
	        }
	        on.note => note;
	        // dynamically repatch
	        s => g;
	        Std.mtof( note ) => s.freq;
	        //1 => s.noteOn;
	        on.velocity / 127.0 => s.noteOn;
	        off @=> us[note];

	        off => now;
	        0 => s.noteOn;
	        
	    }
	}

	fun void startRec(){
		//write to file instead
		//loopRecorder.recordFromGain(g);
	}

	fun Gain getGain(){
		return g;
	}

	fun void setupMidi(int port){
		port => device;

		if( !min.open( device ) ) me.exit();

		<<< "MIDI device:", min.num(), " -> ", min.name() >>>;
	}

	fun void startInstrument(){

		// spork handlers, one for each voice
		for( 0 => int i; i < 20; i++ ) spork ~ handler();

		// infinite time loop
		while( true ){
		    // wait on midi event
		    min => now;

		    // get the midimsg
		    while( min.recv( msg ) ){
		        // catch only noteon
		        //if( msg.data1 != 144 )
		        //    continue;


		        // check velocity
		        if( msg.data3 > 0 && msg.data1 >= 140 )
		        {
		            // store midi note number
		            msg.data2 => on.note;
		            // store velocity
		            msg.data3 => on.velocity;
		            // signal the event
		            on.signal();
		            // yield without advancing time to allow shred to run
		            me.yield();
		        }
		        else
		        {
		            if( us[msg.data2] != null ) us[msg.data2].signal();
		        }
		    }
		}
	}
}