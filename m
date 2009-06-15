From: Andre Prendel <andre.prendel@gmx.de>
Date: Mon, 15 Jun 2009 07:43:39 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: Add documentation for tmp421 driver
Message-Id: <20090615074339.GC4667@ubuntu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

This patch adds documentation for driver tmp421.

Signed-off-by: Andre Prendel <andre.prendel@gmx.de>
---
 tmp421 |   36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

Index: linux-2.6/Documentation/hwmon/tmp421
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6/Documentation/hwmon/tmp421	2009-06-11 21:50:46.000000000 +0200
@@ -0,0 +1,36 @@
+Kernel driver tmp421
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
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
+and TMP423 temperature sensor chips. These chips implements one local
+and up to one (TMP421), up to two (TMP422) or up to three (TMP423)
+remote sensors. Temperature is measured in degrees Celsius. The chips
+are wired over I2C/SMBus and specified over a temperature range of
+-40=B0C to +125=B0C. Resolution for both the local and remote channels is
+0.0625=B0C.
+
+The chips supports only temperature measurement and exports these
+values via following sysfs-interface:
+
+temp[1-4]_input
+temp[2-4]_fault

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
