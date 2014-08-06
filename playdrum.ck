	"drums" => string drumname;

	if( me.args()>0 ) me.arg(0) => drumname;

	<<< "$ ADDED DRUM ",drumname >>>;

	Looper loop;

	Drum drum;
	string soundName;

	loop.synchronize();

	while(true) {
		FileRead.readString(drumname+"_smp","kick.wav") => string newSoundName;

		if(newSoundName!=soundName) {
			newSoundName=>soundName;
			<<< "$ SET NEW SOUND ",soundName," FOR DRUM ",drumname >>>;
			drum.loadSound(soundName);
		}
		if(drum.currBeat==0) {
			drum.loadPattern(FileRead.readString(drumname+"_ptn","...."));
		}

		<<<"% Drum: ",drumname," Beat: ", drum.currBeat+1 >>>;
		drum.playSound();
		loop.advance(drum.beatLength[drum.currMeasure]-1);
	}

