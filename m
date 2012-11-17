From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Sat, 17 Nov 2012 20:13:55 +0000
Subject: Re: [lm-sensors] Getting alarms using lm-sensors
Message-Id: <201211172013.qAHKDtZi030400@mx3.lsn.net>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_NextPart_000_000C_01CDC4CD.C82F5F60"
List-Id: <lm-sensors.vger.kernel.org>
References: <201211160616.qAG6GnV2010183@mx3.lsn.net>
In-Reply-To: <201211160616.qAG6GnV2010183@mx3.lsn.net>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_000C_01CDC4CD.C82F5F60
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

	OK, I'm sending this back out.  I've made a couple of changes,
anyway.  There is a little bug in the script, but I've beaten myself around
the head and can't figure out what is causing it.  If someone can tell me
what it is, I will happily fix it.  I put a little trap in the code which
checks to make sure the sensor name in the sensetab file matches a line from
the output of `sensors`.  If not, it sends an e-mail and jumps to the next
sensor.  For some reason, it is sending out two e-mails.
 


------=_NextPart_000_000C_01CDC4CD.C82F5F60
Content-Type: application/octet-stream;
	name="sensetab"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="sensetab"

V01:.85:1.6:Vcore Voltage:Vcore:alarm:boot:is low:is critical. Shutting =
down...=0A=
V02:10.2:13.8:+12V Voltage:+12V:alarm:boot:is out of bounds:is critical. =
Shutting down...=0A=
V03:4.5:5.5:+5V Voltage:+5V:alarm:boot:is out of bounds:is critical. =
Shutting down...=0A=
V04:2.97:3.63:+3.3V Voltage:+3.3V:alarm:boot:is out of bounds:is =
critical. Shutting down...=0A=
V05:1.71:2.09:DDR2:Memory Voltage:alarm:boot:is out of bounds:is =
critical. Shutting down...=0A=
V06:1.08:1.32:HT:HyperThreading Voltage:alarm:boot:is out of bounds:is =
critical. Shutting down...=0A=
V07:.99:1.61:SB:SouthBridge Voltage:alarm:boot:is out of bounds:is =
critical. Shutting down...=0A=
V08:1.08:1.32:BR:BR Voltage:alarm:boot:is out of bounds:is critical. =
Shutting down...=0A=
V09:2.25:2.85:VDDA:VDDA Voltage:alarm:boot:is out of bounds:is critical. =
Shutting down...=0A=
V10:.85:1.04:DDR2 TERM.:Memory Termination:alarm:boot:is out of =
bounds:is critical. Shutting down...=0A=
V11:1.14:1.43:VDDNB:NorthBridge Voltage:alarm:boot:is out of bounds:is =
critical. Shutting down...=0A=
F01:800::CPU_FAN FAN Speed:CPU Fan:alarm::is failing:=0A=
F02:800::CHA_FAN1 FAN Speed:Rear Fan #1::alarm:is failing:=0A=
F03:800::CHA_FAN2 FAN Speed:Rear Fan #2::alarm:is failing:=0A=
F04:::OPT_FAN1 FAN Speed::alarm::is failing=0A=
F05:::OPT_FAN2 FAN Speed::alarm::is failing=0A=
F06:::OPT_FAN3 FAN Speed:Water Cooler Fan:alarm::is failing=0A=
F07:800::PWR_FAN FAN Speed:Power Supply Fan:alarm::is failing=0A=
F08:::CHA_FAN3 FAN Speed:Water Cooler Pump:alarm::is failing=0A=
T01:50:85:CPU Temperature:CPU Temperature:alarm:boot:is too high.:is =
critical.  Shutting down...=0A=
T02:53:85:MB Temperature:Motherboard Temperature:alarm:boot:is too =
high.:is critical.  Shutting down... =0A=
T03:::OPT1:Coolant Level:alarm::is too low.  Add coolant.:=0A=
T04:::OPT2:::::=0A=
T05:::OPT3::::: =0A=
T06:::temp1:::::=0A=

------=_NextPart_000_000C_01CDC4CD.C82F5F60
Content-Type: application/octet-stream;
	name="alarm_scan"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="alarm_scan"

