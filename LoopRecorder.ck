public class LoopRecorder{
	LiSa saveme;
	Looper loop;

	fun void recordFromGain(Gain gain) {
		gain => saveme => dac;
		60::second => saveme.duration;
		1.0 => saveme.rate;

		loop.synchronize();
		<<< "=========================== started rec" >>>;
		saveme.clear;
		saveme.record(1);

		loop.advance(1);
		<<< "=========================== ended rec" >>>;
		saveme.record(0);

		playRecording();
	}

	fun void playRecording() {
		saveme.play(1);

		while(true) {
			saveme.playPos(0::ms);
			<<< "€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€€PLAY€€€€€" >>>;

			loop.advance(1);
		}
	}
}