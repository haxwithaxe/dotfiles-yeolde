#!/bin/bash
wget -O $HOME/conky_forecast_nws/ttt "http://forecast.weather.gov/MapClick.php?lat=35.11720&lon=-106.62500&FcstType=dwml" 

if [[ -s $HOME/conky_forecast_nws/ttt ]]; then

	grep -i period-name $HOME/conky_forecast_nws/ttt>$HOME/conky_forecast_nws/tt
	sed -i '14,$d' $HOME/conky_forecast_nws/tt
	sed -i 's/"/\n/g' $HOME/conky_forecast_nws/tt
	grep -iv start-valid-time $HOME/conky_forecast_nws/tt>$HOME/conky_forecast_nws/t
	grep -i '<text>' $HOME/conky_forecast_nws/ttt>$HOME/conky_forecast_nws/dd 
	sed -i 's/\///g' $HOME/conky_forecast_nws/dd
	sed -i 's/<text>/\n/g' $HOME/conky_forecast_nws/dd
	sed -i '/^$/d' $HOME/conky_forecast_nws/dd
	cut -d "." -f1 $HOME/conky_forecast_nws/dd > $HOME/conky_forecast_nws/d
	grep -i 'http://forecast.weather.gov/images/wtf/' $HOME/conky_forecast_nws/ttt>$HOME/conky_forecast_nws/pp
	sed -i 's/<icon-link>/\n/g' $HOME/conky_forecast_nws/pp
	sed -i 's/<\/icon-link>/\n/g' $HOME/conky_forecast_nws/pp
	sed -i '/^$/d' $HOME/conky_forecast_nws/pp
	for (( i=1; i<=13; i++ ))
	  do
		j=$((2*i))
	    a=$(sed -n "${j}p" $HOME/conky_forecast_nws/pp)
		wget -O $HOME/conky_forecast_nws/$i.jpg $a
	  done

fi