#! /bin/bash=0A=
=0A=
export LC_ALL=3Den_US.UTF-8=0A=
export LANG=3Den_US.UTF-8=0A=
export LANGUAGE=3Den_US.UTF-8=0A=
=0A=
SenseDir=3D/usr/share/sensors	# Location of files=0A=
SenseTab=3D$SenseDir/sensetab	# Lookup table=0A=
SenseStat=3D$SenseDir/alarm_stat	# Status file containing active alarms, =
when the last e-mail was sent in epoch time, and the action taken.=0A=
NOTIFY=3D1200			# Number of seconds between e-mail notifications for =
each event=0A=
=0A=
# Field number position identifiers in $SenseTab.  Modify to add, =
delete, or move fields in the table.=0A=
PosSID=3D"-f1"=0A=
PosLVAL=3D"-f2"=0A=
PosHVAL=3D"-f3"=0A=
PosAID=3D"-f4"=0A=
PosTID=3D"-f5"=0A=
PosBRL1=3D"-f6"=0A=
PosBRH1=3D"-f7"=0A=
PosBRL2=3D"-f8"=0A=
PosBRH2=3D"-f9"=0A=
=0A=
cd $SenseDir=0A=
=0A=
# Command to send mail.  Modify to suit individual needs.=0A=
mail_out ()=0A=
{=0A=
	echo $1 | mail -a "Content-Type: text/plain; charset=3DUTF-8" -a =
From:sensor_monitor -s "$(hostname) Sensor Event Notification" =
xxxxxxxxx@myemaill1.com yyyyyyyy@myemail2.com =0A=
}=0A=
=0A=
=0A=
# Check the lower boundary for violations.=0A=
lo_check()=0A=
{=0A=
	if [[ $MINMAX -eq 0 ]]=0A=
	then=0A=
		(( $(echo "$CVAL > $LVAL" | bc -l) )) && BERRL=3D1=0A=
	else=0A=
		(( $(echo "$CVAL < $LVAL" | bc -l) )) && BERRL=3D2=0A=
	fi=0A=
	[[ $BERRL -gt 0 ]] && action_check $PosBRL1 $PosBRL2=0A=
}=0A=
=0A=
# Check the upper boundary for violations.=0A=
hi_check()=0A=
{=0A=
	(( $(echo "$CVAL > $HVAL" | bc -l) )) && BERRH=3D1=0A=
	[[ $BERRH -gt 0 ]] && action_check $PosBRH1 $PosBRH2=0A=
}=0A=
=0A=
# Set the ACTION directive.  1 =3D Send Alarm  2 =3D Shutdown=0A=
action_check ()=0A=
{=0A=
	ACTION=3D1=0A=
	[[ $(echo $line | cut -d ":" $1 ) =3D=3D "boot" ]] && ACTION=3D2=0A=
	ATEXT=3D$(echo $line | cut -d ":" $2 )		# $ATEXT =3D Text action for =
e-mail=0A=
}=0A=
=0A=
# Check if the alarm is already active and if so how long ago the e-mail =
was sent.=0A=
# Do nothing if the alarm is already active and $NOTIFY seconds or less =
have passed.=0A=
# Send e-mail and update $SenseStat if more than $NOTIFY seconds have =
passed.=0A=
alarm_email ()=0A=
{=0A=
	WRITE=3D1=0A=
	touch $SenseStat				# Make sure the file exists.=0A=
	STATL=3D$( grep $SID $SenseStat )			# See if the alarm exists.=0A=
	if [[ -n $STATL ]]				# If so, check how old it is.=0A=
	then=0A=
		ESEC=3D$( date +%s )			# Get epoch time.=0A=
		SSEC=3D$( echo $STATL | cut -d ":" -f2 )	# Get elapsed time.=0A=
		TSEC=3D$((ESEC - SSEC))			# Compute the difference.=0A=
		if [[ $TSEC -gt $NOTIFY ]]		# If more than $NOTIFY seconds have =
passed, upodate the file=0A=
		then=0A=
			WRITE=3D0				# Set up for e-mail notification=0A=
			grep -v $SID $SenseStat > $SenseStat.tmp=0A=
			mv $SenseStat.tmp $SenseStat=0A=
		fi=0A=
	else=0A=
		WRITE=3D0					# Alarm is not yet active, so set up to send the e-mail =
and update $SenseStat=0A=
	fi=0A=
=0A=
	if [[ $WRITE -eq 0 ]]				# If $WRITE is reset, send the e-mail and =
update $SenseStat=0A=
	then=0A=
		mail_out "$TID $ATEXT  Value: $F2"=0A=
		echo "$SID:$ESEC:$ACTION" >> $SenseStat=0A=
		sleep 1=0A=
	fi=0A=
}=0A=
=0A=
while read line						# Read and process one line of $SenseTab at a time=0A=
do=0A=
	SCAN=3D0=0A=
	SID=3D$( echo $line | cut -d ":" $PosSID )	# $SID =3D Sensor ID=0A=
	AID=3D$(echo $line | cut -d ":" $PosAID )		# $AID =3D Sensor Name=0A=
	TID=3D$(echo $line | cut -d ":" $PosTID )		# $TID =3D Text Name for =
