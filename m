From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 03 Oct 2012 11:19:08 +0000
Subject: [lm-sensors] [PATCH] hwmon: Add missing inclusions of <linux/jiffies.h>
Message-Id: <20121003131908.3a36fe3a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Many hwmon drivers use jiffies but omit the inclusion of the header
file. Fix that, and also fix one driver which was including the header
file but didn't need it.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Luca Tettamanti <kronos.it@gmail.com>
Cc: Marc Hulsman <m.hulsman@tudelft.nl>
Cc: Rudolf Marek <r.marek@assembler.cz>
---
 drivers/hwmon/adm9240.c          |    1 +
 drivers/hwmon/adt7475.c          |    1 +
 drivers/hwmon/asus_atk0110.c     |    1 +
 drivers/hwmon/emc1403.c          |    1 +
 drivers/hwmon/hih6130.c          |    1 +
 drivers/hwmon/i5k_amb.c          |    1 -
 drivers/hwmon/ina2xx.c           |    1 +
 drivers/hwmon/lineage-pem.c      |    1 +
 drivers/hwmon/lm92.c             |    1 +
 drivers/hwmon/lm93.c             |    1 +
 drivers/hwmon/ltc4151.c          |    1 +
 drivers/hwmon/ltc4215.c          |    1 +
 drivers/hwmon/ltc4245.c          |    1 +
 drivers/hwmon/ltc4261.c          |    1 +
 drivers/hwmon/pmbus/pmbus_core.c |    1 +
 drivers/hwmon/sht21.c            |    1 +
 drivers/hwmon/smm665.c           |    1 +
 drivers/hwmon/thmc50.c           |    1 +
 drivers/hwmon/tmp102.c           |    1 +
 drivers/hwmon/w83791d.c          |    1 +
 drivers/hwmon/w83792d.c          |    1 +
 drivers/hwmon/w83793.c           |    1 +
 drivers/hwmon/w83795.c           |    1 +
 drivers/hwmon/w83l786ng.c        |    1 +
 24 files changed, 23 insertions(+), 1 deletion(-)

--- linux-3.7-rc0.orig/drivers/hwmon/adm9240.c	2012-10-03 09:06:43.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/adm9240.c	2012-10-03 12:53:03.000225607 +0200
@@ -50,6 +50,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/jiffies.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
--- linux-3.7-rc0.orig/drivers/hwmon/adt7475.c	2012-10-01 09:22:38.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/adt7475.c	2012-10-03 12:53:23.483232690 +0200
@@ -20,6 +20,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
+#include <linux/jiffies.h>
 
 /* Indexes for the sysfs hooks */
 
--- linux-3.7-rc0.orig/drivers/hwmon/asus_atk0110.c	2012-10-03 09:06:43.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/asus_atk0110.c	2012-10-03 12:52:42.731217538 +0200
@@ -14,6 +14,7 @@
 #include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/dmi.h>
+#include <linux/jiffies.h>
 
 #include <acpi/acpi.h>
 #include <acpi/acpixf.h>
--- linux-3.7-rc0.orig/drivers/hwmon/emc1403.c	2012-10-03 09:06:43.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/emc1403.c	2012-10-03 12:52:29.752212792 +0200
@@ -33,6 +33,7 @@
 #include <linux/err.h>
 #include <linux/sysfs.h>
 #include <linux/mutex.h>
+#include <linux/jiffies.h>
 
 #define THERMAL_PID_REG		0xfd
 #define THERMAL_SMSC_ID_REG	0xfe
--- linux-3.7-rc0.orig/drivers/hwmon/hih6130.c	2012-10-01 09:22:38.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/hih6130.c	2012-10-03 12:53:30.769235401 +0200
@@ -33,6 +33,7 @@
 #include <linux/mutex.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 
 /**
  * struct hih6130 - HIH-6130 device specific data
--- linux-3.7-rc0.orig/drivers/hwmon/i5k_amb.c	2012-10-03 12:43:23.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/i5k_amb.c	2012-10-03 12:50:31.279174135 +0200
@@ -21,7 +21,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/jiffies.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
--- linux-3.7-rc0.orig/drivers/hwmon/ina2xx.c	2012-10-03 09:06:43.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/ina2xx.c	2012-10-03 12:52:15.842207551 +0200
@@ -33,6 +33,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
 
 #include <linux/platform_data/ina2xx.h>
 
--- linux-3.7-rc0.orig/drivers/hwmon/lineage-pem.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/lineage-pem.c	2012-10-03 12:52:06.132204094 +0200
@@ -29,6 +29,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
 
 /*
  * This driver supports various Lineage Compact Power Line DC/DC and AC/DC
--- linux-3.7-rc0.orig/drivers/hwmon/lm92.c	2012-10-01 09:22:38.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/lm92.c	2012-10-03 12:52:33.372214334 +0200
@@ -48,6 +48,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/jiffies.h>
 
 /*
  * The LM92 and MAX6635 have 2 two-state pins for address selection,
--- linux-3.7-rc0.orig/drivers/hwmon/lm93.c	2012-10-03 09:06:43.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/lm93.c	2012-10-03 12:52:50.190220370 +0200
@@ -47,6 +47,7 @@
 #include <linux/hwmon-vid.h>
 #include <linux/err.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 
 /* LM93 REGISTER ADDRESSES */
 
