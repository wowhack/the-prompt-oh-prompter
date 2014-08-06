#!/bin/bash        
if [ -z "$1" ]; then 
  echo "USAGE:"
  echo "$0 setup"
  echo "$0 drum <name>"
  echo "$0 instr <instrument> <name> <mididevice>"
  exit
fi

# setup
if [ "$1" == "setup" ]; then 
	chuck + fileread.ck:`pwd` Looper.ck Drum.ck LoopRecorder.ck NoteEvent.ck MidiInstrument.ck Organ.ck Synth.ck
	exit
fi

# add drum
if [ "$1" == "drum" ]; then 
	if [ -z "$2" ]; then
		echo "USAGE: $0 drum <name>"
	fi
	chuck + playdrum.ck:$2
	exit
fi

# add instrument
if [ "$1" == "instr" ]; then 
	if [ -z "$2" ]; then
		echo "USAGE: $0 instr <instrument> <name> <mididevice>"
	fi
	echo $2 > live/$3_instr
	chuck + playdrum.ck:$4:$3
	exit
fi