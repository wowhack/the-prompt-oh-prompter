	"drums" => string drumname;

	if( me.args()>0 ) me.arg(0) => drumname;

	<<< drumname >>>;

	Looper loop;

	Drum drum;
	string soundName;

	loop.synchronize();

	while(true) {
		FileRead.readString(drumname+"_smp","kick.wav") => string newSoundName;

		if(newSoundName!=soundName) {
			newSoundName=>soundName;
			<<< soundName >>>;
			drum.loadSound(soundName);
		}
		if(drum.currBeat==0) {
			drum.loadPattern(FileRead.readString(drumname+"_ptn","...."));
		}

		drum.playSound();
		loop.advance(drum.beatLength[drum.currMeasure]-1);
	}

