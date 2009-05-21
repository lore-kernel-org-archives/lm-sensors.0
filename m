From: "Engelmayer Christian" <Christian.Engelmayer@frequentis.com>
Date: Thu, 21 May 2009 21:57:51 +0000
Subject: [lm-sensors] [PATCH 1/1] hwmon: Updated documentation on alarms
Message-Id: <9EE81EBECB70824985BE0EDA8DC9B515021B3103@VIECLEX01.frequentis.frq>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Christian Engelmayer <christian.engelmayer@frequentis.com>

Added gpio channel alarm and fan limit alarm 'max_alarm' to the alarm
section.

Signed-off-by: Christian Engelmayer <christian.engelmayer@frequentis.com>
---

--- Documentation/hwmon/sysfs-interface.orig	2009-05-21 23:03:27.000000000
+0200
+++ Documentation/hwmon/sysfs-interface	2009-05-21 23:42:31.000000000 +0200
@@ -379,6 +379,7 @@ implementation.
 in[0-*]_alarm
 fan[1-*]_alarm
 temp[1-*]_alarm
+gpio[0-*]_alarm
 		Channel alarm
 		0: no alarm
 		1: alarm
@@ -389,6 +390,7 @@ OR
 in[0-*]_min_alarm
 in[0-*]_max_alarm
 fan[1-*]_min_alarm
+fan[1-*]_max_alarm
 temp[1-*]_min_alarm
 temp[1-*]_max_alarm
 temp[1-*]_crit_alarm

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
