
"loop" => string loopname;
0 => int device;

if( me.args()>0 ) {
	me.arg(0) => Std.atoi => device;
	me.arg(1) => loopname;
}

new Organ @=> MidiInstrument instrument;
FileRead fr;
LoopRecorder lRec;
1 => int mute;
int measuresToRecord;

Looper loop;

instrument.setupMidi(device);
instrument.startInstrument();

loop.synchronize();

while(true) {
	fr.readInt(loopname+"_rec",0) => measuresToRecord;

	if(measuresToRecord>0) {
		lRec.recordFromGain(instrument.getGain(),measuresToRecord);
		0=>measuresToRecord;
		fr.set(loopname+"_rec","0");
	}

	if(lRec.finishedRecording) {
		0=>mute;
	}

	if(!mute) {
		lRec.saveme.play(1);
		lRec.saveme.playPos(0::ms);
		<<< "€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€PLAY€€€€€" >>>;
	}
	loop.advance(1);
}