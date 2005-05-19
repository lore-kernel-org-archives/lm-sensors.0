From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:54 +0000
Subject: sensord: rrd database and timeslots
Message-Id: <20040421222823.GA14256@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all !

I received a bug report via the Debian BTS concerning sensord and rrd. I
already started to discuss about it on IRC with Jean Delvare. So let's
start with a summary of the problem.

sensord has an option to log regularly the values of all the sensors
into a round robin database using rrd. The polling interval could be set
using the --rrd-interval option. rrd stores data at fixed interval, or
to be more precised at fixed time slots. For example if you are using a
5 minutes interval it uses the time slots 21:00:00, 21:05:00, 21:10:00, 
21:15:00, etc.

sensord feeds the data every 5 minutes, however not on the time slots
used by rrd (or you are very lucky ;). In that case rrd interpolates the
values that are read, and thus the values in the database don't 
correspond to the read values.

(the full history could be found on http://bugs.debian.org/cgi-bin/bugreport.cgi?bug$4034)


The user who reported the bug on the Debian BTS proposes a patch, 
available on:
http://bugs.debian.org/cgi-bin/bugreport.cgi/sensord-rrdslot.patch?bug$4034&msg&att=1

It contains two parts. The first part fakes that the sensors were read
exactly on the timeslot even if it is not the case. Without the patch 
rrd uses "now" as the time value.

The second part modifies the time where sensors are read. Without the
patch the sensors are read at regular intervals, whereas with the patch
they are read at fixed time slots corresponding to the rrd ones, which
also means at regular intervals.


On IRC, Jean Delvare suggests to disable the interpolation function of
rrd. After some experiments, I found that in that case rrd stores the 
last values it received but it still uses fixed time slots. It means 
that the timestamps don't correspond to the data!

On my side, I suggest to use the second part of the patch only, which
means that the sensors are sampled at fixed time slots. It's also the 
solution given in the examples given with rrd. I don't see why sensord
should fake that the sensors were read exactly on the timeslot. In most
cases the sensors would be read exactly on the time slot, however if it
is not the case (for example on a system with a very high load, if there
is a problem on smbus/i2c, etc.) the data would be interpolated.

I attached the second part of the patch.


Please give me your comments!

Bye,
Aurelien


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN lm-sensors-2.8.6.o/prog/sensord/sensord.c lm-sensors-2.8.6/prog/sensord/sensord.c
--- lm-sensors-2.8.6.o/prog/sensord/sensord.c	2002-06-10 19:56:16.000000000 +0200
+++ lm-sensors-2.8.6/prog/sensord/sensord.c	2004-04-20 00:04:46.000000000 +0200
@@ -28,6 +28,7 @@
 #include <signal.h>
 #include <syslog.h>
 #include <unistd.h>
+#include <time.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 
@@ -75,7 +76,12 @@
 sensord
 (void) {
   int ret = 0;
-  int scanValue = 0, logValue = 0, rrdValue = 0;
+  int scanValue = 0, logValue = 0;
+  /*
+   * First RRD update at next RRD timeslot to prevent failures due
+   * one timeslot updated twice on restart for example.
+   */
+  int rrdValue = rrdTime - time(NULL) % rrdTime;
 
   sensorLog (LOG_INFO, "sensord started");
 
@@ -93,7 +99,11 @@
     }
     if ((ret = 0) && rrdTime && rrdFile && (rrdValue <= 0)) {
       ret = rrdUpdate ();
-      rrdValue += rrdTime;
+      /*
+       * We don't add here, but set because next RRD timeslot starts
+       * exactly then and not sooner!
+       */
+      rrdValue = rrdTime - time(NULL) % rrdTime;
     }
     if (!done && (ret = 0)) {
       int a = logTime ? logValue : INT_MAX;
