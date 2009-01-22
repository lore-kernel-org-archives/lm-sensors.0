From: "Charles" <CharlesA@auroville.org.in>
Date: Thu, 22 Jan 2009 11:50:15 +0000
Subject: [lm-sensors] fancontrol modification to get temp by running a
Message-Id: <000b01c97c85$eb2bca60$3001a8c0@cw8xp>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_NextPart_000_000C_01C97CB4.04E40660"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000C_01C97CB4.04E40660
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello lmsensors mailing list  :-)
 
Here's a copy of fancontrol 0.67 modified to optionally get fan control
temperatures by running a simple command that may be specified in the
configuration file.

To integrate with the modified fancontrol, the command should: 
a) normally: write the temperature to stdout and set a zero return code. 
b) error: write an error message to stderr and set a non-zero return code.

To use this new facility, the FCTEMP specification in the configuration file
(normally /etc/fancontrol) is command:<command> where <command> is the
command string with any spaces replaced by %20.  For example:
 
FCTEMPS= hwmon1/device/pwm1=command:hddtemp%20-n%20/dev/sda

The command may not include pipelining, redirection, multiple lines etc.  It
may, of course, run a script.  

Best
 
Charles

=== diff showing changes to fancontrol 0.67 begins ===
< # Version 0.67+
< #
< # Change history
< #   22jan9 Charles
< #       * Added "command:" format and processing for config file FCTEMPS
---
> # Version 0.67
281c277,283
< 		if [[ ${tsens#command:} != $tsens ]]
---
> 		read tval < ${tsens}
> 		if [ $? -ne 0 ]
> 		then
> 			echo "Error reading temperature from $DIR/$tsens"
> 			restorefans 1
> 		fi
> 		if [ "$SYSFS" = "1" ]
283,300d284
< 			command="${tsens#command:}"
< 			command="${command//%20/ }"
< 			tval="$($command 2>&1)"
< 			if [[ $? -ne 0 ]]
< 			then
< 				echo "Error reading temperature by command
'$command':
< $tval"
< 				restorefans 1
< 			fi
< 		else
< 			read tval < ${tsens}
< 			if [ $? -ne 0 ]
< 			then
< 				echo "Error reading temperature from
$DIR/$tsens"
< 				restorefans 1
< 			fi
< 			if [ "$SYSFS" = "1" ]
< 			then
302,304c286,287
< 			else
< 				tval=`echo ${tval} | cut -d' ' -f3 | cut
-d'.' -f1`
< 			fi
---
> 		else
> 			tval=`echo ${tval} | cut -d' ' -f3 | cut -d'.' -f1`
=== diff showing changes to fancontrol 0.67 begins ===




------=_NextPart_000_000C_01C97CB4.04E40660
Content-Type: application/octet-stream;
	name="fancontrol"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="fancontrol"

#!/bin/bash=0A=
#=0A=
# Simple script implementing a temperature dependent fan speed control=0A=
#=0A=
# Version 0.67+=0A=
#=0A=
# Change history=0A=
#   22jan9 Charles=0A=
#       * Added "command:" format and processing for config file FCTEMPS=0A=
#=0A=
# Usage: fancontrol [CONFIGFILE]=0A=
#=0A=
# Dependencies:=0A=
#   bash, egrep, sed, cut, sleep, lm_sensors :)=0A=
#=0A=
# Please send any questions, comments or success stories to=0A=
# marius.reiner@hdev.de=0A=
# Thanks!=0A=
#=0A=
# For configuration instructions and warnings please see fancontrol.txt, =
which=0A=
# can be found in the doc/ directory or at the website mentioned above.=0A=
#=0A=
#=0A=
#    Copyright 2003 Marius Reiner <marius.reiner@hdev.de>=0A=
#    Copyright (C) 2007-2008 Jean Delvare <khali@linux-fr.org>=0A=
#=0A=
#    This program is free software; you can redistribute it and/or modify=0A=
#    it under the terms of the GNU General Public License as published by=0A=
#    the Free Software Foundation; either version 2 of the License, or=0A=
#    (at your option) any later version.=0A=
#=0A=
#    This program is distributed in the hope that it will be useful,=0A=
#    but WITHOUT ANY WARRANTY; without even the implied warranty of=0A=
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=0A=
#    GNU General Public License for more details.=0A=
#=0A=
#    You should have received a copy of the GNU General Public License=0A=
#    along with this program; if not, write to the Free Software=0A=
#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,=0A=
#    MA 02110-1301 USA.=0A=
#=0A=
#=0A=
=0A=
PIDFILE=3D"/var/run/fancontrol.pid"=0A=
=0A=
#DEBUG=3D1=0A=
MAX=3D255=0A=
=0A=
if [ -f "$PIDFILE" ]=0A=
then=0A=
	echo "File $PIDFILE exists, is fancontrol already running?"=0A=
	exit 1=0A=
fi=0A=
echo $$ > "$PIDFILE"=0A=
=0A=
declare -i pwmval=0A=
=0A=
function LoadConfig {=0A=
	echo "Loading configuration from $1 ..."=0A=
	# grep configuration from file=0A=
	INTERVAL=3D`egrep '^INTERVAL=3D.*$' $1 | sed -e 's/INTERVAL=3D//g'`=0A=
	FCTEMPS=3D`egrep '^FCTEMPS=3D.*$' $1 | sed -e 's/FCTEMPS=3D//g'`=0A=
	MINTEMP=3D`egrep '^MINTEMP=3D.*$' $1 | sed -e 's/MINTEMP=3D//g'`=0A=
	MAXTEMP=3D`egrep '^MAXTEMP=3D.*$' $1 | sed -e 's/MAXTEMP=3D//g'`=0A=
	MINSTART=3D`egrep '^MINSTART=3D.*$' $1 | sed -e 's/MINSTART=3D//g'`=0A=
	MINSTOP=3D`egrep '^MINSTOP=3D.*$' $1 | sed -e 's/MINSTOP=3D//g'`=0A=
	# optional settings:=0A=
	FCFANS=3D`egrep '^FCFANS=3D.*$' $1 | sed -e 's/FCFANS=3D//g'`=0A=
	MINPWM=3D`egrep '^MINPWM=3D.*$' $1 | sed -e 's/MINPWM=3D//g'`=0A=
	MAXPWM=3D`egrep '^MAXPWM=3D.*$' $1 | sed -e 's/MAXPWM=3D//g'`=0A=
=0A=
	# Check whether all mandatory settings are set=0A=
	if [[ -z ${INTERVAL} || -z ${FCTEMPS} || -z ${MINTEMP} || -z ${MAXTEMP} =
|| -z ${MINSTART} || -z ${MINSTOP} ]]=0A=
	then=0A=
		echo "Some mandatory settings missing, please check your config file!"=0A=
		exit 1=0A=
	fi=0A=
	if [ "$INTERVAL" -le 0 ]=0A=
	then=0A=
		echo "Error in configuration file:"=0A=
		echo "INTERVAL must be at least 1"=0A=
		exit 1=0A=
	fi=0A=
=0A=
	# write settings to arrays for easier use and print them=0A=
	echo=0A=
	echo "Common settings:"=0A=
	echo "  INTERVAL=3D$INTERVAL"=0A=
=0A=
	let fcvcount=3D0=0A=
	#echo "DEBUG: FCTEMPS is '$FCTEMPS'"=0A=
	for fcv in $FCTEMPS=0A=
	do=0A=
		#echo "DEBUG: fcv is '$fcv'"=0A=
		if ! echo $fcv | egrep -q '=3D'=0A=
		then=0A=
			echo "Error in configuration file:"=0A=
			echo "FCTEMPS value is improperly formatted"=0A=
			exit 1=0A=
		fi=0A=
=0A=
		AFCPWM[$fcvcount]=3D`echo $fcv |cut -d'=3D' -f1`=0A=
		#echo "DEBUG: AFCPWM is '$AFCPWM'"=0A=
		AFCTEMP[$fcvcount]=3D`echo $fcv |cut -d'=3D' -f2`=0A=
		AFCFAN[$fcvcount]=3D`echo $FCFANS |sed -e 's/ /\n/g' |egrep =
"${AFCPWM[$fcvcount]}" |cut -d'=3D' -f2`=0A=
		#echo "DEBUG: FCFANS is '$FCFANS'"=0A=
		#echo $FCFANS |sed -e 's/ /\n/g' =0A=
		#echo $FCFANS |sed -e 's/ /\n/g' |egrep "${AFCPWM[$fcvcount]}" =0A=
		#echo $FCFANS |sed -e 's/ /\n/g' |egrep "${AFCPWM[$fcvcount]}" |cut =
-d'=3D' -f2=0A=
		#echo "DEBUG: AFCFAN is '$AFCFAN'"=0A=
		AFCMINTEMP[$fcvcount]=3D`echo $MINTEMP |sed -e 's/ /\n/g' |egrep =
"${AFCPWM[$fcvcount]}" |cut -d'=3D' -f2`=0A=
		#echo "DEBUG: MINTEMP is '$MINTEMP'"=0A=
		#echo $MINTEMP |sed -e 's/ /\n/g'=0A=
		#echo $MINTEMP |sed -e 's/ /\n/g' |egrep "${AFCPWM[$fcvcount]}" =0A=
		#echo $MINTEMP |sed -e 's/ /\n/g' |egrep "${AFCPWM[$fcvcount]}" |cut =
-d'=3D' -f2=0A=
		#echo "DEBUG: AFCMINTEMP is '$AFCMINTEMP'"=0A=
		AFCMAXTEMP[$fcvcount]=3D`echo $MAXTEMP |sed -e 's/ /\n/g' |egrep =
"${AFCPWM[$fcvcount]}" |cut -d'=3D' -f2`=0A=
		AFCMINSTART[$fcvcount]=3D`echo $MINSTART |sed -e 's/ /\n/g' |egrep =
"${AFCPWM[$fcvcount]}" |cut -d'=3D' -f2`=0A=
		AFCMINSTOP[$fcvcount]=3D`echo $MINSTOP |sed -e 's/ /\n/g' |egrep =
"${AFCPWM[$fcvcount]}" |cut -d'=3D' -f2`=0A=
		AFCMINPWM[$fcvcount]=3D`echo $MINPWM |sed -e 's/ /\n/g' |egrep =
"${AFCPWM[$fcvcount]}" |cut -d'=3D' -f2`=0A=
		[ -z "${AFCMINPWM[$fcvcount]}" ] && AFCMINPWM[$fcvcount]=3D0=0A=
		AFCMAXPWM[$fcvcount]=3D`echo $MAXPWM |sed -e 's/ /\n/g' |egrep =
"${AFCPWM[$fcvcount]}" |cut -d'=3D' -f2`=0A=
		[ -z "${AFCMAXPWM[$fcvcount]}" ] && AFCMAXPWM[$fcvcount]=3D255=0A=
=0A=
		# verify the validity of the settings=0A=
		if [ "${AFCMINTEMP[$fcvcount]}" -ge "${AFCMAXTEMP[$fcvcount]}" ]=0A=
		then=0A=
			echo "Error in configuration file (${AFCPWM[$fcvcount]}):"=0A=
			echo "MINTEMP must be less than MAXTEMP"=0A=
			exit 1=0A=
		fi=0A=
		if [ "${AFCMAXPWM[$fcvcount]}" -gt 255 ]=0A=
		then=0A=
			echo "Error in configuration file (${AFCPWM[$fcvcount]}):"=0A=
			echo "MAXPWM must be at most 255"=0A=
			exit 1=0A=
		fi=0A=
		if [ "${AFCMINSTOP[$fcvcount]}" -ge "${AFCMAXPWM[$fcvcount]}" ]=0A=
		then=0A=
			echo "Error in configuration file (${AFCPWM[$fcvcount]}):"=0A=
			echo "MINSTOP must be less than MAXPWM"=0A=
			exit 1=0A=
		fi=0A=
		if [ "${AFCMINSTOP[$fcvcount]}" -lt "${AFCMINPWM[$fcvcount]}" ]=0A=
		then=0A=
			echo "Error in configuration file (${AFCPWM[$fcvcount]}):"=0A=
			echo "MINSTOP must be greater than or equal to MINPWM"=0A=
			exit 1=0A=
		fi=0A=
		if [ "${AFCMINPWM[$fcvcount]}" -lt 0 ]=0A=
		then=0A=
			echo "Error in configuration file (${AFCPWM[$fcvcount]}):"=0A=
			echo "MINPWM must be at least 0"=0A=
			exit 1=0A=
		fi=0A=
=0A=
		echo=0A=
		echo "Settings for ${AFCPWM[$fcvcount]}:"=0A=
		echo "  Depends on ${AFCTEMP[$fcvcount]}"=0A=
		echo "  Controls ${AFCFAN[$fcvcount]}"=0A=
		echo "  MINTEMP=3D${AFCMINTEMP[$fcvcount]}"=0A=
		echo "  MAXTEMP=3D${AFCMAXTEMP[$fcvcount]}"=0A=
		echo "  MINSTART=3D${AFCMINSTART[$fcvcount]}"=0A=
		echo "  MINSTOP=3D${AFCMINSTOP[$fcvcount]}"=0A=
		echo "  MINPWM=3D${AFCMINPWM[$fcvcount]}"=0A=
		echo "  MAXPWM=3D${AFCMAXPWM[$fcvcount]}"=0A=
		let fcvcount=3Dfcvcount+1=0A=
	done=0A=
	echo=0A=
}=0A=
=0A=
if [ -f "$1" ]=0A=
then=0A=
	LoadConfig $1=0A=
else=0A=
	LoadConfig /etc/fancontrol=0A=
fi=0A=
=0A=
DIR=3D/proc/sys/dev/sensors=0A=
if [ ! -d $DIR ]=0A=
then=0A=
	# For Linux 2.6, detect if config file uses the hwmon class or not yet=0A=
	if echo "${AFCPWM[0]}" | egrep -q '^hwmon[0-9]'=0A=
	then=0A=
		SDIR=3D/sys/class/hwmon=0A=
	else=0A=
		SDIR=3D/sys/bus/i2c/devices=0A=
	fi=0A=
=0A=
	if [ ! -d $SDIR ]=0A=
	then=0A=
		echo $0: 'No sensors found! (did you load the necessary modules?)'=0A=
		exit 1=0A=
	else=0A=
		SYSFS=3D1=0A=
		DIR=3D$SDIR=0A=
	fi=0A=
fi=0A=
cd $DIR=0A=
=0A=
# $1 =3D pwm file name=0A=
function pwmdisable()=0A=
{=0A=
	if [ -n "$SYSFS" ]=0A=
	then=0A=
		ENABLE=3D${1}_enable=0A=
		# No enable file? Just set to max=0A=
		if [ ! -f $ENABLE ]=0A=
		then=0A=
			echo $MAX > $1=0A=
			return 0=0A=
		fi=0A=
=0A=
		# Try pwmN_enable=3D0=0A=
		echo 0 > $ENABLE 2> /dev/null=0A=
		if [ `cat $ENABLE` -eq 0 ]=0A=
		then=0A=
			# Success=0A=
			return 0=0A=
		fi=0A=
=0A=
		# It didn't work, try pwmN_enable=3D1 pwmN=3D255=0A=
		echo 1 > $ENABLE 2> /dev/null=0A=
		echo $MAX > $1=0A=
		if [ `cat $ENABLE` -eq 1 -a `cat $1` -ge 190 ]=0A=
		then=0A=
			# Success=0A=
			return 0=0A=
		fi=0A=
=0A=
		# Nothing worked=0A=
		echo "$ENABLE stuck to" `cat $ENABLE` >&2=0A=
		return 1=0A=
	else=0A=
		echo $MAX 0 > $1=0A=
	fi=0A=
}=0A=
=0A=
# $1 =3D pwm file name=0A=
function pwmenable()=0A=
{=0A=
	if [ "$SYSFS" =3D "1" ]=0A=
	then=0A=
		ENABLE=3D${1}_enable=0A=
		if [ -f $ENABLE ]=0A=
		then=0A=
			echo 1 > $ENABLE 2> /dev/null=0A=
			if [ $? -ne 0 ]=0A=
			then=0A=
				return 1=0A=
			fi=0A=
		fi=0A=
		echo $MAX > $1=0A=
	else=0A=
		echo $MAX 1 > $1=0A=
	fi=0A=
}=0A=
=0A=
function restorefans()=0A=
{=0A=
	local status=3D$1=0A=
	echo 'Aborting, restoring fans...'=0A=
	let fcvcount=3D0=0A=
	while (( $fcvcount < ${#AFCPWM[@]} )) # go through all pwm outputs=0A=
	do=0A=
		pwmo=3D${AFCPWM[$fcvcount]}=0A=
		pwmdisable $pwmo=0A=
		let fcvcount=3D$fcvcount+1=0A=
	done=0A=
	echo 'Verify fans have returned to full speed'=0A=
	rm -f "$PIDFILE"=0A=
	exit $status=0A=
}=0A=
=0A=
trap 'restorefans 0' SIGQUIT SIGTERM=0A=
trap 'restorefans 1' SIGHUP SIGINT=0A=
=0A=
# main function=0A=
function UpdateFanSpeeds {=0A=
	let fcvcount=3D0=0A=
	while (( $fcvcount < ${#AFCPWM[@]} )) # go through all pwm outputs=0A=
	do=0A=
		#hopefully shorter vars will improve readability:=0A=
		pwmo=3D${AFCPWM[$fcvcount]}=0A=
		tsens=3D${AFCTEMP[$fcvcount]}=0A=
		fan=3D${AFCFAN[$fcvcount]}=0A=
		mint=3D${AFCMINTEMP[$fcvcount]}=0A=
		maxt=3D${AFCMAXTEMP[$fcvcount]}=0A=
		minsa=3D${AFCMINSTART[$fcvcount]}=0A=
		minso=3D${AFCMINSTOP[$fcvcount]}=0A=
		minpwm=3D${AFCMINPWM[$fcvcount]}=0A=
		maxpwm=3D${AFCMAXPWM[$fcvcount]}=0A=
=0A=
		if [[ ${tsens#command:} !=3D $tsens ]]=0A=
		then=0A=
			command=3D"${tsens#command:}"=0A=
			command=3D"${command//%20/ }"=0A=
			tval=3D"$($command 2>&1)"=0A=
			if [[ $? -ne 0 ]]=0A=
			then=0A=
				echo "Error reading temperature by command '$command':=0A=
$tval"=0A=
				restorefans 1=0A=
			fi=0A=
		else=0A=
			read tval < ${tsens}=0A=
			if [ $? -ne 0 ]=0A=
			then=0A=
				echo "Error reading temperature from $DIR/$tsens"=0A=
				restorefans 1=0A=
			fi=0A=
			if [ "$SYSFS" =3D "1" ]=0A=
			then=0A=
			let tval=3D"($tval+500)/1000"=0A=
			else=0A=
				tval=3D`echo ${tval} | cut -d' ' -f3 | cut -d'.' -f1`=0A=
			fi=0A=
		fi=0A=
=0A=
		read pwmpval < ${pwmo}=0A=
		if [ $? -ne 0 ]=0A=
		then=0A=
			echo "Error reading PWM value from $DIR/$pwmo"=0A=
			restorefans 1=0A=
		fi=0A=
		if [ "$SYSFS" !=3D "1" ]=0A=
		then=0A=
			pwmpval=3D`echo ${pwmpval} | cut -d' ' -f1`=0A=
		fi=0A=
=0A=
		# If fanspeed-sensor output shall be used, do it=0A=
		if [[ -n ${fan} ]]=0A=
		then=0A=
			read fanval < ${fan}=0A=
			if [ $? -ne 0 ]=0A=
			then=0A=
				echo "Error reading Fan value from $DIR/$fan"=0A=
				restorefans 1=0A=
			fi=0A=
			if [ "$SYSFS" !=3D "1" ]=0A=
			then=0A=
				fanval=3D`echo ${fanval} | cut -d' ' -f2`=0A=
			fi=0A=
		else=0A=
			fanval=3D1  # set it to a non zero value, so the rest of the script =
still works=0A=
		fi=0A=
=0A=
		# debug info=0A=
		if [ "$DEBUG" !=3D "" ]=0A=
		then=0A=
			echo "pwmo=3D$pwmo"=0A=
			echo "tsens=3D$tsens"=0A=
			echo "fan=3D$fan"=0A=
			echo "mint=3D$mint"=0A=
			echo "maxt=3D$maxt"=0A=
			echo "minsa=3D$minsa"=0A=
			echo "minso=3D$minso"=0A=
			echo "minpwm=3D$minpwm"=0A=
			echo "maxpwm=3D$maxpwm"=0A=
			echo "tval=3D$tval"=0A=
			echo "pwmpval=3D$pwmpval"=0A=
			echo "fanval=3D$fanval"=0A=
		fi=0A=
=0A=
		if (( $tval <=3D $mint ))=0A=
		  then pwmval=3D$minpwm # below min temp, use defined min pwm=0A=
		elif (( $tval >=3D $maxt ))=0A=
		  then pwmval=3D$maxpwm # over max temp, use defined max pwm=0A=
		else=0A=
		  # calculate the new value from temperature and settings=0A=
		  =
pwmval=3D"(${tval}-${mint})*(${maxpwm}-${minso})/(${maxt}-${mint})+${mins=
o}"=0A=
		  if [ $pwmpval -eq 0 -o $fanval -eq 0 ]=0A=
		  then # if fan was stopped start it using a safe value=0A=
		  	echo $minsa > $pwmo=0A=
			# Sleep while still handling signals=0A=
			sleep 1 &=0A=
			wait $!=0A=
		  fi=0A=
		fi=0A=
		echo $pwmval > $pwmo # write new value to pwm output=0A=
		if [ $? -ne 0 ]=0A=
		then=0A=
			echo "Error writing PWM value to $DIR/$pwmo"=0A=
			restorefans 1=0A=
		fi=0A=
		if [ "$DEBUG" !=3D "" ]=0A=
		then=0A=
			echo "new pwmval=3D$pwmval"=0A=
		fi=0A=
		let fcvcount=3D$fcvcount+1=0A=
	done=0A=
}=0A=
=0A=
echo 'Enabling PWM on fans...'=0A=
let fcvcount=3D0=0A=
while (( $fcvcount < ${#AFCPWM[@]} )) # go through all pwm outputs=0A=
do=0A=
	pwmo=3D${AFCPWM[$fcvcount]}=0A=
	pwmenable $pwmo=0A=
	if [ $? -ne 0 ]=0A=
	then=0A=
		echo "Error enabling PWM on $DIR/$pwmo"=0A=
		restorefans 1=0A=
	fi=0A=
	let fcvcount=3D$fcvcount+1=0A=
done=0A=
=0A=
echo 'Starting automatic fan control...'=0A=
=0A=
# main loop calling the main function at specified intervals=0A=
while true=0A=
do=0A=
	UpdateFanSpeeds=0A=
	# Sleep while still handling signals=0A=
	sleep $INTERVAL &=0A=
	wait $!=0A=
done=0A=

------=_NextPart_000_000C_01C97CB4.04E40660
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_NextPart_000_000C_01C97CB4.04E40660--

