


"loop" => string loopname;
0 => int device;

if( me.args()>0 ) {
	me.arg(0) => Std.atoi => device;
	me.arg(1) => loopname;
}

FileRead.readString(loopname+"_instr","error") @=> string instrumentName;

MidiInstrument instrument;
if(instrumentName.lower()=="organ") {
	new Organ @=> instrument;
} else if(instrumentName.lower()=="synth") {
	new Synth @=> instrument;
} else if(instrumentName.lower()=="sax"){
	new Saxophone @=> instrument;
}
else {
	<<< "### NO INSTRUMENT SELECTED FOR LOOPER ",loopname,", ABORTING!! ###" >>>;
	me.exit();
}

LoopRecorder lRec;
1 => int mute;
int measuresToRecord;
int measuresToPlay;
0 @=> int currentMeasure;

Looper loop;

instrument.setup();
instrument.setupMidi(device);
spork ~ instrument.startInstrument();
//<<< "before synchronize" >>>;
loop.synchronize();
//<<< "after synchronize" >>>;

Std.system("rm "+FileRead.pathWrapper.path+"/live/"+loopname+"_rec");

fun void instantHandler() {
	while(true) {
		FileRead.readInt(loopname+"_arm",1) @=> instrument.armed;

		FileRead.readInt(loopname+"_rec",0) @=> measuresToRecord;
		if(measuresToRecord>0) {
			<<< "=== WILL RECORD NEXT ",measuresToRecord,"MEASURES ON ",loopname," ===" >>>;
			measuresToRecord @=> measuresToPlay;
			lRec.recordFromGain(instrument.getGain(),measuresToRecord);
			Std.system("rm "+FileRead.pathWrapper.path+"/live/"+loopname+"_rec");
		}
		100::ms => now;
	}
}

spork ~ instantHandler();

while(true) {
	if(!mute) {
		<<< "% LOOPER ",loopname," NEW MEASURE ",currentMeasure >>>;

		if(currentMeasure % measuresToPlay == 0) {
			lRec.saveme.play(1);
			lRec.saveme.playPos(0::ms);
		}
		currentMeasure++;
	}
	loop.advance(1);

	if(lRec.finishedRecording==0 && lRec.measuresleft==0) {
		0=>mute;
	}
}