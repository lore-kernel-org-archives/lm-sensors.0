From: aurelien@jarno.name (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: sensors.conf: explain how to enable/disable beeps
Message-Id: <20040509222513.GA20557@pc.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Currently there isn't any documentation on how to enable/disable beeps
globally in lm-sensors, except when looking into the sources.

I propose to add some comments about that into sensors.conf. The
attached patch add a few lines about beeps at the beginning of that
file, and also a line to the "heavily commented LM78 example".

Bye,
Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN lm_sensors2.orig/etc/sensors.conf.eg lm_sensors2/etc/sensors.conf.eg
--- lm_sensors2.orig/etc/sensors.conf.eg	2004-05-09 22:37:06.000000000 +0200
+++ lm_sensors2/etc/sensors.conf.eg	2004-05-10 00:16:19.000000000 +0200
@@ -221,6 +221,18 @@
 # yet supported; spaces at the end are ignored, though.
 #
 #
+# BEEPS
+# -----
+# Some chips support alarms with beep warnings. When an alarm is triggered
+# you can be warned by a beeping signal through your computer speaker. It
+# is possible to enable all beeping globally using the following line:
+#
+# 	set beep_enable 1
+#
+# or disable them using:
+#
+# 	set beep_enable 0
+#
 ##########################################################################
 #### Here begins the real configuration file
 
@@ -312,6 +324,8 @@
 # the CPU temperature.
 #    label temp "M/B Temp"
 
+# Uncomment the followingline to enable all beeping globally
+#    set beep_enable 1
 
 chip "lm75-*"
 
