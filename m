From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 May 2014 19:01:43 +0000
Subject: [lm-sensors] [PATCH 1/9] hwmon: (emc1403) Add driver documentation
Message-Id: <1399921311-9524-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

With the driver now supporting several chip variants,
it is about time to document what is supported.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 Documentation/hwmon/emc1403 | 56 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/hwmon/emc1403

diff --git a/Documentation/hwmon/emc1403 b/Documentation/hwmon/emc1403
new file mode 100644
index 0000000..b109e35
--- /dev/null
+++ b/Documentation/hwmon/emc1403
@@ -0,0 +1,56 @@
+Kernel driver emc1403
+==========+
+Supported chips:
+  * SMSC / Microchip EMC1402, EMC1412
+    Addresses scanned: I2C 0x18, 0x1c, 0x29, 0x4c, 0x4d, 0x5c
+    Prefix: 'emc1402'
+    Datasheets:
+	http://ww1.microchip.com/downloads/en/DeviceDoc/1412.pdf
+	http://ww1.microchip.com/downloads/en/DeviceDoc/1402.pdf
+  * SMSC / Microchip EMC1403, EMC1404, EMC1413, EMC1414
+    Addresses scanned: I2C 0x18, 0x29, 0x4c, 0x4d
+    Prefix: 'emc1403', 'emc1404'
+    Datasheets:
+	http://ww1.microchip.com/downloads/en/DeviceDoc/1403_1404.pdf
+	http://ww1.microchip.com/downloads/en/DeviceDoc/1413_1414.pdf
+  * SMSC / Microchip EMC1422
+    Addresses scanned: I2C 0x4c
+    Prefix: 'emc1422'
+    Datasheet:
+	http://ww1.microchip.com/downloads/en/DeviceDoc/1422.pdf
+  * SMSC / Microchip EMC1423, EMC1424
+    Addresses scanned: I2C 0x4c
+    Prefix: 'emc1423', 'emc1424'
+    Datasheet:
+	http://ww1.microchip.com/downloads/en/DeviceDoc/1423_1424.pdf
+
+Author:
+    Kalhan Trisal <kalhan.trisal@intel.com
+
+
+Description
+-----------
+
+The Standard Microsystems Corporation (SMSC) / Microchip EMC14xx chips
+contain up to four temperature sensors. EMC14x2 support two sensors
+(one internal, one external). EMC14x3 support three sensors (one internal,
+two external), and EMC14x4 support four sensors (one internal, three
+external).
+
+The chips implement three limits for each sensor: low (tempX_min), high
+(tempX_max) and critical (tempX_crit.) The chips also implement an
+hysteresis mechanism which applies to all limits. The relative difference
+is stored in a single register on the chip, which means that the relative
+difference between the limit and its hysteresis is always the same for
+all three limits.
+
+This implementation detail implies the following:
+* When setting a limit, its hysteresis will automatically follow, the
+  difference staying unchanged. For example, if the old critical limit
+  was 80 degrees C, and the hysteresis was 75 degrees C, and you change
+  the critical limit to 90 degrees C, then the hysteresis will
+  automatically change to 85 degrees C.
+* While hysteresis limits can be set for all critical limits, setting a single
+  hysteresis value affects the hysteresis values for all limits on all sensors.
+* The limits should be set before the hysteresis.
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
