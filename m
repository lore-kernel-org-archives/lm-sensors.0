From: Andre Prendel <andre.prendel@gmx.de>
Date: Tue, 19 May 2009 08:08:27 +0000
Subject: [lm-sensors] [PATCH v2 3/3] tmp401: Add documentation
Message-Id: <20090519080827.GD5200@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Documentation for the tmp401 driver.

The documentation describes the tmp401 driver and the supported Texas
Instruments TMP401 and TMP411 temperature sensor chips.

Further documentation for new sysfs attributes supported by this
driver is added to /Documentation/hwmon/sysfs-interface.

Signed-off-by: Andre Prendel <andre.prendel@gmx.de>
---
 Documentation/hwmon/sysfs-interface |   19 ++++++++++++++++
 Documentation/hwmon/tmp401          |   42 ++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+)

Index: linux-2.6/Documentation/hwmon/tmp401
=================================--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/Documentation/hwmon/tmp401	2009-05-18 22:51:33.000000000 +0200
@@ -0,0 +1,42 @@
+Kernel driver tmp401
+==========
+
+Supported chips:
+  * Texas Instruments TMP401
+    Prefix: 'tmp401'
+    Addresses scanned: I2C 0x4c
+    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp401.html
+  * Texas Instruments TMP411
+    Prefix: 'tmp411'
+    Addresses scanned: I2C 0x4c
+    Datasheet: http://focus.ti.com/docs/prod/folders/print/tmp411.html
+
+Authors:
+         Hans de Goede <hdegoede@redhat.com>
+	 Andre Prendel <andre.prendel@gmx.de>
+
+Description
+-----------
+
+This driver implements support for Texas Instruments TMP401 and
+TMP411 chips. These chips implements one remote and one local
+temperature sensor. Temperature is measured in degrees
+Celsius. Resolution of the remote sensor is 0.0625 degree. Local
+sensor resolution can be set to 0.5, 0.25, 0.125 or 0.0625 degree (not
+supported by the driver so far, so using the default resolution of 0.5
+degree).
+
+The driver provides the common sysfs-interface for temperatures (see
+/Documentation/hwmon/sysfs-interface under Temperatures).
+
+The TMP411 chip is compatible with TMP401. It provides some additional
+features.
+
+* Minimum and Maximum temperature measured since power-on, chip-reset
+
+  Exported via sysfs attributes tempX_lowest and tempX_highest.
+
+* Reset of historical minimum/maximum temperature measurements
+
+  Exported via sysfs attribute temp_reset_history. Writing 1 to this
+  file triggers a reset.
Index: linux-2.6/Documentation/hwmon/sysfs-interface
=================================--- linux-2.6.orig/Documentation/hwmon/sysfs-interface	2009-05-18 21:19:06.000000000 +0200
+++ linux-2.6/Documentation/hwmon/sysfs-interface	2009-05-18 22:23:14.000000000 +0200
@@ -70,6 +70,7 @@
 [0-*]	denotes any positive number starting from 0
 [1-*]	denotes any positive number starting from 1
 RO	read only value
+WO	write only value
 RW	read/write value
 
 Read/write values may be read-only for some chips, depending on the
@@ -290,6 +291,24 @@
 		user-space.
 		RO
 
+temp[1-*]_lowest
+		Historical minimum temperature
+		Unit: millidegree Celsius
+		RO
+
+temp[1-*]_highest
+		Historical maximum temperature
+		Unit: millidegree Celsius
+		RO
+
+temp[1-*]_reset_history
+		Reset temp_lowest and temp_highest
+		WO
+
+temp_reset_history
+		Reset temp_lowest and temp_highest for all sensors
+		WO
+
 Some chips measure temperature using external thermistors and an ADC, and
 report the temperature measurement as a voltage. Converting this voltage
 back to a temperature (or the other way around for limits) requires

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
