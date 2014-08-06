the-chucklers
=============

# Usage

	chuck --loop --caution-to-the-wind
	./chuckler.sh setup
	./chuckler.sh <drum or looper>

## Live usage endpoints

	echo <input> > live/<endpoint>

### live/bpm

	int: Beats per minute, set before setup.

### live/drumname_ptn

	pattern: Pattern for the drum to play

	"x": hit
	".": pause
	"|": new measure

	example: xx.xx.xx.xx.|xx.xx....xxx
			 Gives a 2 measures long 12/8 pattern.

### live/drumname_smp

	filename: Filename for the drum sample.

	example: "kick.wav"

### live/loopname_instr

	string: Instrument to use, eg. Organ,Synth,Saxophone etc.

### live/loopname_arm

	bool: 0 or 1 whether the looper should listen to midi events

### live/loopname_rec

	int: Number of measures to record, starts recording on the next measure.

	Reset when starting recording.
