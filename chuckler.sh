#!/bin/bash        
if [ -z "$1" ]; then 
  echo argument expected
  exit
fi

# setup
if [ "$1" == "setup" ]; then 
	chuck + fileread.ck:`pwd` Looper.ck Drum.ck LoopRecorder.ck NoteEvent.ck MidiInstrument.ck Organ.ck Synth.ck
	exit
fi

# add drum
if [ "$1" == "drum" ]; then 
	chuck + playdrum.ck:$2
	exit
fi