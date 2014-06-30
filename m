From: "Zhu, Richard (NSN - CN/Beijing)" <richard.zhu@nsn.com>
Date: Mon, 30 Jun 2014 02:50:26 +0000
Subject: [lm-sensors] [PATCH]: hwmon: (pmbus) Add tps40422 front-end driver
Message-Id: <E9BC5E534B6C564CA4B01BC388FD1B5A344175BE@SGSIMBX007.nsn-intra.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

I made a separate front end driver for this, please help to review again, Thanks a lot!

BR
Richard

[PATCH]: hwmon: (pmbus) Add tps40422 front-end driver

For TI power management chip TPS40422, READ_TEMPERATURE_2 command is supported on
page 1 of the chip, but the original driver(pmbus.c) only tried to detect this command
on page 0, this will lead to a result that the temperature sensor in page 1 couldn't
be detected. This change is to isolate the tps40422 driver from pmbus.c into a solo
front-end driver.

Signed-off-by: Zhu Laiwen <richard.zhu@nsn.com>

diff -uprN a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
--- a/drivers/hwmon/pmbus/Kconfig	2014-06-27 10:07:38.728983000 +0200
+++ b/drivers/hwmon/pmbus/Kconfig	2014-06-27 10:09:39.687402000 +0200
@@ -20,8 +20,7 @@ config SENSORS_PMBUS
 	help
 	  If you say yes here you get hardware monitoring support for generic
 	  PMBus devices, including but not limited to ADP4000, BMR453, BMR454,
-	  MDT040, NCP4200, NCP4208, PDT003, PDT006, PDT012, UDT020, TPS40400,
-	  and TPS40422.
+	  MDT040, NCP4200, NCP4208, PDT003, PDT006, PDT012, UDT020, and TPS40400.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
@@ -121,4 +120,14 @@ config SENSORS_ZL6100
 	  This driver can also be built as a module. If so, the module will
 	  be called zl6100.
 
+config SENSORS_TPS40422
+	tristate "TI TPS40422"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for TI
+	  TPS40422.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called tps40422.
+
 endif # PMBUS
diff -uprN a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
--- a/drivers/hwmon/pmbus/Makefile	2014-06-27 10:07:38.716971000 +0200
+++ b/drivers/hwmon/pmbus/Makefile	2014-06-27 10:08:20.000119000 +0200
@@ -13,3 +13,4 @@ obj-$(CONFIG_SENSORS_MAX8688)	+= max8688
 obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
 obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
 obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
+obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
\ No newline at end of file
diff -uprN a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
--- a/drivers/hwmon/pmbus/pmbus.c	2014-06-27 10:07:38.748979000 +0200
+++ b/drivers/hwmon/pmbus/pmbus.c	2014-06-27 10:08:20.023123000 +0200
@@ -193,7 +193,6 @@ static const struct i2c_device_id pmbus_
 	{"pdt012", 1},
 	{"pmbus", 0},
 	{"tps40400", 1},
-	{"tps40422", 2},
 	{"udt020", 1},
 	{}
 };
diff -uprN a/drivers/hwmon/pmbus/tps40422.c b/drivers/hwmon/pmbus/tps40422.c
--- a/drivers/hwmon/pmbus/tps40422.c	1970-01-01 01:00:00.000000000 +0100
+++ b/drivers/hwmon/pmbus/tps40422.c	2014-06-30 03:37:03.356922000 +0200
@@ -0,0 +1,68 @@
+/*
+ * Hardware monitoring driver for TI TPS40422
+ *
+ * Copyright (c) 2014 Nokia Solutions and Networks.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
+#include "pmbus.h"
+
+static struct pmbus_driver_info tps40422_info = {
+	.pages = 2,
+	.format[PSC_VOLTAGE_IN] = linear,
+	.format[PSC_VOLTAGE_OUT] = linear,
+	.format[PSC_TEMPERATURE] = linear,
+	.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_TEMP2
+		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_TEMP
+		| PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+	.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_TEMP2
+		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_TEMP
+		| PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+};
+
+static int tps40422_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	return pmbus_do_probe(client, id, &tps40422_info);
+}
+
+static const struct i2c_device_id tps40422_id[] = {
+	{"tps40422", 2},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, tps40422_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver tps40422_driver = {
+	.driver = {
+		   .name = "tps40422",
+		   },
+	.probe = tps40422_probe,
+	.remove = pmbus_do_remove,
+	.id_table = tps40422_id,
+};
+
+module_i2c_driver(tps40422_driver);
+
+MODULE_AUTHOR("Zhu Laiwen");
+MODULE_DESCRIPTION("PMBus driver for TI TPS40422");
+MODULE_LICENSE("GPL");




-----Original Message-----
From: ext Guenter Roeck [mailto:linux@roeck-us.net] 
Sent: Tuesday, June 17, 2014 6:35 PM
To: Zhu, Richard (NSN - CN/Beijing); jdelvare@suse.de; lm-sensors@lm-sensors.org
Cc: Sverdlin, Alexander (NSN - DE/Ulm); Nicu, Ioan (EXT-Other - DE/Ulm)
Subject: Re: [PATCH]: hwmon: (pmbus) Detect temperature sensors on all pages

On 06/17/2014 12:16 AM, Zhu, Richard (NSN - CN/Beijing) wrote:
> Hi All,
>
> When I was trouble shooting the TI power manager chip TPS40422, I found that the kernel pmbus driver (pmbus.c) was not trying to detect the temperature sensors other than page 0 for pmbus devices, so the temp2_input file couldn't be seen in sysfs. So I made a patch file to trying to solve the problem. Please help to review my findings, and to see if the patch can go to the upstream.
>
>
> The following content is the content of the patch file:
> [PATCH]: hwmon: (pmbus) Detect temperature sensors on all pages
>
> For TI power management chip TPS40422, READ_TEMPERATURE_2 command is supported on
> page 1 of the chip, but the original driver only tried to detect this command on
> page 0, this will lead to a result that the temperature sensor in page 1 couldn't
> be detected. This change is finding the temperature sensors on all pages to solve
> the problem.
>
Problem is that many pmbus devices don't implement paged temperature sensors.
While this works for the TPS40422, it would result in duplicate detection for
many other chips with unpaged sensors. Which means we'll need a separate front-end
driver for this chip.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
