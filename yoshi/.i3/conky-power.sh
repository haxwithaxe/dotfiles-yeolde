#!/bin/bash

good_color="#00ff00"
warn_color="#ffff00"
danger_color="#ff0000"

critical_bat=10
bat_path=/sys/class/power_supply/BAT0
ac_path=/sys/class/power_supply/ADP0


ac_status=`cat ${ac_path}/online`
bat_full=`cat /sys/class/power_supply/BAT0/charge_full || echo -n 1`
bat_now=`cat /sys/class/power_supply/BAT0/charge_now`
bat_perc=$((100*${bat_now}/${bat_full}))

charge_diff=$((${bat_full}-${bat_now}))
if [ $charge_diff -le 0 ] ;then
	bat_status="Full"
elif [ "${ac_status}" = "0" ] ;then
	bat_status="Discharging"
elif [ "${ac_status}" = "1" ] ;then
	bat_status="Charging"
fi

# defaults
bat_sym=⚡
bat_color=$good_color

set_unknown(){
	bat_sym=∅
	bat_color=$danger_color
}

# bat power ⚡
# ac power ⏚
# unknown ∅
case $ac_status in
	0)
		bat_sym=⚡
		;;
	1)
		bat_sym=⏚
		;;
	*)
		bat_sym=∅
		;;
esac

case $bat_status in
	Full)
		bat_color=$good_color
		;;
	Charging)
		bat_color=$warn_color
		;;
	Discharging)
		if [ $bat_perc -le $critical_bat ] ;then
			bat_color=$danger_color
		else
			bat_color=$good_color
		fi
		;;
	Unknown)
		set_unknown
		;;
	*)
		set_unknown
		;;
esac

printf  "{ \"full_text\" : \"%s:%3s\" , \"color\" : \"%s\" }," ${bat_sym} ${bat_perc} ${bat_color}
