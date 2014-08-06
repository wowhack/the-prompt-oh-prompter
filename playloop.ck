


"loop" => string loopname;
0 => int device;

if( me.args()>0 ) {
	me.arg(0) => Std.atoi => device;
	me.arg(1) => loopname;
}

new Organ @=> MidiInstrument instrument;
LoopRecorder lRec;
1 => int mute;
int measuresToRecord;
int measuresToPlay;
0 @=> int currentMeasure;

Looper loop;

instrument.setup();
instrument.setupMidi(device);
spork ~ instrument.startInstrument();
<<< "before synchronize" >>>;
loop.synchronize();
<<< "after synchronize" >>>;

Std.system("rm "+FileRead.pathWrapper.path+"/live/"+loopname+"_rec");

fun void instantHandler() {
	while(true) {
		FileRead.readInt(loopname+"_arm",1) @=> instrument.armed;
		<<< instrument.armed >>>;
		100::ms => now;
	}
}

spork ~ instantHandler();

while(true) {
	FileRead.readInt(loopname+"_rec",0) @=> measuresToRecord;
	<<< "measuresToRecord:",measuresToRecord >>>;
	if(measuresToRecord>0) {
		lRec.recordFromGain(instrument.getGain(),measuresToRecord);
		Std.system("rm "+FileRead.pathWrapper.path+"/live/"+loopname+"_rec");
		measuresToRecord @=> measuresToPlay;
	}

	if(lRec.finishedRecording==1) {
		0=>mute;
	}

	if(!mute) {
		lRec.saveme.play(1);
		if(currentMeasure % measuresToPlay == 0) {
			lRec.saveme.playPos(0::ms);
		}
		<<< "€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€PLAY€€€€€" >>>;
		currentMeasure++;
	}
	loop.advance(1);
}