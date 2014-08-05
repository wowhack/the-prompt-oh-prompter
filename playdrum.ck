	"drums" => string drumname;

	if( me.args()>0 ) me.arg(0) => drumname;

	<<< drumname >>>;

	FileRead fr;
	Looper loop;

	Drum drum;
	string soundName;

	if( me.args()>1 ) {
		me.arg(1) => fr.path;
	} else {
		me.sourceDir() => fr.path;
	}


	loop.synchronize();

	while(true) {
		fr.readString(drumname+"_smp","kick.wav") => string newSoundName;

		if(newSoundName!=soundName) {
			newSoundName=>soundName;
			<<< soundName >>>;
			drum.loadSound(soundName);
		}
		drum.loadPattern(fr.readString(drumname+"_ptn","...."));

		drum.playSound();
		loop.advance(drum.beatLength[drum.currMeasure]-1);
	}

