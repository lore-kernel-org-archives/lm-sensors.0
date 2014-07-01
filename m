From: "Zhu, Richard (NSN - CN/Beijing)" <richard.zhu@nsn.com>
Date: Tue, 01 Jul 2014 07:14:23 +0000
Subject: Re: [lm-sensors] [PATCH]: hwmon: (pmbus) Add tps40422 front-end driver
Message-Id: <E9BC5E534B6C564CA4B01BC388FD1B5A34417A93@SGSIMBX007.nsn-intra.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <E9BC5E534B6C564CA4B01BC388FD1B5A344175BE@SGSIMBX007.nsn-intra.net>
In-Reply-To: <E9BC5E534B6C564CA4B01BC388FD1B5A344175BE@SGSIMBX007.nsn-intra.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

I update the document according to your findings, Thanks a lot for your time!

BR
Richard


[PATCH]: hwmon: (pmbus) Add tps40422 front-end driver

For TI power management chip TPS40422, READ_TEMPERATURE_2 command is supported on
page 1 of the chip, but the original driver(pmbus.c) only tried to detect this command
on page 0, this will lead to a result that the temperature sensor in page 1 couldn't
be detected. This change is to isolate the tps40422 driver from pmbus.c into a solo
front-end driver.

Signed-off-by: Zhu Laiwen <richard.zhu@nsn.com>

diff -uprN a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
--- a/Documentation/hwmon/pmbus	2014-06-30 09:24:38.302863000 +0200
+++ b/Documentation/hwmon/pmbus	2014-06-30 09:26:44.128313000 +0200
@@ -23,12 +23,11 @@ Supported chips:
 	http://www.lineagepower.com/oem/pdf/PDT012A0X.pdf
 	http://www.lineagepower.com/oem/pdf/UDT020A0X.pdf
 	http://www.lineagepower.com/oem/pdf/MDT040A0X.pdf
-  * Texas Instruments TPS40400, TPS40422
-    Prefixes: 'tps40400', 'tps40422'
+  * Texas Instruments TPS40400
+    Prefixes: 'tps40400'
     Addresses scanned: -
     Datasheets:
 	http://www.ti.com/lit/gpn/tps40400
-	http://www.ti.com/lit/gpn/tps40422
   * Generic PMBus devices
     Prefix: 'pmbus'
     Addresses scanned: -
diff -uprN a/Documentation/hwmon/tps40422 b/Documentation/hwmon/tps40422
--- a/Documentation/hwmon/tps40422	1970-01-01 01:00:00.000000000 +0100
+++ b/Documentation/hwmon/tps40422	2014-07-01 09:04:45.525343000 +0200
@@ -0,0 +1,64 @@
+Kernel driver tps40422
+===========
+
+Supported chips:
+  * TI TPS40422
+    Prefix: 'tps40422'
+    Addresses scanned: -
+    Datasheet: http://www.ti.com/lit/gpn/tps40422
+
+Author: Zhu Laiwen <richard.zhu@nsn.com>
+
+
+Description
+-----------
+
+This driver supports TI TPS40422 Dual-Output or Two-Phase Synchronous Buck
+Controller with PMBus
+
+The driver is a client driver to the core PMBus driver.
+Please see Documentation/hwmon/pmbus for details on PMBus client drivers.
+
+
+Usage Notes
+-----------
+
+This driver does not auto-detect devices. You will have to instantiate the
+devices explicitly. Please see Documentation/i2c/instantiating-devices for
+details.
+
+
+Platform data support
+---------------------
+
+The driver supports standard PMBus driver platform data.
+
+
+Sysfs entries
+-------------
+
+The following attributes are supported.
+
+in[1-2]_label		"vout[1-2]"
+in[1-2]_input		Measured voltage. From READ_VOUT register.
+in[1-2]_alarm		voltage alarm.
+
+curr[1-2]_input		Measured current. From READ_IOUT register.
+curr[1-2]_label		"iout[1-2]"
+curr1_max		Maximum current. From IOUT_OC_WARN_LIMIT register.
+curr1_crit		Critical maximum current. From IOUT_OC_FAULT_LIMIT register.
+curr1_max_alarm		Current high alarm. From IOUT_OC_WARN_LIMIT status.
+curr1_crit_alarm	Current critical high alarm. From IOUT_OC_FAULT status.
+curr2_alarm		Current high alarm. From IOUT_OC_WARNING status.
+
+temp1_input		Measured temperature. From READ_TEMPERATURE_2 register on page 0.
+temp1_max		Maximum temperature. From OT_WARN_LIMIT register.
+temp1_crit		Critical high temperature. From OT_FAULT_LIMIT register.
+temp1_max_alarm		Chip temperature high alarm. Set by comparing
+			READ_TEMPERATURE_2 on page 0 with OT_WARN_LIMIT if TEMP_OT_WARNING
+			status is set.
+temp1_crit_alarm	Chip temperature critical high alarm. Set by comparing
+			READ_TEMPERATURE_2 on page 0 with OT_FAULT_LIMIT if TEMP_OT_FAULT
+			status is set.
+temp2_input		Measured temperature. From READ_TEMPERATURE_2 register on page 1.
+temp2_alarm		Chip temperature alarm on page 1.
diff -uprN a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
--- a/drivers/hwmon/pmbus/Kconfig	2014-06-27 10:07:38.728983000 +0200
+++ b/drivers/hwmon/pmbus/Kconfig	2014-06-30 07:58:32.017883000 +0200
@@ -20,8 +20,7 @@ config SENSORS_PMBUS
 	help
 	  If you say yes here you get hardware monitoring support for generic
 	  PMBus devices, including but not limited to ADP4000, BMR453, BMR454,
