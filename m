From: "Engelmayer Christian" <Christian.Engelmayer@frequentis.com>
Date: Mon, 25 May 2009 20:15:16 +0000
Subject: [lm-sensors] [PATCH v2 1/1] hwmon: Updated documentation on alarms
Message-Id: <9EE81EBECB70824985BE0EDA8DC9B515021B3458@VIECLEX01.frequentis.frq>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Christian Engelmayer <christian.engelmayer@frequentis.com>

Added fan limit alarm 'max_alarm' to the alarm section.

Signed-off-by: Christian Engelmayer <christian.engelmayer@frequentis.com>
---
No longer mentioning non standard gpio alarms after clarification by the
maintainer.

--- Documentation/hwmon/sysfs-interface.orig	2009-05-21 23:03:27.000000000
+0200
+++ Documentation/hwmon/sysfs-interface	2009-05-25 22:08:13.000000000 +0200
@@ -389,6 +389,7 @@ OR
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
