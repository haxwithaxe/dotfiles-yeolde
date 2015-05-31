#!/bin/bash

good_color="#aaaaff"
warn_color="#ffff00"
danger_color="#ff0000"

temp_path=/sys/class/thermal/thermal_zone0

critical_temp=$((`cat ${temp_path}/trip_point_0_temp`-2000))
warn_temp=$(($critical_temp-10000))
long_temp=`cat ${temp_path}/temp`
temp=$(($long_temp/1000))

# defaults
temp_color=$good_color
blink=false

if [ $long_temp -ge $critical_temp ] ;then
	temp_color=$danger_color
	blink=true
elif [ $long_temp -ge $warn_temp ] ;then
	temp_color=$warn_color
fi

if $blink ;then
	printf  "{ \"full_text\" : \"${blink}%2d${blink}\" , \"color\" : \"%s\" }," ${temp} ${temp_color}
else
	printf  "{ \"full_text\" : \"%2d\" , \"color\" : \"%s\" }," ${temp} ${temp_color}
fi