e-mail=0A=
	FIELDS=3D$( sensors | grep "$AID:" )		# $FIELDS =3D Text from `sensors`=0A=
=0A=
	if [[ -z $FIELDS ]]				# Check to make sure $AID is a valid line from =
the output of `sensors`.=0A=
	then=0A=
		mail_out "$AID field not found in output of sensors on $(hostname)"=0A=
		continue=0A=
	fi=0A=
=0A=
	F2=3D$( echo $FIELDS | cut -d ":" -f2 )		# $F2 =3D Description from =
`sensors`=0A=
	CVAL=3D${F2% (*}					# $CVAL =3D Current Sensor Value=0A=
	CVAL=3D${CVAL//[A-Z=C2=B0+]/ }=0A=
	LVAL=3D$(grep $SID $SenseTab | cut -d ":" $PosLVAL )	# $LVAL =3D Lower =
Configured Value=0A=
	HVAL=3D$(grep $SID $SenseTab | cut -d ":" $PosHVAL )	# $HVAL =3D Higher =
Configured Value=0A=
	AVAL=3D${FIELDS#* =3D}				# $AVAL =3D Lower Default Value=0A=
	AVAL=3D${AVAL%,*}=0A=
	AVAL=3D${AVAL//[A-Z=C2=B0+) ]/ }=0A=
	BVAL=3D${FIELDS##* =3D }				# $BVAL =3D Higher Default Value=0A=
	BVAL=3D${BVAL//[A-Z=C2=B0+) ]/ }=0A=
	[[ -n $LVAL ]] && SCAN=3D1			# $SCAN: 1 - Lower value only=0A=
	[[ -n $HVAL ]] && SCAN=3D2			# $SCAN: 2 - Higher value only=0A=
	[[ -n $LVAL && -n $HVAL ]] && SCAN=3D3		# $SCAN: 3 - Lower & Higher =
value=0A=
	MINMAX=3D1					# $MINMAX: 1 - Minimum & Maximum=0A=
	echo $F2 | grep -q crit && MINMAX=3D0		# $MINMAX: 0 - High & Critical=0A=
	BERRL=3D0						# $BERRL: 0 - No Alarm, 1 - Above High, 2 - Below Minimum=0A=
	BERRH=3D0						# $BERRH: 0 - No Alarm, 1 - Above Maximum / Critical=0A=
	ACTION=3D0					# $ACTION: 0 - Do Nothing, 1 - Send e-mail, 2 - Shutdown=0A=
=0A=
	case "$SCAN" in		# Check low boundary, high boundary, or both based =
upon whether they are defined in $SenseStat.=0A=
  	1)=0A=
		lo_check	# Check low boundary.=0A=
	;;=0A=
	2)=0A=
		hi_check	# Check high boundary.=0A=
	;;=0A=
	3)=0A=
		lo_check	# Check both.=0A=
		hi_check=0A=
	;;=0A=
	esac=0A=
=0A=
	case "$ACTION" in	# Perform action based upon values in $SenseTab.  =
alarm =3D send e-mail  boot =3D shutdown=0A=
	0)			# Take no action, except to clear the alarm in $SenseStat, if it =
is active.=0A=
		grep -q $SID $SenseStat=0A=
		if [[ $? -eq 0 ]]=0A=
		then=0A=
			grep -v $SID $SenseStat > $SenseStat.tmp=0A=
			mv $SenseStat.tmp $SenseStat=0A=
		fi=0A=
	;;=0A=
	2)			# Shutdown, allowing enough time for the e-mail to be sent=0A=
		shutdown -py 30 &=0A=
	;&=0A=
	1)			# Send the e-mail=0A=
		alarm_email=0A=
	;;=0A=
	esac=0A=
done < $SenseTab=0A=

------=_NextPart_000_000C_01CDC4CD.C82F5F60
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_NextPart_000_000C_01CDC4CD.C82F5F60--

