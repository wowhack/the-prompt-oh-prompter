public class Looper{
	FileRead fr;
	float bpm;
	float spb;

	fun void synchronize() {
		fr.readInt("bpm",100) => bpm;
		(60.0/bpm)*(4.0) => spb;
		1::second * spb => dur duration;
		duration - (now % duration) => now;	

	}

	fun void advance(float part){
		<<< "advance ",part >>>;
		if(part==0.0) {
			4.0=>part;
		}
		(60.0/bpm)*(4.0/part) => spb;
		1::second * spb => dur duration;
		duration => now;	
	}
}