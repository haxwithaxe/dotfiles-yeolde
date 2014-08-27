export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# set this to true to prevent certian things from running on startup (see comms.sh)
# this is for when i don't want all sorts of network traffic or startup noises from certain programs
export QUIET=false

## enhance the default path to include 
# for random crap i don't want to pollute my system with
# $HOME/annex/bin:${HOME}/.bin
# sbin's
# /sbin:/usr/sbin:/usr/local/sbin

PATH=${HOME}/.bin:${PATH}:/sbin:/usr/sbin:/usr/local/sbin
export PATH

# "secure" rm. -u remove after overwrite -z overwrite with 0's
alias srm='shred -uz'

export TERMINAL=evilvte

# I HATE NANO :(
export EDITOR=vim

# compressed prompt with path and hostname
small_pwd(){
	if [[ `pwd` == $HOME ]] ;then
		echo -n '~'
	elif [[ $(basename "`pwd`") = "`pwd`" ]] ;then
		echo -n `pwd`
	else
		cwd=`dirname "$(pwd)" | sed "s:^$HOME:/~:"`
		cwd=`echo $cwd | egrep -o '\/[^/]' | sed ':a;N;$!ba;s/\n//g'`
		echo -n ${cwd//\/\~/\~}/$(basename "`pwd`")
	fi
}

# note the \ infront of $(small_pwd)
PS1="\u@\h:\$(small_pwd)\$ "
