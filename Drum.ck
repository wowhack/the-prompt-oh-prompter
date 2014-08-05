public class Drum{
	SndBuf buf;
	buf => adc;
	int pattern[];

	fun void loadPattern(int arr[]){
		arr @=> pattern; 
	}

	fun void loadSound(string file){
		file => buf.read;
	}
}