--- linux-3.7-rc0.orig/drivers/hwmon/ltc4151.c	2012-10-03 09:06:43.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/ltc4151.c	2012-10-03 12:53:10.177228442 +0200
@@ -36,6 +36,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
 
 /* chip registers */
 #define LTC4151_SENSE_H	0x00
--- linux-3.7-rc0.orig/drivers/hwmon/ltc4215.c	2012-10-03 09:06:43.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/ltc4215.c	2012-10-03 12:52:22.351210091 +0200
@@ -19,6 +19,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
 
 /* Here are names of the chip's registers (a.k.a. commands) */
 enum ltc4215_cmd {
--- linux-3.7-rc0.orig/drivers/hwmon/ltc4245.c	2012-10-03 09:06:43.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/ltc4245.c	2012-10-03 12:53:16.311230277 +0200
@@ -21,6 +21,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
 #include <linux/i2c/ltc4245.h>
 
 /* Here are names of the chip's registers (a.k.a. commands) */
--- linux-3.7-rc0.orig/drivers/hwmon/ltc4261.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/ltc4261.c	2012-10-03 12:52:19.433208924 +0200
@@ -33,6 +33,7 @@
 #include <linux/i2c.h>
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
+#include <linux/jiffies.h>
 
 /* chip registers */
 #define LTC4261_STATUS	0x00	/* readonly */
--- linux-3.7-rc0.orig/drivers/hwmon/pmbus/pmbus_core.c	2012-10-03 12:43:23.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/pmbus/pmbus_core.c	2012-10-03 12:52:38.957216159 +0200
@@ -27,6 +27,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 #include <linux/i2c/pmbus.h>
 #include "pmbus.h"
 
--- linux-3.7-rc0.orig/drivers/hwmon/sht21.c	2012-10-03 09:06:43.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/sht21.c	2012-10-03 12:52:25.699211358 +0200
@@ -29,6 +29,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
+#include <linux/jiffies.h>
 
 /* I2C command bytes */
 #define SHT21_TRIG_T_MEASUREMENT_HM  0xe3
--- linux-3.7-rc0.orig/drivers/hwmon/smm665.c	2012-07-21 22:58:29.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/smm665.c	2012-10-03 12:53:20.807231643 +0200
@@ -24,6 +24,7 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 
 /* Internal reference voltage (VREF, x 1000 */
 #define SMM665_VREF_ADC_X1000	1250
--- linux-3.7-rc0.orig/drivers/hwmon/thmc50.c	2012-10-01 09:22:38.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/thmc50.c	2012-10-03 12:53:06.346226933 +0200
@@ -28,6 +28,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/jiffies.h>
 
 MODULE_LICENSE("GPL");
 
--- linux-3.7-rc0.orig/drivers/hwmon/tmp102.c	2012-10-01 09:22:38.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/tmp102.c	2012-10-03 12:52:12.827206269 +0200
@@ -26,6 +26,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/device.h>
+#include <linux/jiffies.h>
 
 #define	DRIVER_NAME "tmp102"
 
--- linux-3.7-rc0.orig/drivers/hwmon/w83791d.c	2012-10-03 09:06:43.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/w83791d.c	2012-10-03 12:52:56.729222870 +0200
@@ -41,6 +41,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/jiffies.h>
 
 #define NUMBER_OF_VIN		10
 #define NUMBER_OF_FANIN		5
--- linux-3.7-rc0.orig/drivers/hwmon/w83792d.c	2012-10-03 09:06:43.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/w83792d.c	2012-10-03 12:52:46.803219037 +0200
@@ -44,6 +44,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
+#include <linux/jiffies.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2c, 0x2d, 0x2e, 0x2f,
--- linux-3.7-rc0.orig/drivers/hwmon/w83793.c	2012-10-03 09:06:43.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/w83793.c	2012-10-03 12:53:26.460233920 +0200
@@ -46,6 +46,7 @@
 #include <linux/kref.h>
 #include <linux/notifier.h>
 #include <linux/reboot.h>
+#include <linux/jiffies.h>
 
 /* Default values */
 #define WATCHDOG_TIMEOUT 2	/* 2 minute default timeout */
--- linux-3.7-rc0.orig/drivers/hwmon/w83795.c	2012-10-03 12:43:23.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/w83795.c	2012-10-03 12:52:53.557221677 +0200
@@ -35,6 +35,7 @@
 #include <linux/err.h>
 #include <linux/mutex.h>
 #include <linux/delay.h>
+#include <linux/jiffies.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = {
--- linux-3.7-rc0.orig/drivers/hwmon/w83l786ng.c	2012-10-03 09:06:43.000000000 +0200
+++ linux-3.7-rc0/drivers/hwmon/w83l786ng.c	2012-10-03 12:52:59.706224248 +0200
@@ -33,6 +33,7 @@
 #include <linux/hwmon-sysfs.h>
 #include <linux/err.h>
 #include <linux/mutex.h>
+#include <linux/jiffies.h>
 
 /* Addresses to scan */
 static const unsigned short normal_i2c[] = { 0x2e, 0x2f, I2C_CLIENT_END };


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
