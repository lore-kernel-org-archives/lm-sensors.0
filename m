From: "Leslie Rhorer" <lrhorer@mygrande.net>
Date: Sat, 17 Nov 2012 17:42:41 +0000
Subject: Re: [lm-sensors] Getting alarms using lm-sensors
Message-Id: <201211171742.qAHHggjw002664@mx3.lsn.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <201211160616.qAG6GnV2010183@mx3.lsn.net>
In-Reply-To: <201211160616.qAG6GnV2010183@mx3.lsn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> exists.
> 	if [[ -n $STATL ]]				# If so, check how
> old it is.
> 	then
> 		ESEC=$( date +%s )			# Get epoch time.
> 		SSEC=$( echo $STATL | cut -d ":" -f2 )	# Get elapsed time.
> 		TSEC=$((ESEC - SSEC))			# Compute the
> difference.
> 		if [[ $TSEC -gt $NOTIFY ]]		# If more than
> $NOTIFY seconds have passed, upodate the file
> 		then
> 			WRITE=0				# Set up for e-mail
> notification
> 			grep -v $SID $SenseStat > $SenseStat.tmp
> 			mv $SenseStat.tmp $SenseStat
> 		fi
> 	else
> 		WRITE=0					# Alarm is not yet
> active, so set up to send the e-mail and update $SenseStat
> 	fi
> 
> 	if [[ $WRITE -eq 0 ]]				# If $WRITE is
> reset, send the e-mail and update $SenseStat
> 	then
> 		echo "$TID $ATEXT  Value: $F2" | mail -a "Content-Type:
> text/plain; charset=UTF-8" -a From:sensor_monitor -s "Server Sensor Event
> Notification" xxxxxxxxxxxxx@myemail1.com yyyyyyyyyyyy@myemail2.net
> 		echo "$SID:$ESEC:$ACTION" >> $SenseStat
> 		sleep 1
> 	fi
> }
> 
> while read line						# Read and
process
> one line of $SenseTab at a time

Ugh.  That looks terrible.  Is there a way to prevent the mail system from
wrapping the text, or would it be better served to make them attachments?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
