From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Date: Thu, 05 Jul 2007 16:11:25 +0000
Subject: [lm-sensors] [PATCH] Improve Documentation/hwmon/sysfs-interface
Message-Id: <200707051811.25312.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch makes it clearer what pwmN_enable in hwmon sysfs means.
This PWM off = fan on weiredness fooled me twice now.

Please apply.

Thanks,
Hans


Signed-off-by: Hans J. Koch <hjk@linutronix.de>

Index: linux-2.6.22-rc/Documentation/hwmon/sysfs-interface
=================================--- linux-2.6.22-rc.orig/Documentation/hwmon/sysfs-interface	2007-07-05 18:05:12.000000000 +0200
+++ linux-2.6.22-rc/Documentation/hwmon/sysfs-interface	2007-07-05 18:05:48.000000000 +0200
@@ -174,7 +174,7 @@
 pwm[1-*]_enable
 		Switch PWM on and off.
 		Not always present even if pwmN is.
-		0: turn off
+		0: turn off (this means the fan is always full on)
 		1: turn on in manual mode
 		2+: turn on in automatic mode
 		Check individual chip documentation files for automatic mode

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
