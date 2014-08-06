public class LoopRecorder{
	LiSa saveme;
	Looper loop;
	1 => int finishedRecording;
	int measuresleft;

	fun void recordFromGain(Gain gain,int measures) {
		gain => saveme => dac;
		60::second => saveme.duration;
		1.0 => saveme.rate;

		measures @=> measuresleft;

		loop.synchronize();
		<<< "=== STARTED RECORDING ===" >>>;
		saveme.clear;
		0=>finishedRecording;
		saveme.record(1);

		for(0=>int i; i<measures;i++) {
			measuresleft--;
			loop.advance(1);
		}
		<<< "=== ENDED RECORDING ===" >>>;
		1=>finishedRecording;

		saveme.record(0);

	}
}