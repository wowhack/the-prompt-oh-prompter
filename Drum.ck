public class Drum{
	SndBuf buffers[5];

	0 => int currBeat;
	0 => int currMeasure;
	int beatLength[32];
	int measureCount;

	int measures[32][32];

	Dyno dyn;

	fun void loadPattern(string pattern){
		0 => int beat;
		0 => int measure;
		for(0 => int i; i< pattern.length(); i++){
			pattern.substring(i, 1) => string ch;
			if(ch == "x"){
				1 @=> measures[measure][beat];
				beat++;
			} else if(ch == ".") {
				0 @=> measures[measure][beat];
				beat++;
			} else if(ch == "|") {
				beat+1 @=> beatLength[measure];

				measure++;
				0 => beat;
			} else {
				;
			}
		}		
		beat+1 @=> beatLength[measure];
		measure++;
		0 => beat;

		measure => measureCount;

	}

	fun void loadSound(string file){
		for(0 => int i; i<buffers.size(); i++){
			1024 => buffers[i].chunks;
			0 => buffers[i].rate;
			file => buffers[i].read;
			buffers[i] => dyn =>Gain g => dac;
			0.5=>g.gain;
			dyn.compress;
		}
	}

	fun void playSound(){
		
		0 => buffers[currBeat%4].pos;

		float multiply;
		if(currBeat == 0){
			Std.rand2f(0.7, 0.75) => multiply;
		}else{
			Std.rand2f(0.55, 0.65) => multiply;
		}

		measures[currMeasure][currBeat] * multiply => buffers[currBeat%4].gain;
		1 => buffers[currBeat%4].rate;
		
    	currBeat++;

    	//check if new meassure
    	if(currBeat == beatLength[currMeasure]-1){
    		0 => currBeat;
    		currMeasure++; 
    		//check if loop
	    	if(currMeasure == measureCount){
	    		0 => currMeasure;
	    	}
    	}
	}
}
