public class LoopRecorder{
	LiSa saveme;
	Looper loop;
	0 => int finishedRecording;

	fun void recordFromGain(Gain gain,int measures) {
		gain => saveme => dac;
		60::second => saveme.duration;
		1.0 => saveme.rate;

		loop.synchronize();
		<<< "=========================== started rec" >>>;
		saveme.clear;
		0=>finishedRecording;
		saveme.record(1);

		for(0=>int i; i<measures;i++) {
			loop.advance(1);
		}
		<<< "=========================== ended rec" >>>;
		saveme.record(0);

		1=>finishedRecording;
	}
}