-	  MDT040, NCP4200, NCP4208, PDT003, PDT006, PDT012, UDT020, TPS40400,
-	  and TPS40422.
+	  MDT040, NCP4200, NCP4208, PDT003, PDT006, PDT012, UDT020, and TPS40400.
 
 	  This driver can also be built as a module. If so, the module will
 	  be called pmbus.
@@ -87,6 +86,16 @@ config SENSORS_MAX8688
 	  This driver can also be built as a module. If so, the module will
 	  be called max8688.
 
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
 config SENSORS_UCD9000
 	tristate "TI UCD90120, UCD90124, UCD9090, UCD90910"
 	default n
diff -uprN a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
--- a/drivers/hwmon/pmbus/Makefile	2014-06-27 10:07:38.716971000 +0200
+++ b/drivers/hwmon/pmbus/Makefile	2014-06-30 07:29:31.045045000 +0200
@@ -10,6 +10,7 @@ obj-$(CONFIG_SENSORS_LTC2978)	+= ltc2978
 obj-$(CONFIG_SENSORS_MAX16064)	+= max16064.o
 obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
 obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
+obj-$(CONFIG_SENSORS_TPS40422)	+= tps40422.o
 obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
 obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
 obj-$(CONFIG_SENSORS_ZL6100)	+= zl6100.o
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
+++ b/drivers/hwmon/pmbus/tps40422.c	2014-07-01 04:35:28.639334000 +0200
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
+ * Foundation, Inc.
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
+	{"tps40422", 0},
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
+MODULE_AUTHOR("Zhu Laiwen <richard.zhu@nsn.com>");
+MODULE_DESCRIPTION("PMBus driver for TI TPS40422");
+MODULE_LICENSE("GPL");


-----Original Message-----
From: ext Guenter Roeck [mailto:linux@roeck-us.net] 
Sent: Tuesday, July 01, 2014 1:01 PM
To: Zhu, Richard (NSN - CN/Beijing); jdelvare@suse.de; lm-sensors@lm-sensors.org
Cc: Sverdlin, Alexander (NSN - DE/Ulm); Nicu, Ioan (EXT-Other - DE/Ulm)
Subject: Re: [PATCH]: hwmon: (pmbus) Add tps40422 front-end driver

