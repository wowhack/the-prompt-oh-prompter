public class Drum{
	SndBuf buf;
	buf => dac;
	int measures[][];
	0 => int currBeat;
	int beatDivision;

	fun void loadPattern(string pattern){
		0 => beat;
		0 => measure;
		for(0 => int i; i< pattern.length(); i++){
			string ch <= pattern.charAt(i);
			if(ch == "x"){
				1 => measures[measure][beat];
				beat++;
			} else if(ch == ".") {
				0 => measures[measure][beat];
				beat++;
			} else if(ch == "|") {
				measure++;
				0 => beat;
			} else {
				;
			}
		}		
	}

	fun void loadSound(string file){
		file => buf.read;
	}

	fun void playSound(){
		0 => buf.pos;

    	pattern[currBeat] * (100 / 127.0) * 0.9 => buf.gain;
    	(100 / 127.0) * 0.2 + 0.9 => buf.rate;

    	currBeat++;
    	if(currBeat == beatDivision)
    		0 => currBeat; 
	}
}