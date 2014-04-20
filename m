From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 20 Apr 2014 12:40:06 +0000
Subject: [lm-sensors] [PATCH] hwmon: Document temp[1-*]_min_hyst sysfs attribute
Message-Id: <20140420144006.17c4f79e@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The temp[1-*]_min_hyst sysfs attribute is already implemented by 3
hwmon drivers (adt7x10, lm77 and lm92) but was missing from the
standard interface.

Also add temp[1-*]_lcrit_hyst for consistency, even though no driver
implement that one for the time being.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/sysfs-interface |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

--- linux-3.15-rc1.orig/Documentation/hwmon/sysfs-interface	2014-03-31 05:40:15.000000000 +0200
+++ linux-3.15-rc1/Documentation/hwmon/sysfs-interface	2014-04-20 14:32:45.854170603 +0200
@@ -327,6 +327,13 @@ temp[1-*]_max_hyst
 		from the max value.
 		RW
 
+temp[1-*]_min_hyst
+		Temperature hysteresis value for min limit.
+		Unit: millidegree Celsius
+		Must be reported as an absolute temperature, NOT a delta
+		from the min value.
+		RW
+
 temp[1-*]_input Temperature input value.
 		Unit: millidegree Celsius
 		RO
@@ -362,6 +369,13 @@ temp[1-*]_lcrit	Temperature critical min
 		Unit: millidegree Celsius
 		RW
 
+temp[1-*]_lcrit_hyst
+		Temperature hysteresis value for critical min limit.
+		Unit: millidegree Celsius
+		Must be reported as an absolute temperature, NOT a delta
+		from the critical min value.
+		RW
+
 temp[1-*]_offset
 		Temperature offset which is added to the temperature reading
 		by the chip.


-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