On 06/30/2014 07:47 PM, Zhu, Richard (NSN - CN/Beijing) wrote:
> Hi Guenter,
>
> The update version, including the document change. Thanks!
> (I removed the postal address in tps40422.c file)
>
> BR
> Richard
>
> [PATCH]: hwmon: (pmbus) Add tps40422 front-end driver
>
> For TI power management chip TPS40422, READ_TEMPERATURE_2 command is supported on
> page 1 of the chip, but the original driver(pmbus.c) only tried to detect this command
> on page 0, this will lead to a result that the temperature sensor in page 1 couldn't
> be detected. This change is to isolate the tps40422 driver from pmbus.c into a solo
> front-end driver.
>
> Signed-off-by: Zhu Laiwen <richard.zhu@nsn.com>
>
> diff -uprN a/Documentation/hwmon/pmbus b/Documentation/hwmon/pmbus
> --- a/Documentation/hwmon/pmbus	2014-06-30 09:24:38.302863000 +0200
> +++ b/Documentation/hwmon/pmbus	2014-06-30 09:26:44.128313000 +0200
> @@ -23,12 +23,11 @@ Supported chips:
>   	http://www.lineagepower.com/oem/pdf/PDT012A0X.pdf
>   	http://www.lineagepower.com/oem/pdf/UDT020A0X.pdf
>   	http://www.lineagepower.com/oem/pdf/MDT040A0X.pdf
> -  * Texas Instruments TPS40400, TPS40422
> -    Prefixes: 'tps40400', 'tps40422'
> +  * Texas Instruments TPS40400
> +    Prefixes: 'tps40400'
>       Addresses scanned: -
>       Datasheets:
>   	http://www.ti.com/lit/gpn/tps40400
> -	http://www.ti.com/lit/gpn/tps40422
>     * Generic PMBus devices
>       Prefix: 'pmbus'
>       Addresses scanned: -
> diff -uprN a/Documentation/hwmon/tps40422 b/Documentation/hwmon/tps40422
> --- a/Documentation/hwmon/tps40422	1970-01-01 01:00:00.000000000 +0100
> +++ b/Documentation/hwmon/tps40422	2014-07-01 04:32:32.729680000 +0200
> @@ -0,0 +1,69 @@
> +Kernel driver tps40422
> +===========
> +
> +Supported chips:
> +  * TI TPS40422
> +    Prefix: 'tps40422'
> +    Addresses scanned: -
> +    Datasheet: http://www.ti.com/lit/gpn/tps40422
> +
> +Author: Zhu Laiwen <richard.zhu@nsn.com>
> +
> +
> +Description
> +-----------
> +
> +This driver supports TI TPS40422 Dual-Output or Two-Phase Synchronous Buck
> +Controller with PMBus
> +
> +The driver is a client driver to the core PMBus driver.
> +Please see Documentation/hwmon/pmbus for details on PMBus client drivers.
> +
> +
> +Usage Notes
> +-----------
> +
> +This driver does not auto-detect devices. You will have to instantiate the
> +devices explicitly. Please see Documentation/i2c/instantiating-devices for
> +details.
> +
> +
> +Platform data support
> +---------------------
> +
> +The driver supports standard PMBus driver platform data.
> +
> +
> +Sysfs entries
> +-------------
> +
> +The following attributes are supported.
> +
> +in[1-2]_label		"vout[1-2]"
> +in[1-2]_input		Measured voltage. From READ_VOUT register.
> +in[1-2]_alarm		voltage alarm.
> +
> +curr[1-2]_input		Measured current. From READ_IIN or READ_IOUT register.
> +curr[1-2]_label		"iin" or "ioutY"

Really ? I don't see IIN supported.

> +curr1_max		Maximum current.
> +			From IIN_OC_WARN_LIMIT or IOUT_OC_WARN_LIMIT register.
> +curr1_crit		Critical maximum current.
> +			From IIN_OC_FAULT_LIMIT or IOUT_OC_FAULT_LIMIT register.
> +curr1_max_alarm		Current high alarm.
> +			From IIN_OC_WARN_LIMIT or IOUT_OC_WARN_LIMIT status.
> +curr1_crit_alarm	Current critical high alarm.
> +			From IIN_OC_FAULT or IOUT_OC_FAULT status.
> +curr2_alarm		Current high alarm.
> +			From IIN_OC_WARNING or IOUT_OC_WARNING status.
> +
> +temp1_input		Measured temperature. From READ_TEMPERATURE_1 register.
> +temp1_max		Maximum temperature. From OT_WARN_LIMIT register.
> +temp1_crit		Critical high temperature. From OT_FAULT_LIMIT register.
> +temp1_max_alarm		Chip temperature high alarm. Set by comparing
> +			READ_TEMPERATURE_1 with OT_WARN_LIMIT if TEMP_OT_WARNING
> +			status is set.
> +temp1_crit_alarm	Chip temperature critical high alarm. Set by comparing
> +			READ_TEMPERATURE_1 with OT_FAULT_LIMIT if TEMP_OT_FAULT
> +			status is set.

Unless I am missing something, READ_TEMPERATURE_1 is not supported.
Temperatures should be reported from page 1 and 2, and presumably
temperature status registers should be the same for both pages
(and thus sensors).

Please verify attribute associations and presence. Or, as an alternative,
drop the list of supported attributes entirely (that is not perfect,
but better than wrong data).

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
