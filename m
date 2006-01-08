From: list0570@paradise.net.nz (Volker Kuhlmann)
Date: Sun, 08 Jan 2006 01:33:51 +0000
Subject: [lm-sensors] including fan control in system service script
Message-Id: <20060108013351.GC6625@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The following three files have to be modified to integrate fan control
into the lm_sensors system service script. Behaviour of the service
script is unchanged until the user explicitly configures fan control, so
no change to default behaviour. Tested on SUSE 10.0 and all works fine.
Please include these patches. Thanks,

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.
-------------- next part --------------
This patch for SUSE 10.0 changes the lm_sensors service script to also start and
stop the fan control, if fan control is configured. If fan control is not
configured, this patch has no effect. To configure fan control, read the
documentation of package sensors, and run pwmconfig (as root).

Volker Kuhlmann, 8 Jan 2006



--- /etc/init.d/lm_sensors.orig	2005-09-13 12:34:49.000000000 +1200
+++ /etc/init.d/lm_sensors	2006-01-08 13:16:57.000000000 +1300
@@ -46,6 +46,8 @@
 
 CONFIG=/etc/sysconfig/lm_sensors
 PSENSORS=/usr/bin/sensors
+FANCONFIG=/etc/fancontrol
+PFAN=/usr/sbin/fancontrol
 
 # Source function library.
 . /etc/rc.status
@@ -59,14 +61,33 @@
 		/sbin/modprobe $module &>/dev/null
 		rc_status
 	done
-	rc_status -v && touch /var/lock/subsys/sensors
+	rc_status && touch /var/lock/subsys/sensors
 	/usr/bin/sensors -s &> /dev/null
+
+	# Start fan control, if configured
+	if [ -s "$FANCONFIG" -a -x "$PFAN" ]; then
+	    echo -n "starting fan control: "
+	    "$PFAN" >/dev/null &
+	    echo $! >> /var/lock/subsys/sensors-fan
+	fi
+
+	rc_status -v
 }
 
 stop() {
 	echo -n $"Shutting down sensors: "
 	test -r "$CONFIG" && . "$CONFIG"
 
+	# Stop fan control, if it was started
+	if [ -s /var/lock/subsys/sensors-fan ]; then
+	    echo -n "stopping fan control: "
+	    pid="`cat /var/lock/subsys/sensors-fan`"
+	    kill -TERM "$pid"
+	    rm /var/lock/subsys/sensors-fan
+	    sleep 1 # wait for fancontrol to terminate (any better way?)
+	    true
+	fi
+
 	for i in ${!MODULE_*} ; do
 		eval module=\$$i
 		/sbin/modprobe -r $module &>/dev/null
--- /usr/sbin/fancontrol.orig	2005-09-13 12:34:49.000000000 +1200
+++ /usr/sbin/fancontrol	2006-01-08 12:50:28.000000000 +1300
@@ -277,7 +277,10 @@
 while true
 do
 	UpdateFanSpeeds
-	sleep $INTERVAL
+	# The sleep in the foreground isn't interruptible by kill, which is
+	# unsuitable for system service scripts.  -VK 8Jan06
+	sleep $INTERVAL &
+	wait $!
 done
 
 # some old stuff/missing features, will clean this up soon
-------------- next part --------------
This patch changes pwmconfig to perform much smaller steps when testing fans
which have by far most of their speed change with PWM values below 16. This is
true for the fan shipped with an AMD Athlon64 3200+ CPU.

To make the fan control for this fan work, it is also necessary to adjust the 
MINSTART value in /etc/fancontrol considerably down, probably to somewhere
around 5 (4 works at least while the fan is new), and to adjust the MAXTEMP
value upwards to way above what one consider reasonable (try 90). The latter is
necessary as long as the fancontrol scripts interpolates along a straight line
to find a PWM value as a function of CPU temperature.

Volker Kuhlmann, 8 Jan 2006



--- /usr/sbin/pwmconfig.orig	2005-09-13 12:34:49.000000000 +1200
+++ /usr/sbin/pwmconfig	2005-12-20 23:47:34.000000000 +1300
@@ -188,7 +188,9 @@
 
 PLOTTER=gnuplot
 STEP
-PDELAY=2
+STEP2=2
+STEP2_BELOW1
+PDELAY=3
 
 function pwmdetail()
 {
@@ -256,6 +258,7 @@
 			fi
 			break
 		fi
+		test $pwm -lt $STEP2_BELOW && let STEP=$STEP2
 		let pwm=$pwm-$STEP
 	done
 	pwmdisable $P	
