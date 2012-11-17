From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Sat, 17 Nov 2012 17:33:10 +0000
Subject: Re: [lm-sensors] Getting alarms using lm-sensors
Message-Id: <201211171733.qAHHXBLx022042@mx3.lsn.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201211160616.qAG6GnV2010183@mx3.lsn.net>
In-Reply-To: <201211160616.qAG6GnV2010183@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Saturday, November 17, 2012 10:35 AM
> To: Leslie Rhorer
> Cc: 'Guenter Roeck'; lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] Getting alarms using lm-sensors
> 
> On Sat, 17 Nov 2012 10:10:31 -0600, Leslie Rhorer wrote:
> > OK, this works:
> >
> > mail -a "Content-Type: text/plain; charset=UTF-8" -a From:sensor_monitor
> -s
> > "RAID-Server Sensor Event Notification" ...
> >
> > Would you guys be interested in me posting the script for future
> reference?
> 
> Sure, why not. Our reference script is:
> http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/daemon/healthd.sh
> but it assumes the chip and driver report alarms on out-of-bounds
> conditions.
> 
> --
> Jean Delvare

OK, well here is one that supports a chip or drive that does not report OOB
conditions.  Comments and bug reports most welcome.  First, there must exist
a colon-delimited table named "sensetab" unique to the output of `sensors`
on the system in question.  Here is an example from this system:

V01:.85:1.6:Vcore Voltage:Vcore:alarm:boot:is low:is critical. Shutting
down...
V02:10.2:13.8:+12V Voltage:+12V:alarm:boot:is out of bounds:is critical.
Shutting down...
V03:4.5:5.5:+5V Voltage:+5V:alarm:boot:is out of bounds:is critical.
Shutting down...
V04:2.97:3.63:+3.3V Voltage:+3.3V:alarm:boot:is out of bounds:is critical.
Shutting down...
V05:1.71:2.09:DDR2:Memory Voltage:alarm:boot:is out of bounds:is critical.
Shutting down...
V06:1.08:1.32:HT:HyperThreading Voltage:alarm:boot:is out of bounds:is
critical. Shutting down...
V07:.99:1.61:SB:SouthBridge Voltage:alarm:boot:is out of bounds:is critical.
Shutting down...
V08:1.08:1.32:BR:BR Voltage:alarm:boot:is out of bounds:is critical.
Shutting down...
V09:2.25:2.85:VDDA:VDDA Voltage:alarm:boot:is out of bounds:is critical.
Shutting down...
V10:.85:1.04:DDR2 TERM.:Memory Termination:alarm:boot:is out of bounds:is
critical. Shutting down...
V11:1.14:1.43:VDDNB:NorthBridge Voltage:alarm:boot:is out of bounds:is
critical. Shutting down...
F01:800::CPU_FAN FAN Speed:CPU Fan:alarm::is failing:
F02:800::CHA_FAN1 FAN Speed:Rear Fan #1::alarm:is failing:
F03:800::CHA_FAN2 FAN Speed:Rear Fan #2::alarm:is failing:
F04:::OPT_FAN1 FAN Speed::alarm::is failing
F05:::OPT_FAN2 FAN Speed::alarm::is failing
F06:::OPT_FAN3 FAN Speed:Water Cooler Fan:alarm::is failing
F07:800::PWR_FAN FAN Speed:Power Supply Fan:alarm::is failing
F08:::CHA_FAN3 FAN Speed:Water Cooler Pump:alarm::is failing
T01:50:85:CPU Temperature:CPU Temperature:alarm:boot:is too high.:is
critical.  Shutting down...
T02:53:85:MB Temperature:Motherboard Temperature:alarm:boot:is too high.:is
critical.  Shutting down... 
T03:::OPT1:Coolant Level:alarm::is too low.  Add coolant.:
T04:::OPT2:::::
T05:::OPT3::::: 
T06:::temp1:::::

In this version, the fields are:
F1 - SensorID
F2 - First boundary value
F3 - Second boundary value
F4 - Name of sensor output by `sesnors`
F5 - Name of sensor sent in e-mail
F6 - Action to take if first boundary is violated ( alarm or boot )
F7 - Action to take if second boundary is violated ( alarm or boot )
F8 - Failure text to send in e-mail if first boundary is violated
F9 - Failure text to send in e-mail if second boundary is violated

These fields can easily be moved, added, or deleted by assigning the -f
values at the top of the script.  Blank fields are ignored, but all fields
should exist on every line.

Now the script itself:

#! /bin/bash

export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

SenseDir=/usr/share/sensors	# Location of files
SenseTab=$SenseDir/sensetab	# Lookup table
SenseStat=$SenseDir/alarm_stat	# Status file containing active alarms, when
the last e-mail was sent in epoch time, and the action taken.
NOTIFY=1200			# Number of seconds between e-mail
notifications for each event

# Field number position identifiers in $SenseTab.  Modify to add, delete, or
move fields in the table
PosSID="-f1"
PosLVAL="-f2"
PosHVAL="-f3"
PosAID="-f4"
PosTID="-f5"
PosBRL1="-f6"
PosBRH1="-f7"
PosBRL2="-f8"
PosBRH2="-f9"

cd $SenseDir

# Check the lower boundary for violations.
lo_check()
{
	if [[ $MINMAX -eq 0 ]]
	then
		(( $(echo "$CVAL > $LVAL" | bc -l) )) && BERRL=1
	else
		(( $(echo "$CVAL < $LVAL" | bc -l) )) && BERRL=2
	fi
	[[ $BERRL -gt 0 ]] && action_check $PosBRL1 $PosBRL2
}

