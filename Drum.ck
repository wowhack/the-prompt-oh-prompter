public class Drum{
	SndBuf buffers[5];

	0 => int currBeat;
	0 => int currMeasure;
	int beatLength[32];
	int measureCount;

	int measures[32][32];

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
			file => buffers[i].read;
			buffers[i] => dac;
		}
	}

	fun void playSound(){
		
		0 => buffers[currBeat%4].pos;

		measures[currMeasure][currBeat] * 0.6 => buffers[currBeat%4].gain;
		1.05 => buffers[currBeat%4].rate;
		
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
