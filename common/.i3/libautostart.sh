#!/bin/bash

###########################################################################
# Example auto start file for i3-wm, I execute it from i3 config with
# exec $HOME/bin/auto-start-for-i3
#
# For mouse moving I use xte. In Debian its in the package xautomation.
###########################################################################

set -e

DUMB_DELAY=${DUMB_DELAY:-2}

if $DEBUG ;then
	set -x
	redirect=">/tmp/$(whoami)-i3_startup.log 2>&1"
else
	redirect=">/dev/null 2>&1"
fi


# should we be quiet?
if [ -e ~/.silent ] ;then 
	QUIET=true
	SILENT=true
elif [ -e ~/.quiet ] ;then
	QUIET=true
else
	QUIET=false
	SILENT=false
fi

focus(){
	i3-msg focus $1
}

move(){
	i3-msg move $1
}

split(){
	i3-msg "workspace $ws;split $1"
}

layout(){
	i3-msg "workspace $ws;layout $1"
}

# unit ppt == percent
resize() {
	action=$1
	direction=$2
	count=$3
	for i in $(seq 1 $count); do
		i3-msg resize $action $direction
	done
}

return_home(){
    i3-msg "workspace 1"
}

# Start program
launch(){
	i3-msg "workspace $ws"
	$@ $redirect &
	wait_for_program $! "$@"
}

# Start program without checking it's there
launch_dumb(){
	i3-msg "workspace $ws"
	$@ &
	sleep $DUMB_DELAY
}

# Start program in terminal
launch_term(){
    i3-msg "workspace $ws"
	i3-sensible-terminal -e $@ $redirect &
    wait_for_program $! "i3-sensible-terminal -e $@"
}

launch_bg(){
	$@  $redirect &
}

# Wait for program coming up
wait_for_program () {
	if [ -z $1 ] ;then
		return 0
	fi
    n=0
    while true ;do
		# PID of last background command
		if xdotool search --onlyvisible --pid $1; then
			break
		else
		    # 20 seconds timeout
			if [ $n -eq 20 ]; then
				xmessage "Error on executing: $2"
				break
		    else
				n=`expr $n + 1`
				sleep 1
			fi
		fi
    done
}

done_launching(){
	xrefresh &
}

quiet(){
	if ! $QUIET ;then
		$@
	fi
}

silent(){
    if ! $SILENT ;then
        $@
    fi
}