# Check the upper boundary for violations.
hi_check()
{
	(( $(echo "$CVAL > $HVAL" | bc -l) )) && BERRH=1
	[[ $BERRH -gt 0 ]] && action_check $PosBRH1 $PosBRH2
}

# Set the ACTION directive.  1 = Send Alarm  2 = Shutdown
action_check ()
{
	ACTION=1
	[[ $(echo $line | cut -d ":" $1 ) == "boot" ]] && ACTION=2
	ATEXT=$(echo $line | cut -d ":" $2 )		# $ATEXT = Text
action for e-mail
}

# Check if the alarm is already active and if so how long ago the e-mail was
sent.
# Do nothing if the alarm is already active and $NOTIFY seconds or less have
passed.
# Send e-mail and update $SenseStat if more than $NOTIFY seconds have
passed.
alarm_email ()
{
	WRITE=1
	touch $SenseStat				# Make sure the file
exists.
	STATL=$( grep $SID $SenseStat )			# See if the alarm
exists.
	if [[ -n $STATL ]]				# If so, check how
old it is.
	then
		ESEC=$( date +%s )			# Get epoch time.
		SSEC=$( echo $STATL | cut -d ":" -f2 )	# Get elapsed time.
		TSEC=$((ESEC - SSEC))			# Compute the
difference.
		if [[ $TSEC -gt $NOTIFY ]]		# If more than
$NOTIFY seconds have passed, upodate the file
		then
			WRITE=0				# Set up for e-mail
notification
			grep -v $SID $SenseStat > $SenseStat.tmp
			mv $SenseStat.tmp $SenseStat
		fi
	else
		WRITE=0					# Alarm is not yet
active, so set up to send the e-mail and update $SenseStat
	fi

	if [[ $WRITE -eq 0 ]]				# If $WRITE is
reset, send the e-mail and update $SenseStat
	then
		echo "$TID $ATEXT  Value: $F2" | mail -a "Content-Type:
text/plain; charset=UTF-8" -a From:sensor_monitor -s "Server Sensor Event
Notification" xxxxxxxxxxxxx@myemail1.com yyyyyyyyyyyy@myemail2.net
		echo "$SID:$ESEC:$ACTION" >> $SenseStat
		sleep 1
	fi
}

while read line						# Read and process
one line of $SenseTab at a time
do
	SCAN=0
	SID=$( echo $line | cut -d ":" $PosSID )	# $SID = Sensor ID
	AID=$(echo $line | cut -d ":" $PosAID )		# $AID = Sensor Name
	TID=$(echo $line | cut -d ":" $PosTID )		# $TID = Text Name
for e-mail
	FIELDS=$( sensors | grep "$AID:" )		# $FIELDS = Text
from `sensors`
	F2=$( echo $FIELDS | cut -d ":" -f2 )		# $F2 = Description
from `sensors`
	CVAL=${F2% (*}					# $CVAL = Current
Sensor Value
	CVAL=${CVAL//[A-Z°+]/ }
	LVAL=$(grep $SID $SenseTab | cut -d ":" $PosLVAL )	# $LVAL =
Lower Configured Value
	HVAL=$(grep $SID $SenseTab | cut -d ":" $PosHVAL )	# $HVAL =
Higher Configured Value
	AVAL=${FIELDS#* =}				# $AVAL = Lower
Default Value
	AVAL=${AVAL%,*}
	AVAL=${AVAL//[A-Z°+) ]/ }
	BVAL=${FIELDS##* = }				# $BVAL = Higher
Default Value
	BVAL=${BVAL//[A-Z°+) ]/ }
	[[ -n $LVAL ]] && SCAN=1			# $SCAN: 1 - Lower
value only
	[[ -n $HVAL ]] && SCAN=2			# $SCAN: 2 - Higher
value only
	[[ -n $LVAL && -n $HVAL ]] && SCAN=3		# $SCAN: 3 - Lower &
Higher value
	MINMAX=1					# $MINMAX: 1 -
Minimum & Maximum
	echo $F2 | grep -q crit && MINMAX=0		# $MINMAX: 0 - High
& Critical
	BERRL=0						# $BERRL: 0 - No
Alarm, 1 - Above High, 2 - Below Minimum
	BERRH=0						# $BERRH: 0 - No
Alarm, 1 - Above Maximum / Critical
	ACTION=0					# $ACTION: 0 - Do
Nothing, 1 - Send e-mail, 2 - Shutdown

	case "$SCAN" in		# Check low boundary, high boundary, or both
based upon whether they are defined in $SenseStat.
  	1)
		lo_check	# Check low boundary.
	;;
	2)
		hi_check	# Check high boundary.
	;;
	3)
		lo_check	# Check both.
		hi_check
	;;
	esac

	case "$ACTION" in	# Perform action based upon values in
$SenseTab.  alarm = send e-mail  boot = shutdown
	0)			# Take no action, except to clear the alarm
in $SenseStat, if it is active.
		grep -q $SID $SenseStat
		if [[ $? -eq 0 ]]
		then
			grep -v $SID $SenseStat > $SenseStat.tmp
			mv $SenseStat.tmp $SenseStat
		fi
	;;
	2)			# Shutdown, allowing enough time for the
e-mail to be sent
		shutdown -py 30 &
	;&
	1)			# Send the e-mail
		alarm_email
	;;
	esac
done < $SenseTab


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
