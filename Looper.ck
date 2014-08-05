public class Looper{
	FileRead fr;
	float bpm;
	float spb;

	fun void advance(float part){
		if(part==0.0) {
			4.0=>part;
		}
		fr.readInt("bpm",100) => bpm;
		(60.0/bpm)*(4.0/part) => spb;
		1::second * spb => dur duration;
		duration => now;	
	}
}