From: "Jeffrey J. Kosowsky" <lm_sensors@kosowsky.org>
Date: Tue, 17 Apr 2007 13:34:38 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <17956.52462.160890.512063@consult.pretender>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote at about 11:19:15 +0200 on Tuesday, April 17, 2007:
 > Hi Jeff,
 > 
 > On Sun, 15 Apr 2007 07:48:42 +0000 (UTC), jk wrote:
 > > Jean Delvare <khali <at> linux-fr.org> writes:
 > > > On 08 Apr 2007 16:17:31 -0400, lmsensors <at> kosowsky.org wrote:
 
 > > And in fact, I have now adjusted the code to first check for existence of hwmon
 > > (and I also wrote another cleaner version that only looks at hwmon but I
 > > understand why you may not want that so as to preserve backwards compatibility.)
 > 
 > Actually, we've branched SVN development now and we have a branch which
 > will only support recent 2.6 kernels. So if you send this other patch
 > to us, we could apply it to that branch. Please check your e-mail client
 > settings first though, as the patch below was corrupted (tabs replaced
 > by spaces, trailing space deleted), I had to fix it by hand in order to
 > apply it.

Actually, I think the problem was due to the fact that I posted via
gmane and somehow my cut-paste from a putty xterm on my Linux machine
to a Firefox html text box on my Windoze machine messed up the
tabs. So, I am mailing this directly from my Linux machine.

Here is the trimmed/streamlined version for 2.6 only:
[Note I also made the sensor an optional input parameter that defaults
to hwmon0 since that seems to be the most likely case for most users]

--- sens_update_rrd	2007-04-17 09:03:08.000000000 -0400
+++ sens_update_rrd.new	2007-04-17 09:16:26.000000000 -0400
@@ -2,9 +2,9 @@
 #    sens_update_rrd -
 #	Update a sensors rrd database.
 #	Sample usage:
-#		sens_update_rrd /var/lib/database.rrd w83781d-isa-0290
+#		sens_update_rrd /var/lib/database.rrd hwmon0
 #	Sample cron entry:
-#		*/5 * * * * /usr/local/bin/sens_update_rrd /var/lib/sensors-rrd/sensors.rrd w83781d-isa-0290
+#		*/5 * * * * /usr/local/bin/sens_update_rrd /var/lib/sensors-rrd/sensors.rrd hwmon0
 #
 #################################################################
 #
@@ -26,48 +26,35 @@
 #
 #################################################################
 #
-if [ $# -ne 2 ]
+if [ $# -lt 1 ]
 then
-	echo "usage: $0 database.rrd sensor"
-	echo "       sensor example: w83781d-isa-0290 (2.4) or 0-0290 (2.6)"
+	echo "usage: $0 database.rrd [hwmonN]"
 	exit 1
 fi
 #
 RRDPATH=/usr/bin
 RRDB=$1
 
-SENSDIR=/proc/sys/dev/sensors
-SDIR=/sys/bus/i2c/devices
-if [ ! -d $SENSDIR ]
-then
-	if [ ! -d $SDIR ]
-	then
-		echo $0: 'No sensors found! (modprobe sensor modules?)'
-		exit 1
-	else
-		SYSFS=1
-		SENSDIR=$SDIR
-	fi	
-fi
+SENSDIR=/sys/class/hwmon
+HWMON=hwmon0
+[ $2 ] && HWMON=$2
+SENS=$SENSDIR/$HWMON/device
 
-SENSDEV=$2
-SENS=$SENSDIR/$SENSDEV
-if [ ! -r $SENS ]
+if [ ! -d $SENS ]
 then
-	echo $0: 'No sensors found! (modprobe sensor modules?)'
+	echo "No sensors found in: $SENS"
+	echo "(modprobe sensor modules?)"
 	exit 1
 fi
 
 STRING=N
-if [ "$SYSFS" = "1" ]
-then
 	#
 	# Get the value from these sensor files (/sys)
 	#
 	SENSORS="fan1 fan2 fan3"
 	for i in $SENSORS
 	do
-		V="`cat $SENSDIR/$SENSDEV/${i}_input 2> /dev/null`"
+	V="`cat $SENS/${i}_input 2> /dev/null`"
 		if [ $? -ne 0 ]
 		then
 			STRING="${STRING}:U"
@@ -81,7 +68,7 @@
 	SENSORS="temp1 temp2 temp3 in0 in1 in2 in3 in4 in5 in6"
 	for i in $SENSORS
 	do
-		V="`cat $SENSDIR/$SENSDEV/${i}_input 2> /dev/null`"
+	V="`cat $SENS/${i}_input 2> /dev/null`"
 		if [ $? -ne 0 ]
 		then
 			STRING="${STRING}:U"
@@ -90,38 +77,6 @@
 			STRING="${STRING}:${V}"
 		fi
 	done
-else
-	#
-	# Get the second value from these sensor files (/proc)
-	#
-	SENSORS="fan1 fan2 fan3"
-	for i in $SENSORS
-	do
-		V="`cat $SENSDIR/$SENSDEV/$i 2> /dev/null`"
-		if [ $? -ne 0 ]
-		then
-			STRING="${STRING}:U"
-		else
-			V="`echo $V | cut -d ' ' -f 2`"
-			STRING="${STRING}:${V}"
-		fi
-	done
-	#
-	# Get the third value from these sensor files (/proc)
-	#
-	SENSORS="temp1 temp2 temp3 in0 in1 in2 in3 in4 in5 in6"
-	for i in $SENSORS
-	do
-		V="`cat $SENSDIR/$SENSDEV/$i 2> /dev/null`"
-		if [ $? -ne 0 ]
-		then
-			STRING="${STRING}:U"
-		else
-			V="`echo $V | cut -d ' ' -f 3`"
-			STRING="${STRING}:${V}"
-		fi
-	done
-fi
 
 #
 # Get the first value from these /proc files



 > > In any case, I am happy to help where I can, but I don't appreciate being
 > > accused of complaining or of having unreasonable expectations that I never
 > > myself expressed or implied.
 > 
 > Sorry, it seems I've been a bit rude with you while you didn't deserve
 > it. I must have had a bad day or something. Please accept my apologies.
 > 
No problem -- I appreciate all that you do for this project.

 > You mentioned that sensors.conf.5 was out-of-date, can you please send
 > a patch for it too?

I'm not sure how to fix some of this since I'm not really sure what
the 2.6 equivalent is, but here are the lines that need adjusting:

1.	The  second and third arguments are the description texts. They must
	be exactly match the texts as they appear  in  /proc/bus/i2c,
	except for trailing  spaces, which are removed both from the /proc entries
	and the arguments.

	[I don't know where you find the 'second and third argument'
	(which are the chip description) in 2.6 kernels]

2.	The  program  prog/config/grab_busses.sh in the source distribution
	can help you generate these lines.

	[This program needs to be fixed for Kernel 2.6 -- I don't use it
	so I don't know exactly what it does or how to fix it]


3.  The chip descriptions are equal to those appearing in
    /proc/sys/dev/sensors, but may contain the * wildcard.

	[Again, I don't know where you find the chip descriptions in 2.6
	kernels]

More generally, you may want to have someone who is more familiar with
the 'lm_sensors' project to review the full man page since it seems like
it hasn't been changed since Feb 1999.

Sorry, I couldn't be more helpful here...

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
