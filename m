From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:25:29 +0000
Subject: [PATCH] sensord: wrong error message with /proc or /sys not
Message-Id: <20050105212346.GA19356@bode.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

There is currently a bug in sensord, which causes it to print the
following message if /proc files are not accessible:

  Error -4 loading sensors configuration file: /etc/sensors.conf

Not really an explicit message :)

It should instead print the following message.
  Error reading /proc; modules probably not loaded

The problem is that the library returns a negative number if there is an
error, and the error numbers in the .h files are not negative. Thus one
of the operand of the comparison should be negated. Patch to fix that is
attached.

BTW, on 2.6 kernels the sensors informations are in /sys and not /proc.
The message may be changed into:

  Error reading /proc or /sys; modules probably not loaded

Bye,
Aur?lien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: prog/sensord/lib.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensord/lib.c,v
retrieving revision 1.4
diff -u -1 -b -p -r1.4 lib.c
--- prog/sensord/lib.c	31 Jul 2002 14:27:49 -0000	1.4
+++ prog/sensord/lib.c	5 Jan 2005 21:22:07 -0000
@@ -81,3 +81,3 @@ loadConfig
       if ((ret = sensors_init (stdin))) {
-        if (ret = SENSORS_ERR_PROC)
+        if (ret = -SENSORS_ERR_PROC)
           sensorLog (LOG_ERR, "Error reading /proc; modules probably not loaded");
@@ -98,3 +98,3 @@ loadConfig
     } else if ((ret = sensors_init (cfg))) {
-      if (ret = SENSORS_ERR_PROC)
+      if (ret = -SENSORS_ERR_PROC)
         sensorLog (LOG_ERR, "Error reading /proc; modules probably not loaded");
