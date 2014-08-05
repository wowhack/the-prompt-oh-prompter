public class Drum{
	SndBuf buf;
	buf => dac;
	int measures[64][64];
	0 => int currBeat;
	0 => int currMeasure;
	int beatLength[64];
	int measureCount;

	fun void loadPattern(string pattern){
		0 => int beat;
		0 => int measure;
		for(0 => int i; i< pattern.length(); i++){
			pattern.substring(i, 1) => string ch;
			if(ch == "x"){
				1 => measures[measure][beat];
				beat++;
			} else if(ch == ".") {
				0 => measures[measure][beat];
				beat++;
			} else if(ch == "|") {
				beat+1 => beatLength[measure];

				measure++;
				0 => beat;
			} else {
				;
			}
		}		
		beat+1 => beatLength[measure];
		measure++;
		0 => beat;

		measure => measureCount;

	}

	fun void loadSound(string file){
		file => buf.read;
	}

	fun void playSound(){
		0 => buf.pos;

    	measures[currMeasure][currBeat] * (100 / 127.0) * 0.9 => buf.gain;
    	(100 / 127.0) * 0.2 + 0.9 => buf.rate;

    	<<< currBeat >>>;

    	currBeat++;

    	//check if new meassure
    	if(currBeat == beatLength[currMeasure]-1){
    		<<< "new measure" >>>;
    		0 => currBeat;
    		currMeasure++; 
    		//check if loop
	    	if(currMeasure == measureCount){
	    		<<< "new loop" >>>;

	    		0 => currMeasure;
	    	}
    	}
	}
}

Drum drum;
drum.loadPattern("xx..|.x.x|");
drum.loadSound("AOW BD 1_FIS1.wav");

while(true) {
	drum.playSound();
	0.3::second=>now;
}