From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 28 May 2008 15:12:20 +0000
Subject: [lm-sensors] [PATCH 4/4] hwmon: (lm90) Update datasheet links
Message-Id: <20080528171220.7abadb82@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Update the links to the datasheet of some of the devices supported by
the lm90 driver. Also remove the links from the driver itself, so that
we don't have to update them twice each time they change.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 Documentation/hwmon/lm90 |   12 ++++++------
 drivers/hwmon/lm90.c     |   30 +++++++-----------------------
 2 files changed, 13 insertions(+), 29 deletions(-)

--- linux-2.6.26-rc4.orig/Documentation/hwmon/lm90	2008-05-27 21:53:06.0000=
00000 +0200
+++ linux-2.6.26-rc4/Documentation/hwmon/lm90	2008-05-28 12:15:56.000000000=
 +0200
@@ -11,7 +11,7 @@ Supported chips:
     Prefix: 'lm99'
     Addresses scanned: I2C 0x4c and 0x4d
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM89.html
+               http://www.national.com/mpf/LM/LM89.html
   * National Semiconductor LM99
     Prefix: 'lm99'
     Addresses scanned: I2C 0x4c and 0x4d
@@ -21,17 +21,17 @@ Supported chips:
     Prefix: 'lm86'
     Addresses scanned: I2C 0x4c
     Datasheet: Publicly available at the National Semiconductor website
-               http://www.national.com/pf/LM/LM86.html
+               http://www.national.com/mpf/LM/LM86.html
   * Analog Devices ADM1032
     Prefix: 'adm1032'
     Addresses scanned: I2C 0x4c and 0x4d
-    Datasheet: Publicly available at the Analog Devices website
-               http://www.analog.com/en/prod/0,2877,ADM1032,00.html
+    Datasheet: Publicly available at the ON Semiconductor website
+               http://www.onsemi.com/PowerSolutions/product.do?id=ADM1032
   * Analog Devices ADT7461
     Prefix: 'adt7461'
     Addresses scanned: I2C 0x4c and 0x4d
-    Datasheet: Publicly available at the Analog Devices website
-               http://www.analog.com/en/prod/0,2877,ADT7461,00.html
+    Datasheet: Publicly available at the ON Semiconductor website
+               http://www.onsemi.com/PowerSolutions/product.do?id=ADT7461
     Note: Only if in ADM1032 compatibility mode
   * Maxim MAX6657
     Prefix: 'max6657'
--- linux-2.6.26-rc4.orig/drivers/hwmon/lm90.c	2008-05-28 08:31:39.00000000=
0 +0200
+++ linux-2.6.26-rc4/drivers/hwmon/lm90.c	2008-05-28 09:13:14.000000000 +02=
00
@@ -6,9 +6,7 @@
  * Based on the lm83 driver. The LM90 is a sensor chip made by National
  * Semiconductor. It reports up to two temperatures (its own plus up to
  * one external one) with a 0.125 deg resolution (1 deg for local
- * temperature) and a 3-4 deg accuracy. Complete datasheet can be
- * obtained from National's website at:
- *   http://www.national.com/pf/LM/LM90.html
+ * temperature) and a 3-4 deg accuracy.
  *
  * This driver also supports the LM89 and LM99, two other sensor chips
  * made by National Semiconductor. Both have an increased remote
@@ -16,29 +14,19 @@
  * additionally shifts remote temperatures (measured and limits) by 16
  * degrees, which allows for higher temperatures measurement. The
  * driver doesn't handle it since it can be done easily in user-space.
- * Complete datasheets can be obtained from National's website at:
- *   http://www.national.com/pf/LM/LM89.html
- *   http://www.national.com/pf/LM/LM99.html
  * Note that there is no way to differentiate between both chips.
  *
  * This driver also supports the LM86, another sensor chip made by
  * National Semiconductor. It is exactly similar to the LM90 except it
  * has a higher accuracy.
- * Complete datasheet can be obtained from National's website at:
- *   http://www.national.com/pf/LM/LM86.html
  *
  * This driver also supports the ADM1032, a sensor chip made by Analog
  * Devices. That chip is similar to the LM90, with a few differences
- * that are not handled by this driver. Complete datasheet can be
- * obtained from Analog's website at:
- *   http://www.analog.com/en/prod/0,2877,ADM1032,00.html
- * Among others, it has a higher accuracy than the LM90, much like the
- * LM86 does.
+ * that are not handled by this driver. Among others, it has a higher
+ * accuracy than the LM90, much like the LM86 does.
  *
  * This driver also supports the MAX6657, MAX6658 and MAX6659 sensor
- * chips made by Maxim. These chips are similar to the LM86. Complete
- * datasheet can be obtained at Maxim's website at:
- *   http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2578
+ * chips made by Maxim. These chips are similar to the LM86.
  * Note that there is no easy way to differentiate between the three
  * variants. The extra address and features of the MAX6659 are not
  * supported by this driver. These chips lack the remote temperature
@@ -46,18 +34,14 @@
  *
  * This driver also supports the MAX6680 and MAX6681, two other sensor
  * chips made by Maxim. These are quite similar to the other Maxim
- * chips. Complete datasheet can be obtained at:
- *   http://www.maxim-ic.com/quick_view2.cfm/qv_pk/3370
- * The MAX6680 and MAX6681 only differ in the pinout so they can be
- * treated identically.
+ * chips. The MAX6680 and MAX6681 only differ in the pinout so they can
+ * be treated identically.
  *
  * This driver also supports the ADT7461 chip from Analog Devices but
  * only in its "compatability mode". If an ADT7461 chip is found but
  * is configured in non-compatible mode (where its temperature
  * register values are decoded differently) it is ignored by this
- * driver. Complete datasheet can be obtained from Analog's website
- * at:
- *   http://www.analog.com/en/prod/0,2877,ADT7461,00.html
+ * driver.
  *
  * Since the LM90 was the first chipset supported by this driver, most
  * comments will refer to this chipset, but are actually general and


--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
