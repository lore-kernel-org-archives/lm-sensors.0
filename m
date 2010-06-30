From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 30 Jun 2010 15:30:05 +0000
Subject: [lm-sensors] [PATCH] hwmon: Remove in[0-*]_fault from
Message-Id: <20100630173005.11c90c64@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fault files are for hardware failures that can be reported. So far
we've seen chips reporting such failures for temperature sensors and
fans, but not for voltages. Remove in[0-*]_fault for now. It can be
added back later if really needed, but I doubt it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/sysfs-interface |    1 -
 1 file changed, 1 deletion(-)

--- linux-2.6.35-rc3.orig/Documentation/hwmon/sysfs-interface	2010-06-30 09:10:06.000000000 +0200
+++ linux-2.6.35-rc3/Documentation/hwmon/sysfs-interface	2010-06-30 17:24:09.000000000 +0200
@@ -516,7 +516,6 @@ to notify open diodes, unconnected fans
 supports it. When this boolean has value 1, the measurement for that
 channel should not be trusted.
 
-in[0-*]_fault
 fan[1-*]_fault
 temp[1-*]_fault
 		Input fault condition


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
