From: aurelien@jarno.name (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: sensors.conf: explain how to enable/disable beeps
Message-Id: <20040510131034.GA13177@pc.aurel32.lan>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040509222513.GA20557@pc.aurel32.lan>
In-Reply-To: <20040509222513.GA20557@pc.aurel32.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, May 09, 2004 at 05:16:23PM -0700, Philip Pokorny wrote:
> I'd suggest you not use the term "globally" as that implies (to *me* 
> anyway) that it applies to all chips in the system, when in fact it only 
> applies to the chip in which it appears.
You're right. I didn't think to the fact that this file is the same for
all chips when writing this comment.

I fixed it using your suggestion, please find a new patch attached.


-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
diff -urN lm_sensors2.orig/etc/sensors.conf.eg lm_sensors2/etc/sensors.conf.eg
--- lm_sensors2.orig/etc/sensors.conf.eg	2004-05-10 14:55:55.000000000 +0200
+++ lm_sensors2/etc/sensors.conf.eg	2004-05-10 14:52:16.000000000 +0200
@@ -221,6 +221,19 @@
 # yet supported; spaces at the end are ignored, though.
 #
 #
+# BEEPS
+# -----
+# Some chips support alarms with beep warnings. When an alarm is triggered
+# you can be warned by a beeping signal through your computer speaker. It
+# is possible to enable beeps for all alarms on a chip using the following 
+# line:
+#
+# 	set beep_enable 1
+#
+# or disable them using:
+#
+# 	set beep_enable 0
+#
 ##########################################################################
 #### Here begins the real configuration file
 
@@ -312,6 +325,8 @@
 # the CPU temperature.
 #    label temp "M/B Temp"
 
+# Uncomment the following line to enable all beeping globally
+#    set beep_enable 1
 
 chip "lm75-*"
 
