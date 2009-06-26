From: Andre Prendel <andre.prendel@gmx.de>
Date: Fri, 26 Jun 2009 08:11:56 +0000
Subject: [lm-sensors] [PATCH v2 2/2] hwmon: Add documentation for tmp421
Message-Id: <20090626081156.GC4510@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This patch adds documentation for the tmp421 driver.

changes in v2:

Replace degree symbol by "degree C" and fix other spelling mistakes.

Signed-off-by: Andre Prendel <andre.prendel@gmx.de>
---
 tmp421 |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

Index: linux-2.6/Documentation/hwmon/tmp421
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/Documentation/hwmon/tmp421	2009-06-25 23:18:52.000000000 +0200
@@ -0,0 +1,36 @@
+Kernel driver tmp421
+==========
+
+Supported chips:
+  * Texas Instruments TMP421
+    Prefix: 'tmp421'
+    Addresses scanned: I2C 0x2a, 0x4c, 0x4d, 0x4e and 0x4f
+    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp421.html
+  * Texas Instruments TMP422
+    Prefix: 'tmp422'
+    Addresses scanned: I2C 0x2a, 0x4c, 0x4d, 0x4e and 0x4f
+    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp421.html
+  * Texas Instruments TMP423
+    Prefix: 'tmp423'
+    Addresses scanned: I2C 0x2a, 0x4c, 0x4d, 0x4e and 0x4f
+    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp421.html
+
+Authors:
+	Andre Prendel <andre.prendel@gmx.de>
+
+Description
+-----------
+
+This driver implements support for Texas Instruments TMP421, TMP422
+and TMP423 temperature sensor chips. These chips implement one local
+and up to one (TMP421), up to two (TMP422) or up to three (TMP423)
+remote sensors. Temperature is measured in degrees Celsius. The chips
+are wired over I2C/SMBus and specified over a temperature range of -40
+to +125 degrees Celsius. Resolution for both the local and remote
+channels is 0.0625 degree C.
+
+The chips support only temperature measurement. The driver exports
+the temperature values via the following sysfs files.
+
+temp[1-4]_input
+temp[2-4]_fault

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
