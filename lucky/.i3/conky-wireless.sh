
cat - &> /dev/null <<COMMENT
$ head -n1 /proc/net/wireless
Inter-| sta-|   Quality        |   Discarded packets               | Missed | WE
$ grep $iface /proc/net/wireless
 wlan0: 0000   70.  -39.  -256        0      0      0      1     91        0
$ $iw dev $iface info
Interface wlan0
	ifindex 3
	wdev 0x1
	addr 08:11:96:66:a4:10
	type managed
	wiphy 0
	channel 11 (2462 MHz), width: 20 MHz, center1: 2462 MHz
COMMENT

iw=/sbin/iw
open_color="#ffff00"

iface=$1

iw_info=`$iw dev $iface info`
iw_link=`$iw dev $iface link`


get_mode(){
	echo $iw_info | grep type | sed 's/^.*type //' | cut -d' ' -f1
}

get_essid(){
	echo $iw_link | grep SSID | sed 's/^.*SSID: //' | cut -d' ' -f1
}

get_bssid(){
	echo $iw_link | grep "Connected to" | cut -d' ' -f3
}

get_signal(){
	full=`echo $iw_link | grep signal | sed 's/^.*signal: //;s/\( [^[:space:]]\)[[:space:]]\+$/\1/'`
	value=`echo $full | cut -d' ' -f1`
	#units=`echo $full | cut -d' ' -f2`
	echo $value
}

get_ip4(){
	ip -f inet addr show wlan0 scope global | egrep 'inet' | cut -d' ' -f6 | cut -d'/' -f1
}

get_ip6(){
	ip -f inet6 addr show wlan0 scope global | egrep 'inet6' | cut -d' ' -f6 | cut -d'/' -f1
}

get_mode
mode=`get_mode`

#$iface:
ip4=`get_ip4`
if [ -n $ip4 ]; then
	ip4_str="$ip4 "
fi

ip6=`get_ip6`
if [ -n $ip6 ]; then
	ip6_str="$ip6 "
fi
signal="`get_signal`"
case $mode in
	Managed|managed)
		ssid=" e:`get_essid`"
		;;
	ad-hoc|adhoc)
		ssid=" b:`get_bssid`"
		;;
	*)
		ssid=""
		;;
esac

printf "{ \"full_text\" : \"%s:%s %3sdBm e:%s\" , \"color\" : \"%s\" }," $iface $ip4_str $ip6_str $signal $ssid $enc_color
