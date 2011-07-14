From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Jul 2011 01:54:30 +0000
Subject: [lm-sensors] [PATCH 01/15] hwmon: (pmbus) Move PMBus drivers to
Message-Id: <1310608484-20678-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310485300-2168-2-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1310485300-2168-2-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Since the number of PMBus drivers is getting large, move them into
directory drivers/hwmon/pmbus to improve readability and scalability.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 MAINTAINERS                      |   11 +
 drivers/hwmon/Kconfig            |   87 +---
 drivers/hwmon/Makefile           |   10 +-
 drivers/hwmon/adm1275.c          |  131 ----
 drivers/hwmon/max16064.c         |   91 ---
 drivers/hwmon/max34440.c         |  199 -----
 drivers/hwmon/max8688.c          |  158 ----
 drivers/hwmon/pmbus.c            |  210 -----
 drivers/hwmon/pmbus.h            |  311 --------
 drivers/hwmon/pmbus/Kconfig      |   91 +++
 drivers/hwmon/pmbus/Makefile     |   12 +
 drivers/hwmon/pmbus/adm1275.c    |  131 ++++
 drivers/hwmon/pmbus/max16064.c   |   91 +++
 drivers/hwmon/pmbus/max34440.c   |  199 +++++
 drivers/hwmon/pmbus/max8688.c    |  158 ++++
 drivers/hwmon/pmbus/pmbus.c      |  210 +++++
 drivers/hwmon/pmbus/pmbus.h      |  311 ++++++++
 drivers/hwmon/pmbus/pmbus_core.c | 1567 ++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/pmbus/ucd9000.c    |  278 +++++++
 drivers/hwmon/pmbus/ucd9200.c    |  210 +++++
 drivers/hwmon/pmbus_core.c       | 1567 --------------------------------------
 drivers/hwmon/ucd9000.c          |  278 -------
 drivers/hwmon/ucd9200.c          |  210 -----
 23 files changed, 3271 insertions(+), 3250 deletions(-)
 delete mode 100644 drivers/hwmon/adm1275.c
 delete mode 100644 drivers/hwmon/max16064.c
 delete mode 100644 drivers/hwmon/max34440.c
 delete mode 100644 drivers/hwmon/max8688.c
 delete mode 100644 drivers/hwmon/pmbus.c
 delete mode 100644 drivers/hwmon/pmbus.h
 create mode 100644 drivers/hwmon/pmbus/Kconfig
 create mode 100644 drivers/hwmon/pmbus/Makefile
 create mode 100644 drivers/hwmon/pmbus/adm1275.c
 create mode 100644 drivers/hwmon/pmbus/max16064.c
 create mode 100644 drivers/hwmon/pmbus/max34440.c
 create mode 100644 drivers/hwmon/pmbus/max8688.c
 create mode 100644 drivers/hwmon/pmbus/pmbus.c
 create mode 100644 drivers/hwmon/pmbus/pmbus.h
 create mode 100644 drivers/hwmon/pmbus/pmbus_core.c
 create mode 100644 drivers/hwmon/pmbus/ucd9000.c
 create mode 100644 drivers/hwmon/pmbus/ucd9200.c
 delete mode 100644 drivers/hwmon/pmbus_core.c
 delete mode 100644 drivers/hwmon/ucd9000.c
 delete mode 100644 drivers/hwmon/ucd9200.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 187282d..a526783 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4961,6 +4961,17 @@ F:	drivers/i2c/busses/i2c-puv3.c
 F:	drivers/video/fb-puv3.c
 F:	drivers/rtc/rtc-puv3.c
 
+PMBUS HARDWARE MONITORING DRIVERS
+M:	Guenter Roeck <guenter.roeck@ericsson.com>
+L:	lm-sensors@lm-sensors.org
+W:	http://www.lm-sensors.org/
+W:	http://www.roeck-us.net/linux/drivers/
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git
+S:	Maintained
+F:	Documentation/hwmon/pmbus
+F:	drivers/hwmon/pmbus/
+F:	include/linux/i2c/pmbus.h
+
 PMC SIERRA MaxRAID DRIVER
 M:	Anil Ravindranath <anil_ravindranath@pmc-sierra.com>
 L:	linux-scsi@vger.kernel.org
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 5f888f7..5f58afe 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -807,92 +807,7 @@ config SENSORS_PCF8591
 	  These devices are hard to detect and rarely found on mainstream
 	  hardware.  If unsure, say N.
 
-config PMBUS
-	tristate "PMBus support"
-	depends on I2C && EXPERIMENTAL
-	default n
-	help
-	  Say yes here if you want to enable PMBus support.
-
-	  This driver can also be built as a module. If so, the module will
-	  be called pmbus_core.
-
-if PMBUS
-
-config SENSORS_PMBUS
-	tristate "Generic PMBus devices"
-	default n
-	help
-	  If you say yes here you get hardware monitoring support for generic
-	  PMBus devices, including but not limited to BMR450, BMR451, BMR453,
-	  BMR454, and LTC2978.
-
-	  This driver can also be built as a module. If so, the module will
-	  be called pmbus.
-
-config SENSORS_ADM1275
-	tristate "Analog Devices ADM1275"
-	default n
-	help
-	  If you say yes here you get hardware monitoring support for Analog
-	  Devices ADM1275 Hot-Swap Controller and Digital Power Monitor.
-
-	  This driver can also be built as a module. If so, the module will
-	  be called adm1275.
-
-config SENSORS_MAX16064
-	tristate "Maxim MAX16064"
-	default n
-	help
-	  If you say yes here you get hardware monitoring support for Maxim
-	  MAX16064.
-
-	  This driver can also be built as a module. If so, the module will
-	  be called max16064.
-
-config SENSORS_MAX34440
-	tristate "Maxim MAX34440/MAX34441"
-	default n
-	help
-	  If you say yes here you get hardware monitoring support for Maxim
-	  MAX34440 and MAX34441.
-
-	  This driver can also be built as a module. If so, the module will
-	  be called max34440.
-
-config SENSORS_MAX8688
-	tristate "Maxim MAX8688"
-	default n
-	help
-	  If you say yes here you get hardware monitoring support for Maxim
-	  MAX8688.
-
-	  This driver can also be built as a module. If so, the module will
-	  be called max8688.
-
-config SENSORS_UCD9000
-	tristate "TI UCD90120, UCD90124, UCD9090, UCD90910"
-	default n
-	help
-	  If you say yes here you get hardware monitoring support for TI
-	  UCD90120, UCD90124, UCD9090, UCD90910 Sequencer and System Health
-	  Controllers.
-
-	  This driver can also be built as a module. If so, the module will
-	  be called ucd9000.
-
-config SENSORS_UCD9200
-	tristate "TI UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, UCD9248"
-	default n
-	help
-	  If you say yes here you get hardware monitoring support for TI
-	  UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, and UCD9248
-	  Digital PWM System Controllers.
-
-	  This driver can also be built as a module. If so, the module will
-	  be called ucd9200.
-
-endif # PMBUS
+source drivers/hwmon/pmbus/Kconfig
 
 config SENSORS_SHT15
 	tristate "Sensiron humidity and temperature sensors. SHT15 and compat."
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 28061cf..33a55d6 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -119,15 +119,7 @@ obj-$(CONFIG_SENSORS_W83L786NG)	+= w83l786ng.o
 obj-$(CONFIG_SENSORS_WM831X)	+= wm831x-hwmon.o
 obj-$(CONFIG_SENSORS_WM8350)	+= wm8350-hwmon.o
 
-# PMBus drivers
-obj-$(CONFIG_PMBUS)		+= pmbus_core.o
-obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
-obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
-obj-$(CONFIG_SENSORS_MAX16064)	+= max16064.o
-obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
-obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
-obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
-obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
+obj-$(CONFIG_PMBUS)		+= pmbus/
 
 ccflags-$(CONFIG_HWMON_DEBUG_CHIP) := -DDEBUG
 
diff --git a/drivers/hwmon/adm1275.c b/drivers/hwmon/adm1275.c
deleted file mode 100644
index b9b7caf..0000000
--- a/drivers/hwmon/adm1275.c
+++ /dev/null
@@ -1,131 +0,0 @@
-/*
- * Hardware monitoring driver for Analog Devices ADM1275 Hot-Swap Controller
- * and Digital Power Monitor
- *
- * Copyright (c) 2011 Ericsson AB.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-#include "pmbus.h"
-
-#define ADM1275_PMON_CONFIG		0xd4
-
-#define ADM1275_VIN_VOUT_SELECT		(1 << 6)
-#define ADM1275_VRANGE			(1 << 5)
-
-static int adm1275_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
-{
-	int config;
-	int ret;
-	struct pmbus_driver_info *info;
-
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
-		return -ENODEV;
-
-	info = kzalloc(sizeof(struct pmbus_driver_info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
-	if (config < 0) {
-		ret = config;
-		goto err_mem;
-	}
-
-	info->pages = 1;
-	info->direct[PSC_VOLTAGE_IN] = true;
-	info->direct[PSC_VOLTAGE_OUT] = true;
-	info->direct[PSC_CURRENT_OUT] = true;
-	info->m[PSC_CURRENT_OUT] = 800;
-	info->b[PSC_CURRENT_OUT] = 20475;
-	info->R[PSC_CURRENT_OUT] = -1;
-	info->func[0] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
-
-	if (config & ADM1275_VRANGE) {
-		info->m[PSC_VOLTAGE_IN] = 19045;
-		info->b[PSC_VOLTAGE_IN] = 0;
-		info->R[PSC_VOLTAGE_IN] = -2;
-		info->m[PSC_VOLTAGE_OUT] = 19045;
-		info->b[PSC_VOLTAGE_OUT] = 0;
-		info->R[PSC_VOLTAGE_OUT] = -2;
-	} else {
-		info->m[PSC_VOLTAGE_IN] = 6666;
-		info->b[PSC_VOLTAGE_IN] = 0;
-		info->R[PSC_VOLTAGE_IN] = -1;
-		info->m[PSC_VOLTAGE_OUT] = 6666;
-		info->b[PSC_VOLTAGE_OUT] = 0;
-		info->R[PSC_VOLTAGE_OUT] = -1;
-	}
-
-	if (config & ADM1275_VIN_VOUT_SELECT)
-		info->func[0] |= PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
-	else
-		info->func[0] |= PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT;
-
-	ret = pmbus_do_probe(client, id, info);
-	if (ret)
-		goto err_mem;
-	return 0;
-
-err_mem:
-	kfree(info);
-	return ret;
-}
-
-static int adm1275_remove(struct i2c_client *client)
-{
-	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
-	int ret;
-
-	ret = pmbus_do_remove(client);
-	kfree(info);
-	return ret;
-}
-
-static const struct i2c_device_id adm1275_id[] = {
-	{"adm1275", 0},
-	{ }
-};
-MODULE_DEVICE_TABLE(i2c, adm1275_id);
-
-static struct i2c_driver adm1275_driver = {
-	.driver = {
-		   .name = "adm1275",
-		   },
-	.probe = adm1275_probe,
-	.remove = adm1275_remove,
-	.id_table = adm1275_id,
-};
-
-static int __init adm1275_init(void)
-{
-	return i2c_add_driver(&adm1275_driver);
-}
-
-static void __exit adm1275_exit(void)
-{
-	i2c_del_driver(&adm1275_driver);
-}
-
-MODULE_AUTHOR("Guenter Roeck");
-MODULE_DESCRIPTION("PMBus driver for Analog Devices ADM1275");
-MODULE_LICENSE("GPL");
-module_init(adm1275_init);
-module_exit(adm1275_exit);
diff --git a/drivers/hwmon/max16064.c b/drivers/hwmon/max16064.c
deleted file mode 100644
index 1d6d717..0000000
--- a/drivers/hwmon/max16064.c
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- * Hardware monitoring driver for Maxim MAX16064
- *
- * Copyright (c) 2011 Ericsson AB.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/i2c.h>
-#include "pmbus.h"
-
-static struct pmbus_driver_info max16064_info = {
-	.pages = 4,
-	.direct[PSC_VOLTAGE_IN] = true,
-	.direct[PSC_VOLTAGE_OUT] = true,
-	.direct[PSC_TEMPERATURE] = true,
-	.m[PSC_VOLTAGE_IN] = 19995,
-	.b[PSC_VOLTAGE_IN] = 0,
-	.R[PSC_VOLTAGE_IN] = -1,
-	.m[PSC_VOLTAGE_OUT] = 19995,
-	.b[PSC_VOLTAGE_OUT] = 0,
-	.R[PSC_VOLTAGE_OUT] = -1,
-	.m[PSC_TEMPERATURE] = -7612,
-	.b[PSC_TEMPERATURE] = 335,
-	.R[PSC_TEMPERATURE] = -3,
-	.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_TEMP
-		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_TEMP,
-	.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
-	.func[2] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
-	.func[3] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
-};
-
-static int max16064_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
-{
-	return pmbus_do_probe(client, id, &max16064_info);
-}
-
-static int max16064_remove(struct i2c_client *client)
-{
-	return pmbus_do_remove(client);
-}
-
-static const struct i2c_device_id max16064_id[] = {
-	{"max16064", 0},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, max16064_id);
-
-/* This is the driver that will be inserted */
-static struct i2c_driver max16064_driver = {
-	.driver = {
-		   .name = "max16064",
-		   },
-	.probe = max16064_probe,
-	.remove = max16064_remove,
-	.id_table = max16064_id,
-};
-
-static int __init max16064_init(void)
-{
-	return i2c_add_driver(&max16064_driver);
-}
-
-static void __exit max16064_exit(void)
-{
-	i2c_del_driver(&max16064_driver);
-}
-
-MODULE_AUTHOR("Guenter Roeck");
-MODULE_DESCRIPTION("PMBus driver for Maxim MAX16064");
-MODULE_LICENSE("GPL");
-module_init(max16064_init);
-module_exit(max16064_exit);
diff --git a/drivers/hwmon/max34440.c b/drivers/hwmon/max34440.c
deleted file mode 100644
index db11e1a..0000000
--- a/drivers/hwmon/max34440.c
+++ /dev/null
@@ -1,199 +0,0 @@
-/*
- * Hardware monitoring driver for Maxim MAX34440/MAX34441
- *
- * Copyright (c) 2011 Ericsson AB.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/i2c.h>
-#include "pmbus.h"
-
-enum chips { max34440, max34441 };
-
-#define MAX34440_STATUS_OC_WARN		(1 << 0)
-#define MAX34440_STATUS_OC_FAULT	(1 << 1)
-#define MAX34440_STATUS_OT_FAULT	(1 << 5)
-#define MAX34440_STATUS_OT_WARN		(1 << 6)
-
-static int max34440_read_byte_data(struct i2c_client *client, int page, int reg)
-{
-	int ret;
-	int mfg_status;
-
-	ret = pmbus_set_page(client, page);
-	if (ret < 0)
-		return ret;
-
-	switch (reg) {
-	case PMBUS_STATUS_IOUT:
-		mfg_status = pmbus_read_word_data(client, 0,
-						  PMBUS_STATUS_MFR_SPECIFIC);
-		if (mfg_status < 0)
-			return mfg_status;
-		if (mfg_status & MAX34440_STATUS_OC_WARN)
-			ret |= PB_IOUT_OC_WARNING;
-		if (mfg_status & MAX34440_STATUS_OC_FAULT)
-			ret |= PB_IOUT_OC_FAULT;
-		break;
-	case PMBUS_STATUS_TEMPERATURE:
-		mfg_status = pmbus_read_word_data(client, 0,
-						  PMBUS_STATUS_MFR_SPECIFIC);
-		if (mfg_status < 0)
-			return mfg_status;
-		if (mfg_status & MAX34440_STATUS_OT_WARN)
-			ret |= PB_TEMP_OT_WARNING;
-		if (mfg_status & MAX34440_STATUS_OT_FAULT)
-			ret |= PB_TEMP_OT_FAULT;
-		break;
-	default:
-		ret = -ENODATA;
-		break;
-	}
-	return ret;
-}
-
-static struct pmbus_driver_info max34440_info[] = {
-	[max34440] = {
-		.pages = 14,
-		.direct[PSC_VOLTAGE_IN] = true,
-		.direct[PSC_VOLTAGE_OUT] = true,
-		.direct[PSC_TEMPERATURE] = true,
-		.direct[PSC_CURRENT_OUT] = true,
-		.m[PSC_VOLTAGE_IN] = 1,
-		.b[PSC_VOLTAGE_IN] = 0,
-		.R[PSC_VOLTAGE_IN] = 3,	    /* R = 0 in datasheet reflects mV */
-		.m[PSC_VOLTAGE_OUT] = 1,
-		.b[PSC_VOLTAGE_OUT] = 0,
-		.R[PSC_VOLTAGE_OUT] = 3,    /* R = 0 in datasheet reflects mV */
-		.m[PSC_CURRENT_OUT] = 1,
-		.b[PSC_CURRENT_OUT] = 0,
-		.R[PSC_CURRENT_OUT] = 3,    /* R = 0 in datasheet reflects mA */
-		.m[PSC_TEMPERATURE] = 1,
-		.b[PSC_TEMPERATURE] = 0,
-		.R[PSC_TEMPERATURE] = 2,
-		.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
-		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
-		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
-		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
-		.func[2] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
-		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
-		.func[3] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
-		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
-		.func[4] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
-		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
-		.func[5] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
-		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
-		.func[6] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.func[7] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.func[8] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.func[9] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.func[10] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.func[11] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.func[12] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.func[13] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.read_byte_data = max34440_read_byte_data,
-	},
-	[max34441] = {
-		.pages = 12,
-		.direct[PSC_VOLTAGE_IN] = true,
-		.direct[PSC_VOLTAGE_OUT] = true,
-		.direct[PSC_TEMPERATURE] = true,
-		.direct[PSC_CURRENT_OUT] = true,
-		.direct[PSC_FAN] = true,
-		.m[PSC_VOLTAGE_IN] = 1,
-		.b[PSC_VOLTAGE_IN] = 0,
-		.R[PSC_VOLTAGE_IN] = 3,
-		.m[PSC_VOLTAGE_OUT] = 1,
-		.b[PSC_VOLTAGE_OUT] = 0,
-		.R[PSC_VOLTAGE_OUT] = 3,
-		.m[PSC_CURRENT_OUT] = 1,
-		.b[PSC_CURRENT_OUT] = 0,
-		.R[PSC_CURRENT_OUT] = 3,
-		.m[PSC_TEMPERATURE] = 1,
-		.b[PSC_TEMPERATURE] = 0,
-		.R[PSC_TEMPERATURE] = 2,
-		.m[PSC_FAN] = 1,
-		.b[PSC_FAN] = 0,
-		.R[PSC_FAN] = 0,
-		.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
-		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
-		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
-		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
-		.func[2] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
-		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
-		.func[3] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
-		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
-		.func[4] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
-		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
-		.func[5] = PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12,
-		.func[6] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.func[7] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.func[8] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.func[9] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.func[10] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.func[11] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
-		.read_byte_data = max34440_read_byte_data,
-	},
-};
-
-static int max34440_probe(struct i2c_client *client,
-			  const struct i2c_device_id *id)
-{
-	return pmbus_do_probe(client, id, &max34440_info[id->driver_data]);
-}
-
-static int max34440_remove(struct i2c_client *client)
-{
-	return pmbus_do_remove(client);
-}
-
-static const struct i2c_device_id max34440_id[] = {
-	{"max34440", max34440},
-	{"max34441", max34441},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, max34440_id);
-
-/* This is the driver that will be inserted */
-static struct i2c_driver max34440_driver = {
-	.driver = {
-		   .name = "max34440",
-		   },
-	.probe = max34440_probe,
-	.remove = max34440_remove,
-	.id_table = max34440_id,
-};
-
-static int __init max34440_init(void)
-{
-	return i2c_add_driver(&max34440_driver);
-}
-
-static void __exit max34440_exit(void)
-{
-	i2c_del_driver(&max34440_driver);
-}
-
-MODULE_AUTHOR("Guenter Roeck");
-MODULE_DESCRIPTION("PMBus driver for Maxim MAX34440/MAX34441");
-MODULE_LICENSE("GPL");
-module_init(max34440_init);
-module_exit(max34440_exit);
diff --git a/drivers/hwmon/max8688.c b/drivers/hwmon/max8688.c
deleted file mode 100644
index 7fb93f4..0000000
--- a/drivers/hwmon/max8688.c
+++ /dev/null
@@ -1,158 +0,0 @@
-/*
- * Hardware monitoring driver for Maxim MAX8688
- *
- * Copyright (c) 2011 Ericsson AB.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/i2c.h>
-#include "pmbus.h"
-
-#define MAX8688_MFG_STATUS		0xd8
-
-#define MAX8688_STATUS_OC_FAULT		(1 << 4)
-#define MAX8688_STATUS_OV_FAULT		(1 << 5)
-#define MAX8688_STATUS_OV_WARNING	(1 << 8)
-#define MAX8688_STATUS_UV_FAULT		(1 << 9)
-#define MAX8688_STATUS_UV_WARNING	(1 << 10)
-#define MAX8688_STATUS_UC_FAULT		(1 << 11)
-#define MAX8688_STATUS_OC_WARNING	(1 << 12)
-#define MAX8688_STATUS_OT_FAULT		(1 << 13)
-#define MAX8688_STATUS_OT_WARNING	(1 << 14)
-
-static int max8688_read_byte_data(struct i2c_client *client, int page, int reg)
-{
-	int ret = 0;
-	int mfg_status;
-
-	if (page)
-		return -EINVAL;
-
-	switch (reg) {
-	case PMBUS_STATUS_VOUT:
-		mfg_status = pmbus_read_word_data(client, 0,
-						  MAX8688_MFG_STATUS);
-		if (mfg_status < 0)
-			return mfg_status;
-		if (mfg_status & MAX8688_STATUS_UV_WARNING)
-			ret |= PB_VOLTAGE_UV_WARNING;
-		if (mfg_status & MAX8688_STATUS_UV_FAULT)
-			ret |= PB_VOLTAGE_UV_FAULT;
-		if (mfg_status & MAX8688_STATUS_OV_WARNING)
-			ret |= PB_VOLTAGE_OV_WARNING;
-		if (mfg_status & MAX8688_STATUS_OV_FAULT)
-			ret |= PB_VOLTAGE_OV_FAULT;
-		break;
-	case PMBUS_STATUS_IOUT:
-		mfg_status = pmbus_read_word_data(client, 0,
-						  MAX8688_MFG_STATUS);
-		if (mfg_status < 0)
-			return mfg_status;
-		if (mfg_status & MAX8688_STATUS_UC_FAULT)
-			ret |= PB_IOUT_UC_FAULT;
-		if (mfg_status & MAX8688_STATUS_OC_WARNING)
-			ret |= PB_IOUT_OC_WARNING;
-		if (mfg_status & MAX8688_STATUS_OC_FAULT)
-			ret |= PB_IOUT_OC_FAULT;
-		break;
-	case PMBUS_STATUS_TEMPERATURE:
-		mfg_status = pmbus_read_word_data(client, 0,
-						  MAX8688_MFG_STATUS);
-		if (mfg_status < 0)
-			return mfg_status;
-		if (mfg_status & MAX8688_STATUS_OT_WARNING)
-			ret |= PB_TEMP_OT_WARNING;
-		if (mfg_status & MAX8688_STATUS_OT_FAULT)
-			ret |= PB_TEMP_OT_FAULT;
-		break;
-	default:
-		ret = -ENODATA;
-		break;
-	}
-	return ret;
-}
-
-static struct pmbus_driver_info max8688_info = {
-	.pages = 1,
-	.direct[PSC_VOLTAGE_IN] = true,
-	.direct[PSC_VOLTAGE_OUT] = true,
-	.direct[PSC_TEMPERATURE] = true,
-	.direct[PSC_CURRENT_OUT] = true,
-	.m[PSC_VOLTAGE_IN] = 19995,
-	.b[PSC_VOLTAGE_IN] = 0,
-	.R[PSC_VOLTAGE_IN] = -1,
-	.m[PSC_VOLTAGE_OUT] = 19995,
-	.b[PSC_VOLTAGE_OUT] = 0,
-	.R[PSC_VOLTAGE_OUT] = -1,
-	.m[PSC_CURRENT_OUT] = 23109,
-	.b[PSC_CURRENT_OUT] = 0,
-	.R[PSC_CURRENT_OUT] = -2,
-	.m[PSC_TEMPERATURE] = -7612,
-	.b[PSC_TEMPERATURE] = 335,
-	.R[PSC_TEMPERATURE] = -3,
-	.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP
-		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
-		| PMBUS_HAVE_STATUS_TEMP,
-	.read_byte_data = max8688_read_byte_data,
-};
-
-static int max8688_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
-{
-	return pmbus_do_probe(client, id, &max8688_info);
-}
-
-static int max8688_remove(struct i2c_client *client)
-{
-	return pmbus_do_remove(client);
-}
-
-static const struct i2c_device_id max8688_id[] = {
-	{"max8688", 0},
-	{ }
-};
-
-MODULE_DEVICE_TABLE(i2c, max8688_id);
-
-/* This is the driver that will be inserted */
-static struct i2c_driver max8688_driver = {
-	.driver = {
-		   .name = "max8688",
-		   },
-	.probe = max8688_probe,
-	.remove = max8688_remove,
-	.id_table = max8688_id,
-};
-
-static int __init max8688_init(void)
-{
-	return i2c_add_driver(&max8688_driver);
-}
-
-static void __exit max8688_exit(void)
-{
-	i2c_del_driver(&max8688_driver);
-}
-
-MODULE_AUTHOR("Guenter Roeck");
-MODULE_DESCRIPTION("PMBus driver for Maxim MAX8688");
-MODULE_LICENSE("GPL");
-module_init(max8688_init);
-module_exit(max8688_exit);
diff --git a/drivers/hwmon/pmbus.c b/drivers/hwmon/pmbus.c
deleted file mode 100644
index 9b1f0c3..0000000
--- a/drivers/hwmon/pmbus.c
+++ /dev/null
@@ -1,210 +0,0 @@
-/*
- * Hardware monitoring driver for PMBus devices
- *
- * Copyright (c) 2010, 2011 Ericsson AB.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/mutex.h>
-#include <linux/i2c.h>
-#include "pmbus.h"
-
-/*
- * Find sensor groups and status registers on each page.
- */
-static void pmbus_find_sensor_groups(struct i2c_client *client,
-				     struct pmbus_driver_info *info)
-{
-	int page;
-
-	/* Sensors detected on page 0 only */
-	if (pmbus_check_word_register(client, 0, PMBUS_READ_VIN))
-		info->func[0] |= PMBUS_HAVE_VIN;
-	if (pmbus_check_word_register(client, 0, PMBUS_READ_VCAP))
-		info->func[0] |= PMBUS_HAVE_VCAP;
-	if (pmbus_check_word_register(client, 0, PMBUS_READ_IIN))
-		info->func[0] |= PMBUS_HAVE_IIN;
-	if (pmbus_check_word_register(client, 0, PMBUS_READ_PIN))
-		info->func[0] |= PMBUS_HAVE_PIN;
-	if (info->func[0]
-	    && pmbus_check_byte_register(client, 0, PMBUS_STATUS_INPUT))
-		info->func[0] |= PMBUS_HAVE_STATUS_INPUT;
-	if (pmbus_check_byte_register(client, 0, PMBUS_FAN_CONFIG_12) &&
-	    pmbus_check_word_register(client, 0, PMBUS_READ_FAN_SPEED_1)) {
-		info->func[0] |= PMBUS_HAVE_FAN12;
-		if (pmbus_check_byte_register(client, 0, PMBUS_STATUS_FAN_12))
-			info->func[0] |= PMBUS_HAVE_STATUS_FAN12;
-	}
-	if (pmbus_check_byte_register(client, 0, PMBUS_FAN_CONFIG_34) &&
-	    pmbus_check_word_register(client, 0, PMBUS_READ_FAN_SPEED_3)) {
-		info->func[0] |= PMBUS_HAVE_FAN34;
-		if (pmbus_check_byte_register(client, 0, PMBUS_STATUS_FAN_34))
-			info->func[0] |= PMBUS_HAVE_STATUS_FAN34;
-	}
-	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_1))
-		info->func[0] |= PMBUS_HAVE_TEMP;
-	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_2))
-		info->func[0] |= PMBUS_HAVE_TEMP2;
-	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_3))
-		info->func[0] |= PMBUS_HAVE_TEMP3;
-	if (info->func[0] & (PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
-			     | PMBUS_HAVE_TEMP3)
-	    && pmbus_check_byte_register(client, 0,
-					 PMBUS_STATUS_TEMPERATURE))
-			info->func[0] |= PMBUS_HAVE_STATUS_TEMP;
-
-	/* Sensors detected on all pages */
-	for (page = 0; page < info->pages; page++) {
-		if (pmbus_check_word_register(client, page, PMBUS_READ_VOUT)) {
-			info->func[page] |= PMBUS_HAVE_VOUT;
-			if (pmbus_check_byte_register(client, page,
-						      PMBUS_STATUS_VOUT))
-				info->func[page] |= PMBUS_HAVE_STATUS_VOUT;
-		}
-		if (pmbus_check_word_register(client, page, PMBUS_READ_IOUT)) {
-			info->func[page] |= PMBUS_HAVE_IOUT;
-			if (pmbus_check_byte_register(client, 0,
-						      PMBUS_STATUS_IOUT))
-				info->func[page] |= PMBUS_HAVE_STATUS_IOUT;
-		}
-		if (pmbus_check_word_register(client, page, PMBUS_READ_POUT))
-			info->func[page] |= PMBUS_HAVE_POUT;
-	}
-}
-
-/*
- * Identify chip parameters.
- */
-static int pmbus_identify(struct i2c_client *client,
-			  struct pmbus_driver_info *info)
-{
-	if (!info->pages) {
-		/*
-		 * Check if the PAGE command is supported. If it is,
-		 * keep setting the page number until it fails or until the
-		 * maximum number of pages has been reached. Assume that
-		 * this is the number of pages supported by the chip.
-		 */
-		if (pmbus_check_byte_register(client, 0, PMBUS_PAGE)) {
-			int page;
-
-			for (page = 1; page < PMBUS_PAGES; page++) {
-				if (pmbus_set_page(client, page) < 0)
-					break;
-			}
-			pmbus_set_page(client, 0);
-			info->pages = page;
-		} else {
-			info->pages = 1;
-		}
-	}
-
-	/*
-	 * We should check if the COEFFICIENTS register is supported.
-	 * If it is, and the chip is configured for direct mode, we can read
-	 * the coefficients from the chip, one set per group of sensor
-	 * registers.
-	 *
-	 * To do this, we will need access to a chip which actually supports the
-	 * COEFFICIENTS command, since the command is too complex to implement
-	 * without testing it.
-	 */
-
-	/* Try to find sensor groups  */
-	pmbus_find_sensor_groups(client, info);
-
-	return 0;
-}
-
-static int pmbus_probe(struct i2c_client *client,
-		       const struct i2c_device_id *id)
-{
-	struct pmbus_driver_info *info;
-	int ret;
-
-	info = kzalloc(sizeof(struct pmbus_driver_info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	info->pages = id->driver_data;
-	info->identify = pmbus_identify;
-
-	ret = pmbus_do_probe(client, id, info);
-	if (ret < 0)
-		goto out;
-	return 0;
-
-out:
-	kfree(info);
-	return ret;
-}
-
-static int pmbus_remove(struct i2c_client *client)
-{
-	int ret;
-	const struct pmbus_driver_info *info;
-
-	info = pmbus_get_driver_info(client);
-	ret = pmbus_do_remove(client);
-	kfree(info);
-	return ret;
-}
-
-/*
- * Use driver_data to set the number of pages supported by the chip.
- */
-static const struct i2c_device_id pmbus_id[] = {
-	{"bmr450", 1},
-	{"bmr451", 1},
-	{"bmr453", 1},
-	{"bmr454", 1},
-	{"ltc2978", 8},
-	{"pmbus", 0},
-	{}
-};
-
-MODULE_DEVICE_TABLE(i2c, pmbus_id);
-
-/* This is the driver that will be inserted */
-static struct i2c_driver pmbus_driver = {
-	.driver = {
-		   .name = "pmbus",
-		   },
-	.probe = pmbus_probe,
-	.remove = pmbus_remove,
-	.id_table = pmbus_id,
-};
-
-static int __init pmbus_init(void)
-{
-	return i2c_add_driver(&pmbus_driver);
-}
-
-static void __exit pmbus_exit(void)
-{
-	i2c_del_driver(&pmbus_driver);
-}
-
-MODULE_AUTHOR("Guenter Roeck");
-MODULE_DESCRIPTION("Generic PMBus driver");
-MODULE_LICENSE("GPL");
-module_init(pmbus_init);
-module_exit(pmbus_exit);
diff --git a/drivers/hwmon/pmbus.h b/drivers/hwmon/pmbus.h
deleted file mode 100644
index 50647ab..0000000
--- a/drivers/hwmon/pmbus.h
+++ /dev/null
@@ -1,311 +0,0 @@
-/*
- * pmbus.h - Common defines and structures for PMBus devices
- *
- * Copyright (c) 2010, 2011 Ericsson AB.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#ifndef PMBUS_H
-#define PMBUS_H
-
-/*
- * Registers
- */
-#define PMBUS_PAGE			0x00
-#define PMBUS_OPERATION			0x01
-#define PMBUS_ON_OFF_CONFIG		0x02
-#define PMBUS_CLEAR_FAULTS		0x03
-#define PMBUS_PHASE			0x04
-
-#define PMBUS_CAPABILITY		0x19
-#define PMBUS_QUERY			0x1A
-
-#define PMBUS_VOUT_MODE			0x20
-#define PMBUS_VOUT_COMMAND		0x21
-#define PMBUS_VOUT_TRIM			0x22
-#define PMBUS_VOUT_CAL_OFFSET		0x23
-#define PMBUS_VOUT_MAX			0x24
-#define PMBUS_VOUT_MARGIN_HIGH		0x25
-#define PMBUS_VOUT_MARGIN_LOW		0x26
-#define PMBUS_VOUT_TRANSITION_RATE	0x27
-#define PMBUS_VOUT_DROOP		0x28
-#define PMBUS_VOUT_SCALE_LOOP		0x29
-#define PMBUS_VOUT_SCALE_MONITOR	0x2A
-
-#define PMBUS_COEFFICIENTS		0x30
-#define PMBUS_POUT_MAX			0x31
-
-#define PMBUS_FAN_CONFIG_12		0x3A
-#define PMBUS_FAN_COMMAND_1		0x3B
-#define PMBUS_FAN_COMMAND_2		0x3C
-#define PMBUS_FAN_CONFIG_34		0x3D
-#define PMBUS_FAN_COMMAND_3		0x3E
-#define PMBUS_FAN_COMMAND_4		0x3F
-
-#define PMBUS_VOUT_OV_FAULT_LIMIT	0x40
-#define PMBUS_VOUT_OV_FAULT_RESPONSE	0x41
-#define PMBUS_VOUT_OV_WARN_LIMIT	0x42
-#define PMBUS_VOUT_UV_WARN_LIMIT	0x43
-#define PMBUS_VOUT_UV_FAULT_LIMIT	0x44
-#define PMBUS_VOUT_UV_FAULT_RESPONSE	0x45
-#define PMBUS_IOUT_OC_FAULT_LIMIT	0x46
-#define PMBUS_IOUT_OC_FAULT_RESPONSE	0x47
-#define PMBUS_IOUT_OC_LV_FAULT_LIMIT	0x48
-#define PMBUS_IOUT_OC_LV_FAULT_RESPONSE	0x49
-#define PMBUS_IOUT_OC_WARN_LIMIT	0x4A
-#define PMBUS_IOUT_UC_FAULT_LIMIT	0x4B
-#define PMBUS_IOUT_UC_FAULT_RESPONSE	0x4C
-
-#define PMBUS_OT_FAULT_LIMIT		0x4F
-#define PMBUS_OT_FAULT_RESPONSE		0x50
-#define PMBUS_OT_WARN_LIMIT		0x51
-#define PMBUS_UT_WARN_LIMIT		0x52
-#define PMBUS_UT_FAULT_LIMIT		0x53
-#define PMBUS_UT_FAULT_RESPONSE		0x54
-#define PMBUS_VIN_OV_FAULT_LIMIT	0x55
-#define PMBUS_VIN_OV_FAULT_RESPONSE	0x56
-#define PMBUS_VIN_OV_WARN_LIMIT		0x57
-#define PMBUS_VIN_UV_WARN_LIMIT		0x58
-#define PMBUS_VIN_UV_FAULT_LIMIT	0x59
-
-#define PMBUS_IIN_OC_FAULT_LIMIT	0x5B
-#define PMBUS_IIN_OC_WARN_LIMIT		0x5D
-
-#define PMBUS_POUT_OP_FAULT_LIMIT	0x68
-#define PMBUS_POUT_OP_WARN_LIMIT	0x6A
-#define PMBUS_PIN_OP_WARN_LIMIT		0x6B
-
-#define PMBUS_STATUS_BYTE		0x78
-#define PMBUS_STATUS_WORD		0x79
-#define PMBUS_STATUS_VOUT		0x7A
-#define PMBUS_STATUS_IOUT		0x7B
-#define PMBUS_STATUS_INPUT		0x7C
-#define PMBUS_STATUS_TEMPERATURE	0x7D
-#define PMBUS_STATUS_CML		0x7E
-#define PMBUS_STATUS_OTHER		0x7F
-#define PMBUS_STATUS_MFR_SPECIFIC	0x80
-#define PMBUS_STATUS_FAN_12		0x81
-#define PMBUS_STATUS_FAN_34		0x82
-
-#define PMBUS_READ_VIN			0x88
-#define PMBUS_READ_IIN			0x89
-#define PMBUS_READ_VCAP			0x8A
-#define PMBUS_READ_VOUT			0x8B
-#define PMBUS_READ_IOUT			0x8C
-#define PMBUS_READ_TEMPERATURE_1	0x8D
-#define PMBUS_READ_TEMPERATURE_2	0x8E
-#define PMBUS_READ_TEMPERATURE_3	0x8F
-#define PMBUS_READ_FAN_SPEED_1		0x90
-#define PMBUS_READ_FAN_SPEED_2		0x91
-#define PMBUS_READ_FAN_SPEED_3		0x92
-#define PMBUS_READ_FAN_SPEED_4		0x93
-#define PMBUS_READ_DUTY_CYCLE		0x94
-#define PMBUS_READ_FREQUENCY		0x95
-#define PMBUS_READ_POUT			0x96
-#define PMBUS_READ_PIN			0x97
-
-#define PMBUS_REVISION			0x98
-#define PMBUS_MFR_ID			0x99
-#define PMBUS_MFR_MODEL			0x9A
-#define PMBUS_MFR_REVISION		0x9B
-#define PMBUS_MFR_LOCATION		0x9C
-#define PMBUS_MFR_DATE			0x9D
-#define PMBUS_MFR_SERIAL		0x9E
-
-/*
- * CAPABILITY
- */
-#define PB_CAPABILITY_SMBALERT		(1<<4)
-#define PB_CAPABILITY_ERROR_CHECK	(1<<7)
-
-/*
- * VOUT_MODE
- */
-#define PB_VOUT_MODE_MODE_MASK		0xe0
-#define PB_VOUT_MODE_PARAM_MASK		0x1f
-
-#define PB_VOUT_MODE_LINEAR		0x00
-#define PB_VOUT_MODE_VID		0x20
-#define PB_VOUT_MODE_DIRECT		0x40
-
-/*
- * Fan configuration
- */
-#define PB_FAN_2_PULSE_MASK		((1 << 0) | (1 << 1))
-#define PB_FAN_2_RPM			(1 << 2)
-#define PB_FAN_2_INSTALLED		(1 << 3)
-#define PB_FAN_1_PULSE_MASK		((1 << 4) | (1 << 5))
-#define PB_FAN_1_RPM			(1 << 6)
-#define PB_FAN_1_INSTALLED		(1 << 7)
-
-/*
- * STATUS_BYTE, STATUS_WORD (lower)
- */
-#define PB_STATUS_NONE_ABOVE		(1<<0)
-#define PB_STATUS_CML			(1<<1)
-#define PB_STATUS_TEMPERATURE		(1<<2)
-#define PB_STATUS_VIN_UV		(1<<3)
-#define PB_STATUS_IOUT_OC		(1<<4)
-#define PB_STATUS_VOUT_OV		(1<<5)
-#define PB_STATUS_OFF			(1<<6)
-#define PB_STATUS_BUSY			(1<<7)
-
-/*
- * STATUS_WORD (upper)
- */
-#define PB_STATUS_UNKNOWN		(1<<8)
-#define PB_STATUS_OTHER			(1<<9)
-#define PB_STATUS_FANS			(1<<10)
-#define PB_STATUS_POWER_GOOD_N		(1<<11)
-#define PB_STATUS_WORD_MFR		(1<<12)
-#define PB_STATUS_INPUT			(1<<13)
-#define PB_STATUS_IOUT_POUT		(1<<14)
-#define PB_STATUS_VOUT			(1<<15)
-
-/*
- * STATUS_IOUT
- */
-#define PB_POUT_OP_WARNING		(1<<0)
-#define PB_POUT_OP_FAULT		(1<<1)
-#define PB_POWER_LIMITING		(1<<2)
-#define PB_CURRENT_SHARE_FAULT		(1<<3)
-#define PB_IOUT_UC_FAULT		(1<<4)
-#define PB_IOUT_OC_WARNING		(1<<5)
-#define PB_IOUT_OC_LV_FAULT		(1<<6)
-#define PB_IOUT_OC_FAULT		(1<<7)
-
-/*
- * STATUS_VOUT, STATUS_INPUT
- */
-#define PB_VOLTAGE_UV_FAULT		(1<<4)
-#define PB_VOLTAGE_UV_WARNING		(1<<5)
-#define PB_VOLTAGE_OV_WARNING		(1<<6)
-#define PB_VOLTAGE_OV_FAULT		(1<<7)
-
-/*
- * STATUS_INPUT
- */
-#define PB_PIN_OP_WARNING		(1<<0)
-#define PB_IIN_OC_WARNING		(1<<1)
-#define PB_IIN_OC_FAULT			(1<<2)
-
-/*
- * STATUS_TEMPERATURE
- */
-#define PB_TEMP_UT_FAULT		(1<<4)
-#define PB_TEMP_UT_WARNING		(1<<5)
-#define PB_TEMP_OT_WARNING		(1<<6)
-#define PB_TEMP_OT_FAULT		(1<<7)
-
-/*
- * STATUS_FAN
- */
-#define PB_FAN_AIRFLOW_WARNING		(1<<0)
-#define PB_FAN_AIRFLOW_FAULT		(1<<1)
-#define PB_FAN_FAN2_SPEED_OVERRIDE	(1<<2)
-#define PB_FAN_FAN1_SPEED_OVERRIDE	(1<<3)
-#define PB_FAN_FAN2_WARNING		(1<<4)
-#define PB_FAN_FAN1_WARNING		(1<<5)
-#define PB_FAN_FAN2_FAULT		(1<<6)
-#define PB_FAN_FAN1_FAULT		(1<<7)
-
-/*
- * CML_FAULT_STATUS
- */
-#define PB_CML_FAULT_OTHER_MEM_LOGIC	(1<<0)
-#define PB_CML_FAULT_OTHER_COMM		(1<<1)
-#define PB_CML_FAULT_PROCESSOR		(1<<3)
-#define PB_CML_FAULT_MEMORY		(1<<4)
-#define PB_CML_FAULT_PACKET_ERROR	(1<<5)
-#define PB_CML_FAULT_INVALID_DATA	(1<<6)
-#define PB_CML_FAULT_INVALID_COMMAND	(1<<7)
-
-enum pmbus_sensor_classes {
-	PSC_VOLTAGE_IN = 0,
-	PSC_VOLTAGE_OUT,
-	PSC_CURRENT_IN,
-	PSC_CURRENT_OUT,
-	PSC_POWER,
-	PSC_TEMPERATURE,
-	PSC_FAN,
-	PSC_NUM_CLASSES		/* Number of power sensor classes */
-};
-
-#define PMBUS_PAGES	32	/* Per PMBus specification */
-
-/* Functionality bit mask */
-#define PMBUS_HAVE_VIN		(1 << 0)
-#define PMBUS_HAVE_VCAP		(1 << 1)
-#define PMBUS_HAVE_VOUT		(1 << 2)
-#define PMBUS_HAVE_IIN		(1 << 3)
-#define PMBUS_HAVE_IOUT		(1 << 4)
-#define PMBUS_HAVE_PIN		(1 << 5)
-#define PMBUS_HAVE_POUT		(1 << 6)
-#define PMBUS_HAVE_FAN12	(1 << 7)
-#define PMBUS_HAVE_FAN34	(1 << 8)
-#define PMBUS_HAVE_TEMP		(1 << 9)
-#define PMBUS_HAVE_TEMP2	(1 << 10)
-#define PMBUS_HAVE_TEMP3	(1 << 11)
-#define PMBUS_HAVE_STATUS_VOUT	(1 << 12)
-#define PMBUS_HAVE_STATUS_IOUT	(1 << 13)
-#define PMBUS_HAVE_STATUS_INPUT	(1 << 14)
-#define PMBUS_HAVE_STATUS_TEMP	(1 << 15)
-#define PMBUS_HAVE_STATUS_FAN12	(1 << 16)
-#define PMBUS_HAVE_STATUS_FAN34	(1 << 17)
-
-struct pmbus_driver_info {
-	int pages;		/* Total number of pages */
-	bool direct[PSC_NUM_CLASSES];
-				/* true if device uses direct data format
-				   for the given sensor class */
-	/*
-	 * Support one set of coefficients for each sensor type
-	 * Used for chips providing data in direct mode.
-	 */
-	int m[PSC_NUM_CLASSES];	/* mantissa for direct data format */
-	int b[PSC_NUM_CLASSES];	/* offset */
-	int R[PSC_NUM_CLASSES];	/* exponent */
-
-	u32 func[PMBUS_PAGES];	/* Functionality, per page */
-	/*
-	 * The following functions map manufacturing specific register values
-	 * to PMBus standard register values. Specify only if mapping is
-	 * necessary.
-	 */
-	int (*read_byte_data)(struct i2c_client *client, int page, int reg);
-	/*
-	 * The identify function determines supported PMBus functionality.
-	 * This function is only necessary if a chip driver supports multiple
-	 * chips, and the chip functionality is not pre-determined.
-	 */
-	int (*identify)(struct i2c_client *client,
-			struct pmbus_driver_info *info);
-};
-
-/* Function declarations */
-
-int pmbus_set_page(struct i2c_client *client, u8 page);
-int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 reg);
-void pmbus_clear_faults(struct i2c_client *client);
-bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg);
-bool pmbus_check_word_register(struct i2c_client *client, int page, int reg);
-int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
-		   struct pmbus_driver_info *info);
-int pmbus_do_remove(struct i2c_client *client);
-const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client
-						      *client);
-
-#endif /* PMBUS_H */
diff --git a/drivers/hwmon/pmbus/Kconfig b/drivers/hwmon/pmbus/Kconfig
new file mode 100644
index 0000000..c87c07f
--- /dev/null
+++ b/drivers/hwmon/pmbus/Kconfig
@@ -0,0 +1,91 @@
+#
+# PMBus chip drivers configuration
+#
+
+menuconfig PMBUS
+	tristate "PMBus support"
+	depends on I2C && EXPERIMENTAL
+	default n
+	help
+	  Say yes here if you want to enable PMBus support.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called pmbus_core.
+
+if PMBUS
+
+config SENSORS_PMBUS
+	tristate "Generic PMBus devices"
+	default y
+	help
+	  If you say yes here you get hardware monitoring support for generic
+	  PMBus devices, including but not limited to BMR450, BMR451, BMR453,
+	  BMR454, and LTC2978.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called pmbus.
+
+config SENSORS_ADM1275
+	tristate "Analog Devices ADM1275"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for Analog
+	  Devices ADM1275 Hot-Swap Controller and Digital Power Monitor.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called adm1275.
+
+config SENSORS_MAX16064
+	tristate "Maxim MAX16064"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for Maxim
+	  MAX16064.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called max16064.
+
+config SENSORS_MAX34440
+	tristate "Maxim MAX34440/MAX34441"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for Maxim
+	  MAX34440 and MAX34441.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called max34440.
+
+config SENSORS_MAX8688
+	tristate "Maxim MAX8688"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for Maxim
+	  MAX8688.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called max8688.
+
+config SENSORS_UCD9000
+	tristate "TI UCD90120, UCD90124, UCD9090, UCD90910"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for TI
+	  UCD90120, UCD90124, UCD9090, UCD90910 Sequencer and System Health
+	  Controllers.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ucd9000.
+
+config SENSORS_UCD9200
+	tristate "TI UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, UCD9248"
+	default n
+	help
+	  If you say yes here you get hardware monitoring support for TI
+	  UCD9220, UCD9222, UCD9224, UCD9240, UCD9244, UCD9246, and UCD9248
+	  Digital PWM System Controllers.
+
+	  This driver can also be built as a module. If so, the module will
+	  be called ucd9200.
+
+endif # PMBUS
+
diff --git a/drivers/hwmon/pmbus/Makefile b/drivers/hwmon/pmbus/Makefile
new file mode 100644
index 0000000..0178f81
--- /dev/null
+++ b/drivers/hwmon/pmbus/Makefile
@@ -0,0 +1,12 @@
+#
+# Makefile for PMBus chip drivers.
+#
+
+obj-$(CONFIG_PMBUS)		+= pmbus_core.o
+obj-$(CONFIG_SENSORS_PMBUS)	+= pmbus.o
+obj-$(CONFIG_SENSORS_ADM1275)	+= adm1275.o
+obj-$(CONFIG_SENSORS_MAX16064)	+= max16064.o
+obj-$(CONFIG_SENSORS_MAX34440)	+= max34440.o
+obj-$(CONFIG_SENSORS_MAX8688)	+= max8688.o
+obj-$(CONFIG_SENSORS_UCD9000)	+= ucd9000.o
+obj-$(CONFIG_SENSORS_UCD9200)	+= ucd9200.o
diff --git a/drivers/hwmon/pmbus/adm1275.c b/drivers/hwmon/pmbus/adm1275.c
new file mode 100644
index 0000000..b9b7caf
--- /dev/null
+++ b/drivers/hwmon/pmbus/adm1275.c
@@ -0,0 +1,131 @@
+/*
+ * Hardware monitoring driver for Analog Devices ADM1275 Hot-Swap Controller
+ * and Digital Power Monitor
+ *
+ * Copyright (c) 2011 Ericsson AB.
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
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include "pmbus.h"
+
+#define ADM1275_PMON_CONFIG		0xd4
+
+#define ADM1275_VIN_VOUT_SELECT		(1 << 6)
+#define ADM1275_VRANGE			(1 << 5)
+
+static int adm1275_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	int config;
+	int ret;
+	struct pmbus_driver_info *info;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_READ_BYTE_DATA))
+		return -ENODEV;
+
+	info = kzalloc(sizeof(struct pmbus_driver_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	config = i2c_smbus_read_byte_data(client, ADM1275_PMON_CONFIG);
+	if (config < 0) {
+		ret = config;
+		goto err_mem;
+	}
+
+	info->pages = 1;
+	info->direct[PSC_VOLTAGE_IN] = true;
+	info->direct[PSC_VOLTAGE_OUT] = true;
+	info->direct[PSC_CURRENT_OUT] = true;
+	info->m[PSC_CURRENT_OUT] = 800;
+	info->b[PSC_CURRENT_OUT] = 20475;
+	info->R[PSC_CURRENT_OUT] = -1;
+	info->func[0] = PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT;
+
+	if (config & ADM1275_VRANGE) {
+		info->m[PSC_VOLTAGE_IN] = 19045;
+		info->b[PSC_VOLTAGE_IN] = 0;
+		info->R[PSC_VOLTAGE_IN] = -2;
+		info->m[PSC_VOLTAGE_OUT] = 19045;
+		info->b[PSC_VOLTAGE_OUT] = 0;
+		info->R[PSC_VOLTAGE_OUT] = -2;
+	} else {
+		info->m[PSC_VOLTAGE_IN] = 6666;
+		info->b[PSC_VOLTAGE_IN] = 0;
+		info->R[PSC_VOLTAGE_IN] = -1;
+		info->m[PSC_VOLTAGE_OUT] = 6666;
+		info->b[PSC_VOLTAGE_OUT] = 0;
+		info->R[PSC_VOLTAGE_OUT] = -1;
+	}
+
+	if (config & ADM1275_VIN_VOUT_SELECT)
+		info->func[0] |= PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT;
+	else
+		info->func[0] |= PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT;
+
+	ret = pmbus_do_probe(client, id, info);
+	if (ret)
+		goto err_mem;
+	return 0;
+
+err_mem:
+	kfree(info);
+	return ret;
+}
+
+static int adm1275_remove(struct i2c_client *client)
+{
+	const struct pmbus_driver_info *info = pmbus_get_driver_info(client);
+	int ret;
+
+	ret = pmbus_do_remove(client);
+	kfree(info);
+	return ret;
+}
+
+static const struct i2c_device_id adm1275_id[] = {
+	{"adm1275", 0},
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, adm1275_id);
+
+static struct i2c_driver adm1275_driver = {
+	.driver = {
+		   .name = "adm1275",
+		   },
+	.probe = adm1275_probe,
+	.remove = adm1275_remove,
+	.id_table = adm1275_id,
+};
+
+static int __init adm1275_init(void)
+{
+	return i2c_add_driver(&adm1275_driver);
+}
+
+static void __exit adm1275_exit(void)
+{
+	i2c_del_driver(&adm1275_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("PMBus driver for Analog Devices ADM1275");
+MODULE_LICENSE("GPL");
+module_init(adm1275_init);
+module_exit(adm1275_exit);
diff --git a/drivers/hwmon/pmbus/max16064.c b/drivers/hwmon/pmbus/max16064.c
new file mode 100644
index 0000000..1d6d717
--- /dev/null
+++ b/drivers/hwmon/pmbus/max16064.c
@@ -0,0 +1,91 @@
+/*
+ * Hardware monitoring driver for Maxim MAX16064
+ *
+ * Copyright (c) 2011 Ericsson AB.
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
+static struct pmbus_driver_info max16064_info = {
+	.pages = 4,
+	.direct[PSC_VOLTAGE_IN] = true,
+	.direct[PSC_VOLTAGE_OUT] = true,
+	.direct[PSC_TEMPERATURE] = true,
+	.m[PSC_VOLTAGE_IN] = 19995,
+	.b[PSC_VOLTAGE_IN] = 0,
+	.R[PSC_VOLTAGE_IN] = -1,
+	.m[PSC_VOLTAGE_OUT] = 19995,
+	.b[PSC_VOLTAGE_OUT] = 0,
+	.R[PSC_VOLTAGE_OUT] = -1,
+	.m[PSC_TEMPERATURE] = -7612,
+	.b[PSC_TEMPERATURE] = 335,
+	.R[PSC_TEMPERATURE] = -3,
+	.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_TEMP
+		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_TEMP,
+	.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+	.func[2] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+	.func[3] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT,
+};
+
+static int max16064_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	return pmbus_do_probe(client, id, &max16064_info);
+}
+
+static int max16064_remove(struct i2c_client *client)
+{
+	return pmbus_do_remove(client);
+}
+
+static const struct i2c_device_id max16064_id[] = {
+	{"max16064", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, max16064_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver max16064_driver = {
+	.driver = {
+		   .name = "max16064",
+		   },
+	.probe = max16064_probe,
+	.remove = max16064_remove,
+	.id_table = max16064_id,
+};
+
+static int __init max16064_init(void)
+{
+	return i2c_add_driver(&max16064_driver);
+}
+
+static void __exit max16064_exit(void)
+{
+	i2c_del_driver(&max16064_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("PMBus driver for Maxim MAX16064");
+MODULE_LICENSE("GPL");
+module_init(max16064_init);
+module_exit(max16064_exit);
diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
new file mode 100644
index 0000000..db11e1a
--- /dev/null
+++ b/drivers/hwmon/pmbus/max34440.c
@@ -0,0 +1,199 @@
+/*
+ * Hardware monitoring driver for Maxim MAX34440/MAX34441
+ *
+ * Copyright (c) 2011 Ericsson AB.
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
+enum chips { max34440, max34441 };
+
+#define MAX34440_STATUS_OC_WARN		(1 << 0)
+#define MAX34440_STATUS_OC_FAULT	(1 << 1)
+#define MAX34440_STATUS_OT_FAULT	(1 << 5)
+#define MAX34440_STATUS_OT_WARN		(1 << 6)
+
+static int max34440_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int ret;
+	int mfg_status;
+
+	ret = pmbus_set_page(client, page);
+	if (ret < 0)
+		return ret;
+
+	switch (reg) {
+	case PMBUS_STATUS_IOUT:
+		mfg_status = pmbus_read_word_data(client, 0,
+						  PMBUS_STATUS_MFR_SPECIFIC);
+		if (mfg_status < 0)
+			return mfg_status;
+		if (mfg_status & MAX34440_STATUS_OC_WARN)
+			ret |= PB_IOUT_OC_WARNING;
+		if (mfg_status & MAX34440_STATUS_OC_FAULT)
+			ret |= PB_IOUT_OC_FAULT;
+		break;
+	case PMBUS_STATUS_TEMPERATURE:
+		mfg_status = pmbus_read_word_data(client, 0,
+						  PMBUS_STATUS_MFR_SPECIFIC);
+		if (mfg_status < 0)
+			return mfg_status;
+		if (mfg_status & MAX34440_STATUS_OT_WARN)
+			ret |= PB_TEMP_OT_WARNING;
+		if (mfg_status & MAX34440_STATUS_OT_FAULT)
+			ret |= PB_TEMP_OT_FAULT;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
+static struct pmbus_driver_info max34440_info[] = {
+	[max34440] = {
+		.pages = 14,
+		.direct[PSC_VOLTAGE_IN] = true,
+		.direct[PSC_VOLTAGE_OUT] = true,
+		.direct[PSC_TEMPERATURE] = true,
+		.direct[PSC_CURRENT_OUT] = true,
+		.m[PSC_VOLTAGE_IN] = 1,
+		.b[PSC_VOLTAGE_IN] = 0,
+		.R[PSC_VOLTAGE_IN] = 3,	    /* R = 0 in datasheet reflects mV */
+		.m[PSC_VOLTAGE_OUT] = 1,
+		.b[PSC_VOLTAGE_OUT] = 0,
+		.R[PSC_VOLTAGE_OUT] = 3,    /* R = 0 in datasheet reflects mV */
+		.m[PSC_CURRENT_OUT] = 1,
+		.b[PSC_CURRENT_OUT] = 0,
+		.R[PSC_CURRENT_OUT] = 3,    /* R = 0 in datasheet reflects mA */
+		.m[PSC_TEMPERATURE] = 1,
+		.b[PSC_TEMPERATURE] = 0,
+		.R[PSC_TEMPERATURE] = 2,
+		.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[2] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[3] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[4] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[5] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[6] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[7] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[8] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[9] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[10] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[11] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[12] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[13] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.read_byte_data = max34440_read_byte_data,
+	},
+	[max34441] = {
+		.pages = 12,
+		.direct[PSC_VOLTAGE_IN] = true,
+		.direct[PSC_VOLTAGE_OUT] = true,
+		.direct[PSC_TEMPERATURE] = true,
+		.direct[PSC_CURRENT_OUT] = true,
+		.direct[PSC_FAN] = true,
+		.m[PSC_VOLTAGE_IN] = 1,
+		.b[PSC_VOLTAGE_IN] = 0,
+		.R[PSC_VOLTAGE_IN] = 3,
+		.m[PSC_VOLTAGE_OUT] = 1,
+		.b[PSC_VOLTAGE_OUT] = 0,
+		.R[PSC_VOLTAGE_OUT] = 3,
+		.m[PSC_CURRENT_OUT] = 1,
+		.b[PSC_CURRENT_OUT] = 0,
+		.R[PSC_CURRENT_OUT] = 3,
+		.m[PSC_TEMPERATURE] = 1,
+		.b[PSC_TEMPERATURE] = 0,
+		.R[PSC_TEMPERATURE] = 2,
+		.m[PSC_FAN] = 1,
+		.b[PSC_FAN] = 0,
+		.R[PSC_FAN] = 0,
+		.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[1] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[2] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[3] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[4] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT
+		  | PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT,
+		.func[5] = PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12,
+		.func[6] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[7] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[8] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[9] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[10] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.func[11] = PMBUS_HAVE_TEMP | PMBUS_HAVE_STATUS_TEMP,
+		.read_byte_data = max34440_read_byte_data,
+	},
+};
+
+static int max34440_probe(struct i2c_client *client,
+			  const struct i2c_device_id *id)
+{
+	return pmbus_do_probe(client, id, &max34440_info[id->driver_data]);
+}
+
+static int max34440_remove(struct i2c_client *client)
+{
+	return pmbus_do_remove(client);
+}
+
+static const struct i2c_device_id max34440_id[] = {
+	{"max34440", max34440},
+	{"max34441", max34441},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, max34440_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver max34440_driver = {
+	.driver = {
+		   .name = "max34440",
+		   },
+	.probe = max34440_probe,
+	.remove = max34440_remove,
+	.id_table = max34440_id,
+};
+
+static int __init max34440_init(void)
+{
+	return i2c_add_driver(&max34440_driver);
+}
+
+static void __exit max34440_exit(void)
+{
+	i2c_del_driver(&max34440_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("PMBus driver for Maxim MAX34440/MAX34441");
+MODULE_LICENSE("GPL");
+module_init(max34440_init);
+module_exit(max34440_exit);
diff --git a/drivers/hwmon/pmbus/max8688.c b/drivers/hwmon/pmbus/max8688.c
new file mode 100644
index 0000000..7fb93f4
--- /dev/null
+++ b/drivers/hwmon/pmbus/max8688.c
@@ -0,0 +1,158 @@
+/*
+ * Hardware monitoring driver for Maxim MAX8688
+ *
+ * Copyright (c) 2011 Ericsson AB.
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
+#define MAX8688_MFG_STATUS		0xd8
+
+#define MAX8688_STATUS_OC_FAULT		(1 << 4)
+#define MAX8688_STATUS_OV_FAULT		(1 << 5)
+#define MAX8688_STATUS_OV_WARNING	(1 << 8)
+#define MAX8688_STATUS_UV_FAULT		(1 << 9)
+#define MAX8688_STATUS_UV_WARNING	(1 << 10)
+#define MAX8688_STATUS_UC_FAULT		(1 << 11)
+#define MAX8688_STATUS_OC_WARNING	(1 << 12)
+#define MAX8688_STATUS_OT_FAULT		(1 << 13)
+#define MAX8688_STATUS_OT_WARNING	(1 << 14)
+
+static int max8688_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int ret = 0;
+	int mfg_status;
+
+	if (page)
+		return -EINVAL;
+
+	switch (reg) {
+	case PMBUS_STATUS_VOUT:
+		mfg_status = pmbus_read_word_data(client, 0,
+						  MAX8688_MFG_STATUS);
+		if (mfg_status < 0)
+			return mfg_status;
+		if (mfg_status & MAX8688_STATUS_UV_WARNING)
+			ret |= PB_VOLTAGE_UV_WARNING;
+		if (mfg_status & MAX8688_STATUS_UV_FAULT)
+			ret |= PB_VOLTAGE_UV_FAULT;
+		if (mfg_status & MAX8688_STATUS_OV_WARNING)
+			ret |= PB_VOLTAGE_OV_WARNING;
+		if (mfg_status & MAX8688_STATUS_OV_FAULT)
+			ret |= PB_VOLTAGE_OV_FAULT;
+		break;
+	case PMBUS_STATUS_IOUT:
+		mfg_status = pmbus_read_word_data(client, 0,
+						  MAX8688_MFG_STATUS);
+		if (mfg_status < 0)
+			return mfg_status;
+		if (mfg_status & MAX8688_STATUS_UC_FAULT)
+			ret |= PB_IOUT_UC_FAULT;
+		if (mfg_status & MAX8688_STATUS_OC_WARNING)
+			ret |= PB_IOUT_OC_WARNING;
+		if (mfg_status & MAX8688_STATUS_OC_FAULT)
+			ret |= PB_IOUT_OC_FAULT;
+		break;
+	case PMBUS_STATUS_TEMPERATURE:
+		mfg_status = pmbus_read_word_data(client, 0,
+						  MAX8688_MFG_STATUS);
+		if (mfg_status < 0)
+			return mfg_status;
+		if (mfg_status & MAX8688_STATUS_OT_WARNING)
+			ret |= PB_TEMP_OT_WARNING;
+		if (mfg_status & MAX8688_STATUS_OT_FAULT)
+			ret |= PB_TEMP_OT_FAULT;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
+static struct pmbus_driver_info max8688_info = {
+	.pages = 1,
+	.direct[PSC_VOLTAGE_IN] = true,
+	.direct[PSC_VOLTAGE_OUT] = true,
+	.direct[PSC_TEMPERATURE] = true,
+	.direct[PSC_CURRENT_OUT] = true,
+	.m[PSC_VOLTAGE_IN] = 19995,
+	.b[PSC_VOLTAGE_IN] = 0,
+	.R[PSC_VOLTAGE_IN] = -1,
+	.m[PSC_VOLTAGE_OUT] = 19995,
+	.b[PSC_VOLTAGE_OUT] = 0,
+	.R[PSC_VOLTAGE_OUT] = -1,
+	.m[PSC_CURRENT_OUT] = 23109,
+	.b[PSC_CURRENT_OUT] = 0,
+	.R[PSC_CURRENT_OUT] = -2,
+	.m[PSC_TEMPERATURE] = -7612,
+	.b[PSC_TEMPERATURE] = 335,
+	.R[PSC_TEMPERATURE] = -3,
+	.func[0] = PMBUS_HAVE_VOUT | PMBUS_HAVE_IOUT | PMBUS_HAVE_TEMP
+		| PMBUS_HAVE_STATUS_VOUT | PMBUS_HAVE_STATUS_IOUT
+		| PMBUS_HAVE_STATUS_TEMP,
+	.read_byte_data = max8688_read_byte_data,
+};
+
+static int max8688_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	return pmbus_do_probe(client, id, &max8688_info);
+}
+
+static int max8688_remove(struct i2c_client *client)
+{
+	return pmbus_do_remove(client);
+}
+
+static const struct i2c_device_id max8688_id[] = {
+	{"max8688", 0},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(i2c, max8688_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver max8688_driver = {
+	.driver = {
+		   .name = "max8688",
+		   },
+	.probe = max8688_probe,
+	.remove = max8688_remove,
+	.id_table = max8688_id,
+};
+
+static int __init max8688_init(void)
+{
+	return i2c_add_driver(&max8688_driver);
+}
+
+static void __exit max8688_exit(void)
+{
+	i2c_del_driver(&max8688_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("PMBus driver for Maxim MAX8688");
+MODULE_LICENSE("GPL");
+module_init(max8688_init);
+module_exit(max8688_exit);
diff --git a/drivers/hwmon/pmbus/pmbus.c b/drivers/hwmon/pmbus/pmbus.c
new file mode 100644
index 0000000..9b1f0c3
--- /dev/null
+++ b/drivers/hwmon/pmbus/pmbus.c
@@ -0,0 +1,210 @@
+/*
+ * Hardware monitoring driver for PMBus devices
+ *
+ * Copyright (c) 2010, 2011 Ericsson AB.
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
+#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/i2c.h>
+#include "pmbus.h"
+
+/*
+ * Find sensor groups and status registers on each page.
+ */
+static void pmbus_find_sensor_groups(struct i2c_client *client,
+				     struct pmbus_driver_info *info)
+{
+	int page;
+
+	/* Sensors detected on page 0 only */
+	if (pmbus_check_word_register(client, 0, PMBUS_READ_VIN))
+		info->func[0] |= PMBUS_HAVE_VIN;
+	if (pmbus_check_word_register(client, 0, PMBUS_READ_VCAP))
+		info->func[0] |= PMBUS_HAVE_VCAP;
+	if (pmbus_check_word_register(client, 0, PMBUS_READ_IIN))
+		info->func[0] |= PMBUS_HAVE_IIN;
+	if (pmbus_check_word_register(client, 0, PMBUS_READ_PIN))
+		info->func[0] |= PMBUS_HAVE_PIN;
+	if (info->func[0]
+	    && pmbus_check_byte_register(client, 0, PMBUS_STATUS_INPUT))
+		info->func[0] |= PMBUS_HAVE_STATUS_INPUT;
+	if (pmbus_check_byte_register(client, 0, PMBUS_FAN_CONFIG_12) &&
+	    pmbus_check_word_register(client, 0, PMBUS_READ_FAN_SPEED_1)) {
+		info->func[0] |= PMBUS_HAVE_FAN12;
+		if (pmbus_check_byte_register(client, 0, PMBUS_STATUS_FAN_12))
+			info->func[0] |= PMBUS_HAVE_STATUS_FAN12;
+	}
+	if (pmbus_check_byte_register(client, 0, PMBUS_FAN_CONFIG_34) &&
+	    pmbus_check_word_register(client, 0, PMBUS_READ_FAN_SPEED_3)) {
+		info->func[0] |= PMBUS_HAVE_FAN34;
+		if (pmbus_check_byte_register(client, 0, PMBUS_STATUS_FAN_34))
+			info->func[0] |= PMBUS_HAVE_STATUS_FAN34;
+	}
+	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_1))
+		info->func[0] |= PMBUS_HAVE_TEMP;
+	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_2))
+		info->func[0] |= PMBUS_HAVE_TEMP2;
+	if (pmbus_check_word_register(client, 0, PMBUS_READ_TEMPERATURE_3))
+		info->func[0] |= PMBUS_HAVE_TEMP3;
+	if (info->func[0] & (PMBUS_HAVE_TEMP | PMBUS_HAVE_TEMP2
+			     | PMBUS_HAVE_TEMP3)
+	    && pmbus_check_byte_register(client, 0,
+					 PMBUS_STATUS_TEMPERATURE))
+			info->func[0] |= PMBUS_HAVE_STATUS_TEMP;
+
+	/* Sensors detected on all pages */
+	for (page = 0; page < info->pages; page++) {
+		if (pmbus_check_word_register(client, page, PMBUS_READ_VOUT)) {
+			info->func[page] |= PMBUS_HAVE_VOUT;
+			if (pmbus_check_byte_register(client, page,
+						      PMBUS_STATUS_VOUT))
+				info->func[page] |= PMBUS_HAVE_STATUS_VOUT;
+		}
+		if (pmbus_check_word_register(client, page, PMBUS_READ_IOUT)) {
+			info->func[page] |= PMBUS_HAVE_IOUT;
+			if (pmbus_check_byte_register(client, 0,
+						      PMBUS_STATUS_IOUT))
+				info->func[page] |= PMBUS_HAVE_STATUS_IOUT;
+		}
+		if (pmbus_check_word_register(client, page, PMBUS_READ_POUT))
+			info->func[page] |= PMBUS_HAVE_POUT;
+	}
+}
+
+/*
+ * Identify chip parameters.
+ */
+static int pmbus_identify(struct i2c_client *client,
+			  struct pmbus_driver_info *info)
+{
+	if (!info->pages) {
+		/*
+		 * Check if the PAGE command is supported. If it is,
+		 * keep setting the page number until it fails or until the
+		 * maximum number of pages has been reached. Assume that
+		 * this is the number of pages supported by the chip.
+		 */
+		if (pmbus_check_byte_register(client, 0, PMBUS_PAGE)) {
+			int page;
+
+			for (page = 1; page < PMBUS_PAGES; page++) {
+				if (pmbus_set_page(client, page) < 0)
+					break;
+			}
+			pmbus_set_page(client, 0);
+			info->pages = page;
+		} else {
+			info->pages = 1;
+		}
+	}
+
+	/*
+	 * We should check if the COEFFICIENTS register is supported.
+	 * If it is, and the chip is configured for direct mode, we can read
+	 * the coefficients from the chip, one set per group of sensor
+	 * registers.
+	 *
+	 * To do this, we will need access to a chip which actually supports the
+	 * COEFFICIENTS command, since the command is too complex to implement
+	 * without testing it.
+	 */
+
+	/* Try to find sensor groups  */
+	pmbus_find_sensor_groups(client, info);
+
+	return 0;
+}
+
+static int pmbus_probe(struct i2c_client *client,
+		       const struct i2c_device_id *id)
+{
+	struct pmbus_driver_info *info;
+	int ret;
+
+	info = kzalloc(sizeof(struct pmbus_driver_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	info->pages = id->driver_data;
+	info->identify = pmbus_identify;
+
+	ret = pmbus_do_probe(client, id, info);
+	if (ret < 0)
+		goto out;
+	return 0;
+
+out:
+	kfree(info);
+	return ret;
+}
+
+static int pmbus_remove(struct i2c_client *client)
+{
+	int ret;
+	const struct pmbus_driver_info *info;
+
+	info = pmbus_get_driver_info(client);
+	ret = pmbus_do_remove(client);
+	kfree(info);
+	return ret;
+}
+
+/*
+ * Use driver_data to set the number of pages supported by the chip.
+ */
+static const struct i2c_device_id pmbus_id[] = {
+	{"bmr450", 1},
+	{"bmr451", 1},
+	{"bmr453", 1},
+	{"bmr454", 1},
+	{"ltc2978", 8},
+	{"pmbus", 0},
+	{}
+};
+
+MODULE_DEVICE_TABLE(i2c, pmbus_id);
+
+/* This is the driver that will be inserted */
+static struct i2c_driver pmbus_driver = {
+	.driver = {
+		   .name = "pmbus",
+		   },
+	.probe = pmbus_probe,
+	.remove = pmbus_remove,
+	.id_table = pmbus_id,
+};
+
+static int __init pmbus_init(void)
+{
+	return i2c_add_driver(&pmbus_driver);
+}
+
+static void __exit pmbus_exit(void)
+{
+	i2c_del_driver(&pmbus_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("Generic PMBus driver");
+MODULE_LICENSE("GPL");
+module_init(pmbus_init);
+module_exit(pmbus_exit);
diff --git a/drivers/hwmon/pmbus/pmbus.h b/drivers/hwmon/pmbus/pmbus.h
new file mode 100644
index 0000000..50647ab
--- /dev/null
+++ b/drivers/hwmon/pmbus/pmbus.h
@@ -0,0 +1,311 @@
+/*
+ * pmbus.h - Common defines and structures for PMBus devices
+ *
+ * Copyright (c) 2010, 2011 Ericsson AB.
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
+#ifndef PMBUS_H
+#define PMBUS_H
+
+/*
+ * Registers
+ */
+#define PMBUS_PAGE			0x00
+#define PMBUS_OPERATION			0x01
+#define PMBUS_ON_OFF_CONFIG		0x02
+#define PMBUS_CLEAR_FAULTS		0x03
+#define PMBUS_PHASE			0x04
+
+#define PMBUS_CAPABILITY		0x19
+#define PMBUS_QUERY			0x1A
+
+#define PMBUS_VOUT_MODE			0x20
+#define PMBUS_VOUT_COMMAND		0x21
+#define PMBUS_VOUT_TRIM			0x22
+#define PMBUS_VOUT_CAL_OFFSET		0x23
+#define PMBUS_VOUT_MAX			0x24
+#define PMBUS_VOUT_MARGIN_HIGH		0x25
+#define PMBUS_VOUT_MARGIN_LOW		0x26
+#define PMBUS_VOUT_TRANSITION_RATE	0x27
+#define PMBUS_VOUT_DROOP		0x28
+#define PMBUS_VOUT_SCALE_LOOP		0x29
+#define PMBUS_VOUT_SCALE_MONITOR	0x2A
+
+#define PMBUS_COEFFICIENTS		0x30
+#define PMBUS_POUT_MAX			0x31
+
+#define PMBUS_FAN_CONFIG_12		0x3A
+#define PMBUS_FAN_COMMAND_1		0x3B
+#define PMBUS_FAN_COMMAND_2		0x3C
+#define PMBUS_FAN_CONFIG_34		0x3D
+#define PMBUS_FAN_COMMAND_3		0x3E
+#define PMBUS_FAN_COMMAND_4		0x3F
+
+#define PMBUS_VOUT_OV_FAULT_LIMIT	0x40
+#define PMBUS_VOUT_OV_FAULT_RESPONSE	0x41
+#define PMBUS_VOUT_OV_WARN_LIMIT	0x42
+#define PMBUS_VOUT_UV_WARN_LIMIT	0x43
+#define PMBUS_VOUT_UV_FAULT_LIMIT	0x44
+#define PMBUS_VOUT_UV_FAULT_RESPONSE	0x45
+#define PMBUS_IOUT_OC_FAULT_LIMIT	0x46
+#define PMBUS_IOUT_OC_FAULT_RESPONSE	0x47
+#define PMBUS_IOUT_OC_LV_FAULT_LIMIT	0x48
+#define PMBUS_IOUT_OC_LV_FAULT_RESPONSE	0x49
+#define PMBUS_IOUT_OC_WARN_LIMIT	0x4A
+#define PMBUS_IOUT_UC_FAULT_LIMIT	0x4B
+#define PMBUS_IOUT_UC_FAULT_RESPONSE	0x4C
+
+#define PMBUS_OT_FAULT_LIMIT		0x4F
+#define PMBUS_OT_FAULT_RESPONSE		0x50
+#define PMBUS_OT_WARN_LIMIT		0x51
+#define PMBUS_UT_WARN_LIMIT		0x52
+#define PMBUS_UT_FAULT_LIMIT		0x53
+#define PMBUS_UT_FAULT_RESPONSE		0x54
+#define PMBUS_VIN_OV_FAULT_LIMIT	0x55
+#define PMBUS_VIN_OV_FAULT_RESPONSE	0x56
+#define PMBUS_VIN_OV_WARN_LIMIT		0x57
+#define PMBUS_VIN_UV_WARN_LIMIT		0x58
+#define PMBUS_VIN_UV_FAULT_LIMIT	0x59
+
+#define PMBUS_IIN_OC_FAULT_LIMIT	0x5B
+#define PMBUS_IIN_OC_WARN_LIMIT		0x5D
+
+#define PMBUS_POUT_OP_FAULT_LIMIT	0x68
+#define PMBUS_POUT_OP_WARN_LIMIT	0x6A
+#define PMBUS_PIN_OP_WARN_LIMIT		0x6B
+
+#define PMBUS_STATUS_BYTE		0x78
+#define PMBUS_STATUS_WORD		0x79
+#define PMBUS_STATUS_VOUT		0x7A
+#define PMBUS_STATUS_IOUT		0x7B
+#define PMBUS_STATUS_INPUT		0x7C
+#define PMBUS_STATUS_TEMPERATURE	0x7D
+#define PMBUS_STATUS_CML		0x7E
+#define PMBUS_STATUS_OTHER		0x7F
+#define PMBUS_STATUS_MFR_SPECIFIC	0x80
+#define PMBUS_STATUS_FAN_12		0x81
+#define PMBUS_STATUS_FAN_34		0x82
+
+#define PMBUS_READ_VIN			0x88
+#define PMBUS_READ_IIN			0x89
+#define PMBUS_READ_VCAP			0x8A
+#define PMBUS_READ_VOUT			0x8B
+#define PMBUS_READ_IOUT			0x8C
+#define PMBUS_READ_TEMPERATURE_1	0x8D
+#define PMBUS_READ_TEMPERATURE_2	0x8E
+#define PMBUS_READ_TEMPERATURE_3	0x8F
+#define PMBUS_READ_FAN_SPEED_1		0x90
+#define PMBUS_READ_FAN_SPEED_2		0x91
+#define PMBUS_READ_FAN_SPEED_3		0x92
+#define PMBUS_READ_FAN_SPEED_4		0x93
+#define PMBUS_READ_DUTY_CYCLE		0x94
+#define PMBUS_READ_FREQUENCY		0x95
+#define PMBUS_READ_POUT			0x96
+#define PMBUS_READ_PIN			0x97
+
+#define PMBUS_REVISION			0x98
+#define PMBUS_MFR_ID			0x99
+#define PMBUS_MFR_MODEL			0x9A
+#define PMBUS_MFR_REVISION		0x9B
+#define PMBUS_MFR_LOCATION		0x9C
+#define PMBUS_MFR_DATE			0x9D
+#define PMBUS_MFR_SERIAL		0x9E
+
+/*
+ * CAPABILITY
+ */
+#define PB_CAPABILITY_SMBALERT		(1<<4)
+#define PB_CAPABILITY_ERROR_CHECK	(1<<7)
+
+/*
+ * VOUT_MODE
+ */
+#define PB_VOUT_MODE_MODE_MASK		0xe0
+#define PB_VOUT_MODE_PARAM_MASK		0x1f
+
+#define PB_VOUT_MODE_LINEAR		0x00
+#define PB_VOUT_MODE_VID		0x20
+#define PB_VOUT_MODE_DIRECT		0x40
+
+/*
+ * Fan configuration
+ */
+#define PB_FAN_2_PULSE_MASK		((1 << 0) | (1 << 1))
+#define PB_FAN_2_RPM			(1 << 2)
+#define PB_FAN_2_INSTALLED		(1 << 3)
+#define PB_FAN_1_PULSE_MASK		((1 << 4) | (1 << 5))
+#define PB_FAN_1_RPM			(1 << 6)
+#define PB_FAN_1_INSTALLED		(1 << 7)
+
+/*
+ * STATUS_BYTE, STATUS_WORD (lower)
+ */
+#define PB_STATUS_NONE_ABOVE		(1<<0)
+#define PB_STATUS_CML			(1<<1)
+#define PB_STATUS_TEMPERATURE		(1<<2)
+#define PB_STATUS_VIN_UV		(1<<3)
+#define PB_STATUS_IOUT_OC		(1<<4)
+#define PB_STATUS_VOUT_OV		(1<<5)
+#define PB_STATUS_OFF			(1<<6)
+#define PB_STATUS_BUSY			(1<<7)
+
+/*
+ * STATUS_WORD (upper)
+ */
+#define PB_STATUS_UNKNOWN		(1<<8)
+#define PB_STATUS_OTHER			(1<<9)
+#define PB_STATUS_FANS			(1<<10)
+#define PB_STATUS_POWER_GOOD_N		(1<<11)
+#define PB_STATUS_WORD_MFR		(1<<12)
+#define PB_STATUS_INPUT			(1<<13)
+#define PB_STATUS_IOUT_POUT		(1<<14)
+#define PB_STATUS_VOUT			(1<<15)
+
+/*
+ * STATUS_IOUT
+ */
+#define PB_POUT_OP_WARNING		(1<<0)
+#define PB_POUT_OP_FAULT		(1<<1)
+#define PB_POWER_LIMITING		(1<<2)
+#define PB_CURRENT_SHARE_FAULT		(1<<3)
+#define PB_IOUT_UC_FAULT		(1<<4)
+#define PB_IOUT_OC_WARNING		(1<<5)
+#define PB_IOUT_OC_LV_FAULT		(1<<6)
+#define PB_IOUT_OC_FAULT		(1<<7)
+
+/*
+ * STATUS_VOUT, STATUS_INPUT
+ */
+#define PB_VOLTAGE_UV_FAULT		(1<<4)
+#define PB_VOLTAGE_UV_WARNING		(1<<5)
+#define PB_VOLTAGE_OV_WARNING		(1<<6)
+#define PB_VOLTAGE_OV_FAULT		(1<<7)
+
+/*
+ * STATUS_INPUT
+ */
+#define PB_PIN_OP_WARNING		(1<<0)
+#define PB_IIN_OC_WARNING		(1<<1)
+#define PB_IIN_OC_FAULT			(1<<2)
+
+/*
+ * STATUS_TEMPERATURE
+ */
+#define PB_TEMP_UT_FAULT		(1<<4)
+#define PB_TEMP_UT_WARNING		(1<<5)
+#define PB_TEMP_OT_WARNING		(1<<6)
+#define PB_TEMP_OT_FAULT		(1<<7)
+
+/*
+ * STATUS_FAN
+ */
+#define PB_FAN_AIRFLOW_WARNING		(1<<0)
+#define PB_FAN_AIRFLOW_FAULT		(1<<1)
+#define PB_FAN_FAN2_SPEED_OVERRIDE	(1<<2)
+#define PB_FAN_FAN1_SPEED_OVERRIDE	(1<<3)
+#define PB_FAN_FAN2_WARNING		(1<<4)
+#define PB_FAN_FAN1_WARNING		(1<<5)
+#define PB_FAN_FAN2_FAULT		(1<<6)
+#define PB_FAN_FAN1_FAULT		(1<<7)
+
+/*
+ * CML_FAULT_STATUS
+ */
+#define PB_CML_FAULT_OTHER_MEM_LOGIC	(1<<0)
+#define PB_CML_FAULT_OTHER_COMM		(1<<1)
+#define PB_CML_FAULT_PROCESSOR		(1<<3)
+#define PB_CML_FAULT_MEMORY		(1<<4)
+#define PB_CML_FAULT_PACKET_ERROR	(1<<5)
+#define PB_CML_FAULT_INVALID_DATA	(1<<6)
+#define PB_CML_FAULT_INVALID_COMMAND	(1<<7)
+
+enum pmbus_sensor_classes {
+	PSC_VOLTAGE_IN = 0,
+	PSC_VOLTAGE_OUT,
+	PSC_CURRENT_IN,
+	PSC_CURRENT_OUT,
+	PSC_POWER,
+	PSC_TEMPERATURE,
+	PSC_FAN,
+	PSC_NUM_CLASSES		/* Number of power sensor classes */
+};
+
+#define PMBUS_PAGES	32	/* Per PMBus specification */
+
+/* Functionality bit mask */
+#define PMBUS_HAVE_VIN		(1 << 0)
+#define PMBUS_HAVE_VCAP		(1 << 1)
+#define PMBUS_HAVE_VOUT		(1 << 2)
+#define PMBUS_HAVE_IIN		(1 << 3)
+#define PMBUS_HAVE_IOUT		(1 << 4)
+#define PMBUS_HAVE_PIN		(1 << 5)
+#define PMBUS_HAVE_POUT		(1 << 6)
+#define PMBUS_HAVE_FAN12	(1 << 7)
+#define PMBUS_HAVE_FAN34	(1 << 8)
+#define PMBUS_HAVE_TEMP		(1 << 9)
+#define PMBUS_HAVE_TEMP2	(1 << 10)
+#define PMBUS_HAVE_TEMP3	(1 << 11)
+#define PMBUS_HAVE_STATUS_VOUT	(1 << 12)
+#define PMBUS_HAVE_STATUS_IOUT	(1 << 13)
+#define PMBUS_HAVE_STATUS_INPUT	(1 << 14)
+#define PMBUS_HAVE_STATUS_TEMP	(1 << 15)
+#define PMBUS_HAVE_STATUS_FAN12	(1 << 16)
+#define PMBUS_HAVE_STATUS_FAN34	(1 << 17)
+
+struct pmbus_driver_info {
+	int pages;		/* Total number of pages */
+	bool direct[PSC_NUM_CLASSES];
+				/* true if device uses direct data format
+				   for the given sensor class */
+	/*
+	 * Support one set of coefficients for each sensor type
+	 * Used for chips providing data in direct mode.
+	 */
+	int m[PSC_NUM_CLASSES];	/* mantissa for direct data format */
+	int b[PSC_NUM_CLASSES];	/* offset */
+	int R[PSC_NUM_CLASSES];	/* exponent */
+
+	u32 func[PMBUS_PAGES];	/* Functionality, per page */
+	/*
+	 * The following functions map manufacturing specific register values
+	 * to PMBus standard register values. Specify only if mapping is
+	 * necessary.
+	 */
+	int (*read_byte_data)(struct i2c_client *client, int page, int reg);
+	/*
+	 * The identify function determines supported PMBus functionality.
+	 * This function is only necessary if a chip driver supports multiple
+	 * chips, and the chip functionality is not pre-determined.
+	 */
+	int (*identify)(struct i2c_client *client,
+			struct pmbus_driver_info *info);
+};
+
+/* Function declarations */
+
+int pmbus_set_page(struct i2c_client *client, u8 page);
+int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 reg);
+void pmbus_clear_faults(struct i2c_client *client);
+bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg);
+bool pmbus_check_word_register(struct i2c_client *client, int page, int reg);
+int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
+		   struct pmbus_driver_info *info);
+int pmbus_do_remove(struct i2c_client *client);
+const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client
+						      *client);
+
+#endif /* PMBUS_H */
diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
new file mode 100644
index 0000000..8e31a8e
--- /dev/null
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -0,0 +1,1567 @@
+/*
+ * Hardware monitoring driver for PMBus devices
+ *
+ * Copyright (c) 2010, 2011 Ericsson AB.
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
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/hwmon.h>
+#include <linux/hwmon-sysfs.h>
+#include <linux/delay.h>
+#include <linux/i2c/pmbus.h>
+#include "pmbus.h"
+
+/*
+ * Constants needed to determine number of sensors, booleans, and labels.
+ */
+#define PMBUS_MAX_INPUT_SENSORS		11	/* 6*volt, 3*curr, 2*power */
+#define PMBUS_VOUT_SENSORS_PER_PAGE	5	/* input, min, max, lcrit,
+						   crit */
+#define PMBUS_IOUT_SENSORS_PER_PAGE	4	/* input, min, max, crit */
+#define PMBUS_POUT_SENSORS_PER_PAGE	4	/* input, cap, max, crit */
+#define PMBUS_MAX_SENSORS_PER_FAN	1	/* input */
+#define PMBUS_MAX_SENSORS_PER_TEMP	5	/* input, min, max, lcrit,
+						   crit */
+
+#define PMBUS_MAX_INPUT_BOOLEANS	7	/* v: min_alarm, max_alarm,
+						   lcrit_alarm, crit_alarm;
+						   c: alarm, crit_alarm;
+						   p: crit_alarm */
+#define PMBUS_VOUT_BOOLEANS_PER_PAGE	4	/* min_alarm, max_alarm,
+						   lcrit_alarm, crit_alarm */
+#define PMBUS_IOUT_BOOLEANS_PER_PAGE	3	/* alarm, lcrit_alarm,
+						   crit_alarm */
+#define PMBUS_POUT_BOOLEANS_PER_PAGE	2	/* alarm, crit_alarm */
+#define PMBUS_MAX_BOOLEANS_PER_FAN	2	/* alarm, fault */
+#define PMBUS_MAX_BOOLEANS_PER_TEMP	4	/* min_alarm, max_alarm,
+						   lcrit_alarm, crit_alarm */
+
+#define PMBUS_MAX_INPUT_LABELS		4	/* vin, vcap, iin, pin */
+
+/*
+ * status, status_vout, status_iout, status_fans, status_fan34, and status_temp
+ * are paged. status_input is unpaged.
+ */
+#define PB_NUM_STATUS_REG	(PMBUS_PAGES * 6 + 1)
+
+/*
+ * Index into status register array, per status register group
+ */
+#define PB_STATUS_BASE		0
+#define PB_STATUS_VOUT_BASE	(PB_STATUS_BASE + PMBUS_PAGES)
+#define PB_STATUS_IOUT_BASE	(PB_STATUS_VOUT_BASE + PMBUS_PAGES)
+#define PB_STATUS_FAN_BASE	(PB_STATUS_IOUT_BASE + PMBUS_PAGES)
+#define PB_STATUS_FAN34_BASE	(PB_STATUS_FAN_BASE + PMBUS_PAGES)
+#define PB_STATUS_INPUT_BASE	(PB_STATUS_FAN34_BASE + PMBUS_PAGES)
+#define PB_STATUS_TEMP_BASE	(PB_STATUS_INPUT_BASE + 1)
+
+struct pmbus_sensor {
+	char name[I2C_NAME_SIZE];	/* sysfs sensor name */
+	struct sensor_device_attribute attribute;
+	u8 page;		/* page number */
+	u8 reg;			/* register */
+	enum pmbus_sensor_classes class;	/* sensor class */
+	bool update;		/* runtime sensor update needed */
+	int data;		/* Sensor data.
+				   Negative if there was a read error */
+};
+
+struct pmbus_boolean {
+	char name[I2C_NAME_SIZE];	/* sysfs boolean name */
+	struct sensor_device_attribute attribute;
+};
+
+struct pmbus_label {
+	char name[I2C_NAME_SIZE];	/* sysfs label name */
+	struct sensor_device_attribute attribute;
+	char label[I2C_NAME_SIZE];	/* label */
+};
+
+struct pmbus_data {
+	struct device *hwmon_dev;
+
+	u32 flags;		/* from platform data */
+
+	int exponent;		/* linear mode: exponent for output voltages */
+
+	const struct pmbus_driver_info *info;
+
+	int max_attributes;
+	int num_attributes;
+	struct attribute **attributes;
+	struct attribute_group group;
+
+	/*
+	 * Sensors cover both sensor and limit registers.
+	 */
+	int max_sensors;
+	int num_sensors;
+	struct pmbus_sensor *sensors;
+	/*
+	 * Booleans are used for alarms.
+	 * Values are determined from status registers.
+	 */
+	int max_booleans;
+	int num_booleans;
+	struct pmbus_boolean *booleans;
+	/*
+	 * Labels are used to map generic names (e.g., "in1")
+	 * to PMBus specific names (e.g., "vin" or "vout1").
+	 */
+	int max_labels;
+	int num_labels;
+	struct pmbus_label *labels;
+
+	struct mutex update_lock;
+	bool valid;
+	unsigned long last_updated;	/* in jiffies */
+
+	/*
+	 * A single status register covers multiple attributes,
+	 * so we keep them all together.
+	 */
+	u8 status[PB_NUM_STATUS_REG];
+
+	u8 currpage;
+};
+
+int pmbus_set_page(struct i2c_client *client, u8 page)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	int rv = 0;
+	int newpage;
+
+	if (page != data->currpage) {
+		rv = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
+		newpage = i2c_smbus_read_byte_data(client, PMBUS_PAGE);
+		if (newpage != page)
+			rv = -EINVAL;
+		else
+			data->currpage = page;
+	}
+	return rv;
+}
+EXPORT_SYMBOL_GPL(pmbus_set_page);
+
+static int pmbus_write_byte(struct i2c_client *client, u8 page, u8 value)
+{
+	int rv;
+
+	rv = pmbus_set_page(client, page);
+	if (rv < 0)
+		return rv;
+
+	return i2c_smbus_write_byte(client, value);
+}
+
+static int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg,
+				 u16 word)
+{
+	int rv;
+
+	rv = pmbus_set_page(client, page);
+	if (rv < 0)
+		return rv;
+
+	return i2c_smbus_write_word_data(client, reg, word);
+}
+
+int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 reg)
+{
+	int rv;
+
+	rv = pmbus_set_page(client, page);
+	if (rv < 0)
+		return rv;
+
+	return i2c_smbus_read_word_data(client, reg);
+}
+EXPORT_SYMBOL_GPL(pmbus_read_word_data);
+
+static int pmbus_read_byte_data(struct i2c_client *client, u8 page, u8 reg)
+{
+	int rv;
+
+	rv = pmbus_set_page(client, page);
+	if (rv < 0)
+		return rv;
+
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+static void pmbus_clear_fault_page(struct i2c_client *client, int page)
+{
+	pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
+}
+
+void pmbus_clear_faults(struct i2c_client *client)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	int i;
+
+	for (i = 0; i < data->info->pages; i++)
+		pmbus_clear_fault_page(client, i);
+}
+EXPORT_SYMBOL_GPL(pmbus_clear_faults);
+
+static int pmbus_check_status_cml(struct i2c_client *client, int page)
+{
+	int status, status2;
+
+	status = pmbus_read_byte_data(client, page, PMBUS_STATUS_BYTE);
+	if (status < 0 || (status & PB_STATUS_CML)) {
+		status2 = pmbus_read_byte_data(client, page, PMBUS_STATUS_CML);
+		if (status2 < 0 || (status2 & PB_CML_FAULT_INVALID_COMMAND))
+			return -EINVAL;
+	}
+	return 0;
+}
+
+bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg)
+{
+	int rv;
+	struct pmbus_data *data = i2c_get_clientdata(client);
+
+	rv = pmbus_read_byte_data(client, page, reg);
+	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
+		rv = pmbus_check_status_cml(client, page);
+	pmbus_clear_fault_page(client, page);
+	return rv >= 0;
+}
+EXPORT_SYMBOL_GPL(pmbus_check_byte_register);
+
+bool pmbus_check_word_register(struct i2c_client *client, int page, int reg)
+{
+	int rv;
+	struct pmbus_data *data = i2c_get_clientdata(client);
+
+	rv = pmbus_read_word_data(client, page, reg);
+	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
+		rv = pmbus_check_status_cml(client, page);
+	pmbus_clear_fault_page(client, page);
+	return rv >= 0;
+}
+EXPORT_SYMBOL_GPL(pmbus_check_word_register);
+
+const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client *client)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+
+	return data->info;
+}
+EXPORT_SYMBOL_GPL(pmbus_get_driver_info);
+
+/*
+ * _pmbus_read_byte_data() is similar to pmbus_read_byte_data(), but checks if
+ * a device specific mapping funcion exists and calls it if necessary.
+ */
+static int _pmbus_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	const struct pmbus_driver_info *info = data->info;
+	int status;
+
+	if (info->read_byte_data) {
+		status = info->read_byte_data(client, page, reg);
+		if (status != -ENODATA)
+			return status;
+	}
+	return pmbus_read_byte_data(client, page, reg);
+}
+
+static struct pmbus_data *pmbus_update_device(struct device *dev)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	const struct pmbus_driver_info *info = data->info;
+
+	mutex_lock(&data->update_lock);
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
+		int i;
+
+		for (i = 0; i < info->pages; i++)
+			data->status[PB_STATUS_BASE + i]
+			    = pmbus_read_byte_data(client, i,
+						   PMBUS_STATUS_BYTE);
+		for (i = 0; i < info->pages; i++) {
+			if (!(info->func[i] & PMBUS_HAVE_STATUS_VOUT))
+				continue;
+			data->status[PB_STATUS_VOUT_BASE + i]
+			  = _pmbus_read_byte_data(client, i, PMBUS_STATUS_VOUT);
+		}
+		for (i = 0; i < info->pages; i++) {
+			if (!(info->func[i] & PMBUS_HAVE_STATUS_IOUT))
+				continue;
+			data->status[PB_STATUS_IOUT_BASE + i]
+			  = _pmbus_read_byte_data(client, i, PMBUS_STATUS_IOUT);
+		}
+		for (i = 0; i < info->pages; i++) {
+			if (!(info->func[i] & PMBUS_HAVE_STATUS_TEMP))
+				continue;
+			data->status[PB_STATUS_TEMP_BASE + i]
+			  = _pmbus_read_byte_data(client, i,
+						  PMBUS_STATUS_TEMPERATURE);
+		}
+		for (i = 0; i < info->pages; i++) {
+			if (!(info->func[i] & PMBUS_HAVE_STATUS_FAN12))
+				continue;
+			data->status[PB_STATUS_FAN_BASE + i]
+			  = _pmbus_read_byte_data(client, i,
+						  PMBUS_STATUS_FAN_12);
+		}
+
+		for (i = 0; i < info->pages; i++) {
+			if (!(info->func[i] & PMBUS_HAVE_STATUS_FAN34))
+				continue;
+			data->status[PB_STATUS_FAN34_BASE + i]
+			  = _pmbus_read_byte_data(client, i,
+						  PMBUS_STATUS_FAN_34);
+		}
+
+		if (info->func[0] & PMBUS_HAVE_STATUS_INPUT)
+			data->status[PB_STATUS_INPUT_BASE]
+			  = _pmbus_read_byte_data(client, 0,
+						  PMBUS_STATUS_INPUT);
+
+		for (i = 0; i < data->num_sensors; i++) {
+			struct pmbus_sensor *sensor = &data->sensors[i];
+
+			if (!data->valid || sensor->update)
+				sensor->data
+				    = pmbus_read_word_data(client, sensor->page,
+							   sensor->reg);
+		}
+		pmbus_clear_faults(client);
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+	mutex_unlock(&data->update_lock);
+	return data;
+}
+
+/*
+ * Convert linear sensor values to milli- or micro-units
+ * depending on sensor type.
+ */
+static long pmbus_reg2data_linear(struct pmbus_data *data,
+				  struct pmbus_sensor *sensor)
+{
+	s16 exponent;
+	s32 mantissa;
+	long val;
+
+	if (sensor->class = PSC_VOLTAGE_OUT) {	/* LINEAR16 */
+		exponent = data->exponent;
+		mantissa = (u16) sensor->data;
+	} else {				/* LINEAR11 */
+		exponent = (sensor->data >> 11) & 0x001f;
+		mantissa = sensor->data & 0x07ff;
+
+		if (exponent > 0x0f)
+			exponent |= 0xffe0;	/* sign extend exponent */
+		if (mantissa > 0x03ff)
+			mantissa |= 0xfffff800;	/* sign extend mantissa */
+	}
+
+	val = mantissa;
+
+	/* scale result to milli-units for all sensors except fans */
+	if (sensor->class != PSC_FAN)
+		val = val * 1000L;
+
+	/* scale result to micro-units for power sensors */
+	if (sensor->class = PSC_POWER)
+		val = val * 1000L;
+
+	if (exponent >= 0)
+		val <<= exponent;
+	else
+		val >>= -exponent;
+
+	return val;
+}
+
+/*
+ * Convert direct sensor values to milli- or micro-units
+ * depending on sensor type.
+ */
+static long pmbus_reg2data_direct(struct pmbus_data *data,
+				  struct pmbus_sensor *sensor)
+{
+	long val = (s16) sensor->data;
+	long m, b, R;
+
+	m = data->info->m[sensor->class];
+	b = data->info->b[sensor->class];
+	R = data->info->R[sensor->class];
+
+	if (m = 0)
+		return 0;
+
+	/* X = 1/m * (Y * 10^-R - b) */
+	R = -R;
+	/* scale result to milli-units for everything but fans */
+	if (sensor->class != PSC_FAN) {
+		R += 3;
+		b *= 1000;
+	}
+
+	/* scale result to micro-units for power sensors */
+	if (sensor->class = PSC_POWER) {
+		R += 3;
+		b *= 1000;
+	}
+
+	while (R > 0) {
+		val *= 10;
+		R--;
+	}
+	while (R < 0) {
+		val = DIV_ROUND_CLOSEST(val, 10);
+		R++;
+	}
+
+	return (val - b) / m;
+}
+
+static long pmbus_reg2data(struct pmbus_data *data, struct pmbus_sensor *sensor)
+{
+	long val;
+
+	if (data->info->direct[sensor->class])
+		val = pmbus_reg2data_direct(data, sensor);
+	else
+		val = pmbus_reg2data_linear(data, sensor);
+
+	return val;
+}
+
+#define MAX_MANTISSA	(1023 * 1000)
+#define MIN_MANTISSA	(511 * 1000)
+
+static u16 pmbus_data2reg_linear(struct pmbus_data *data,
+				 enum pmbus_sensor_classes class, long val)
+{
+	s16 exponent = 0, mantissa;
+	bool negative = false;
+
+	/* simple case */
+	if (val = 0)
+		return 0;
+
+	if (class = PSC_VOLTAGE_OUT) {
+		/* LINEAR16 does not support negative voltages */
+		if (val < 0)
+			return 0;
+
+		/*
+		 * For a static exponents, we don't have a choice
+		 * but to adjust the value to it.
+		 */
+		if (data->exponent < 0)
+			val <<= -data->exponent;
+		else
+			val >>= data->exponent;
+		val = DIV_ROUND_CLOSEST(val, 1000);
+		return val & 0xffff;
+	}
+
+	if (val < 0) {
+		negative = true;
+		val = -val;
+	}
+
+	/* Power is in uW. Convert to mW before converting. */
+	if (class = PSC_POWER)
+		val = DIV_ROUND_CLOSEST(val, 1000L);
+
+	/*
+	 * For simplicity, convert fan data to milli-units
+	 * before calculating the exponent.
+	 */
+	if (class = PSC_FAN)
+		val = val * 1000;
+
+	/* Reduce large mantissa until it fits into 10 bit */
+	while (val >= MAX_MANTISSA && exponent < 15) {
+		exponent++;
+		val >>= 1;
+	}
+	/* Increase small mantissa to improve precision */
+	while (val < MIN_MANTISSA && exponent > -15) {
+		exponent--;
+		val <<= 1;
+	}
+
+	/* Convert mantissa from milli-units to units */
+	mantissa = DIV_ROUND_CLOSEST(val, 1000);
+
+	/* Ensure that resulting number is within range */
+	if (mantissa > 0x3ff)
+		mantissa = 0x3ff;
+
+	/* restore sign */
+	if (negative)
+		mantissa = -mantissa;
+
+	/* Convert to 5 bit exponent, 11 bit mantissa */
+	return (mantissa & 0x7ff) | ((exponent << 11) & 0xf800);
+}
+
+static u16 pmbus_data2reg_direct(struct pmbus_data *data,
+				 enum pmbus_sensor_classes class, long val)
+{
+	long m, b, R;
+
+	m = data->info->m[class];
+	b = data->info->b[class];
+	R = data->info->R[class];
+
+	/* Power is in uW. Adjust R and b. */
+	if (class = PSC_POWER) {
+		R -= 3;
+		b *= 1000;
+	}
+
+	/* Calculate Y = (m * X + b) * 10^R */
+	if (class != PSC_FAN) {
+		R -= 3;		/* Adjust R and b for data in milli-units */
+		b *= 1000;
+	}
+	val = val * m + b;
+
+	while (R > 0) {
+		val *= 10;
+		R--;
+	}
+	while (R < 0) {
+		val = DIV_ROUND_CLOSEST(val, 10);
+		R++;
+	}
+
+	return val;
+}
+
+static u16 pmbus_data2reg(struct pmbus_data *data,
+			  enum pmbus_sensor_classes class, long val)
+{
+	u16 regval;
+
+	if (data->info->direct[class])
+		regval = pmbus_data2reg_direct(data, class, val);
+	else
+		regval = pmbus_data2reg_linear(data, class, val);
+
+	return regval;
+}
+
+/*
+ * Return boolean calculated from converted data.
+ * <index> defines a status register index and mask, and optionally
+ * two sensor indexes.
+ * The upper half-word references the two sensors,
+ * two sensor indices.
+ * The upper half-word references the two optional sensors,
+ * the lower half word references status register and mask.
+ * The function returns true if (status[reg] & mask) is true and,
+ * if specified, if v1 >= v2.
+ * To determine if an object exceeds upper limits, specify <v, limit>.
+ * To determine if an object exceeds lower limits, specify <limit, v>.
+ *
+ * For booleans created with pmbus_add_boolean_reg(), only the lower 16 bits of
+ * index are set. s1 and s2 (the sensor index values) are zero in this case.
+ * The function returns true if (status[reg] & mask) is true.
+ *
+ * If the boolean was created with pmbus_add_boolean_cmp(), a comparison against
+ * a specified limit has to be performed to determine the boolean result.
+ * In this case, the function returns true if v1 >= v2 (where v1 and v2 are
+ * sensor values referenced by sensor indices s1 and s2).
+ *
+ * To determine if an object exceeds upper limits, specify <s1,s2> = <v,limit>.
+ * To determine if an object exceeds lower limits, specify <s1,s2> = <limit,v>.
+ *
+ * If a negative value is stored in any of the referenced registers, this value
+ * reflects an error code which will be returned.
+ */
+static int pmbus_get_boolean(struct pmbus_data *data, int index, int *val)
+{
+	u8 s1 = (index >> 24) & 0xff;
+	u8 s2 = (index >> 16) & 0xff;
+	u8 reg = (index >> 8) & 0xff;
+	u8 mask = index & 0xff;
+	int status;
+	u8 regval;
+
+	status = data->status[reg];
+	if (status < 0)
+		return status;
+
+	regval = status & mask;
+	if (!s1 && !s2)
+		*val = !!regval;
+	else {
+		long v1, v2;
+		struct pmbus_sensor *sensor1, *sensor2;
+
+		sensor1 = &data->sensors[s1];
+		if (sensor1->data < 0)
+			return sensor1->data;
+		sensor2 = &data->sensors[s2];
+		if (sensor2->data < 0)
+			return sensor2->data;
+
+		v1 = pmbus_reg2data(data, sensor1);
+		v2 = pmbus_reg2data(data, sensor2);
+		*val = !!(regval && v1 >= v2);
+	}
+	return 0;
+}
+
+static ssize_t pmbus_show_boolean(struct device *dev,
+				  struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct pmbus_data *data = pmbus_update_device(dev);
+	int val;
+	int err;
+
+	err = pmbus_get_boolean(data, attr->index, &val);
+	if (err)
+		return err;
+	return snprintf(buf, PAGE_SIZE, "%d\n", val);
+}
+
+static ssize_t pmbus_show_sensor(struct device *dev,
+				 struct device_attribute *da, char *buf)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+	struct pmbus_data *data = pmbus_update_device(dev);
+	struct pmbus_sensor *sensor;
+
+	sensor = &data->sensors[attr->index];
+	if (sensor->data < 0)
+		return sensor->data;
+
+	return snprintf(buf, PAGE_SIZE, "%ld\n", pmbus_reg2data(data, sensor));
+}
+
+static ssize_t pmbus_set_sensor(struct device *dev,
+				struct device_attribute *devattr,
+				const char *buf, size_t count)
+{
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	struct pmbus_sensor *sensor = &data->sensors[attr->index];
+	ssize_t rv = count;
+	long val = 0;
+	int ret;
+	u16 regval;
+
+	if (strict_strtol(buf, 10, &val) < 0)
+		return -EINVAL;
+
+	mutex_lock(&data->update_lock);
+	regval = pmbus_data2reg(data, sensor->class, val);
+	ret = pmbus_write_word_data(client, sensor->page, sensor->reg, regval);
+	if (ret < 0)
+		rv = ret;
+	else
+		data->sensors[attr->index].data = regval;
+	mutex_unlock(&data->update_lock);
+	return rv;
+}
+
+static ssize_t pmbus_show_label(struct device *dev,
+				struct device_attribute *da, char *buf)
+{
+	struct i2c_client *client = to_i2c_client(dev);
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
+
+	return snprintf(buf, PAGE_SIZE, "%s\n",
+			data->labels[attr->index].label);
+}
+
+#define PMBUS_ADD_ATTR(data, _name, _idx, _mode, _type, _show, _set)	\
+do {									\
+	struct sensor_device_attribute *a				\
+	    = &data->_type##s[data->num_##_type##s].attribute;		\
+	BUG_ON(data->num_attributes >= data->max_attributes);		\
+	sysfs_attr_init(&a->dev_attr.attr);				\
+	a->dev_attr.attr.name = _name;					\
+	a->dev_attr.attr.mode = _mode;					\
+	a->dev_attr.show = _show;					\
+	a->dev_attr.store = _set;					\
+	a->index = _idx;						\
+	data->attributes[data->num_attributes] = &a->dev_attr.attr;	\
+	data->num_attributes++;						\
+} while (0)
+
+#define PMBUS_ADD_GET_ATTR(data, _name, _type, _idx)			\
+	PMBUS_ADD_ATTR(data, _name, _idx, S_IRUGO, _type,		\
+		       pmbus_show_##_type,  NULL)
+
+#define PMBUS_ADD_SET_ATTR(data, _name, _type, _idx)			\
+	PMBUS_ADD_ATTR(data, _name, _idx, S_IWUSR | S_IRUGO, _type,	\
+		       pmbus_show_##_type, pmbus_set_##_type)
+
+static void pmbus_add_boolean(struct pmbus_data *data,
+			      const char *name, const char *type, int seq,
+			      int idx)
+{
+	struct pmbus_boolean *boolean;
+
+	BUG_ON(data->num_booleans >= data->max_booleans);
+
+	boolean = &data->booleans[data->num_booleans];
+
+	snprintf(boolean->name, sizeof(boolean->name), "%s%d_%s",
+		 name, seq, type);
+	PMBUS_ADD_GET_ATTR(data, boolean->name, boolean, idx);
+	data->num_booleans++;
+}
+
+static void pmbus_add_boolean_reg(struct pmbus_data *data,
+				  const char *name, const char *type,
+				  int seq, int reg, int bit)
+{
+	pmbus_add_boolean(data, name, type, seq, (reg << 8) | bit);
+}
+
+static void pmbus_add_boolean_cmp(struct pmbus_data *data,
+				  const char *name, const char *type,
+				  int seq, int i1, int i2, int reg, int mask)
+{
+	pmbus_add_boolean(data, name, type, seq,
+			  (i1 << 24) | (i2 << 16) | (reg << 8) | mask);
+}
+
+static void pmbus_add_sensor(struct pmbus_data *data,
+			     const char *name, const char *type, int seq,
+			     int page, int reg, enum pmbus_sensor_classes class,
+			     bool update, bool readonly)
+{
+	struct pmbus_sensor *sensor;
+
+	BUG_ON(data->num_sensors >= data->max_sensors);
+
+	sensor = &data->sensors[data->num_sensors];
+	snprintf(sensor->name, sizeof(sensor->name), "%s%d_%s",
+		 name, seq, type);
+	sensor->page = page;
+	sensor->reg = reg;
+	sensor->class = class;
+	sensor->update = update;
+	if (readonly)
+		PMBUS_ADD_GET_ATTR(data, sensor->name, sensor,
+				   data->num_sensors);
+	else
+		PMBUS_ADD_SET_ATTR(data, sensor->name, sensor,
+				   data->num_sensors);
+	data->num_sensors++;
+}
+
+static void pmbus_add_label(struct pmbus_data *data,
+			    const char *name, int seq,
+			    const char *lstring, int index)
+{
+	struct pmbus_label *label;
+
+	BUG_ON(data->num_labels >= data->max_labels);
+
+	label = &data->labels[data->num_labels];
+	snprintf(label->name, sizeof(label->name), "%s%d_label", name, seq);
+	if (!index)
+		strncpy(label->label, lstring, sizeof(label->label) - 1);
+	else
+		snprintf(label->label, sizeof(label->label), "%s%d", lstring,
+			 index);
+
+	PMBUS_ADD_GET_ATTR(data, label->name, label, data->num_labels);
+	data->num_labels++;
+}
+
+/*
+ * Determine maximum number of sensors, booleans, and labels.
+ * To keep things simple, only make a rough high estimate.
+ */
+static void pmbus_find_max_attr(struct i2c_client *client,
+				struct pmbus_data *data)
+{
+	const struct pmbus_driver_info *info = data->info;
+	int page, max_sensors, max_booleans, max_labels;
+
+	max_sensors = PMBUS_MAX_INPUT_SENSORS;
+	max_booleans = PMBUS_MAX_INPUT_BOOLEANS;
+	max_labels = PMBUS_MAX_INPUT_LABELS;
+
+	for (page = 0; page < info->pages; page++) {
+		if (info->func[page] & PMBUS_HAVE_VOUT) {
+			max_sensors += PMBUS_VOUT_SENSORS_PER_PAGE;
+			max_booleans += PMBUS_VOUT_BOOLEANS_PER_PAGE;
+			max_labels++;
+		}
+		if (info->func[page] & PMBUS_HAVE_IOUT) {
+			max_sensors += PMBUS_IOUT_SENSORS_PER_PAGE;
+			max_booleans += PMBUS_IOUT_BOOLEANS_PER_PAGE;
+			max_labels++;
+		}
+		if (info->func[page] & PMBUS_HAVE_POUT) {
+			max_sensors += PMBUS_POUT_SENSORS_PER_PAGE;
+			max_booleans += PMBUS_POUT_BOOLEANS_PER_PAGE;
+			max_labels++;
+		}
+		if (info->func[page] & PMBUS_HAVE_FAN12) {
+			max_sensors += 2 * PMBUS_MAX_SENSORS_PER_FAN;
+			max_booleans += 2 * PMBUS_MAX_BOOLEANS_PER_FAN;
+		}
+		if (info->func[page] & PMBUS_HAVE_FAN34) {
+			max_sensors += 2 * PMBUS_MAX_SENSORS_PER_FAN;
+			max_booleans += 2 * PMBUS_MAX_BOOLEANS_PER_FAN;
+		}
+		if (info->func[page] & PMBUS_HAVE_TEMP) {
+			max_sensors += PMBUS_MAX_SENSORS_PER_TEMP;
+			max_booleans += PMBUS_MAX_BOOLEANS_PER_TEMP;
+		}
+		if (info->func[page] & PMBUS_HAVE_TEMP2) {
+			max_sensors += PMBUS_MAX_SENSORS_PER_TEMP;
+			max_booleans += PMBUS_MAX_BOOLEANS_PER_TEMP;
+		}
+		if (info->func[page] & PMBUS_HAVE_TEMP3) {
+			max_sensors += PMBUS_MAX_SENSORS_PER_TEMP;
+			max_booleans += PMBUS_MAX_BOOLEANS_PER_TEMP;
+		}
+	}
+	data->max_sensors = max_sensors;
+	data->max_booleans = max_booleans;
+	data->max_labels = max_labels;
+	data->max_attributes = max_sensors + max_booleans + max_labels;
+}
+
+/*
+ * Search for attributes. Allocate sensors, booleans, and labels as needed.
+ */
+
+/*
+ * The pmbus_limit_attr structure describes a single limit attribute
+ * and its associated alarm attribute.
+ */
+struct pmbus_limit_attr {
+	u8 reg;			/* Limit register */
+	const char *attr;	/* Attribute name */
+	const char *alarm;	/* Alarm attribute name */
+	u32 sbit;		/* Alarm attribute status bit */
+};
+
+/*
+ * The pmbus_sensor_attr structure describes one sensor attribute. This
+ * description includes a reference to the associated limit attributes.
+ */
+struct pmbus_sensor_attr {
+	u8 reg;				/* sensor register */
+	enum pmbus_sensor_classes class;/* sensor class */
+	const char *label;		/* sensor label */
+	bool paged;			/* true if paged sensor */
+	bool update;			/* true if update needed */
+	bool compare;			/* true if compare function needed */
+	u32 func;			/* sensor mask */
+	u32 sfunc;			/* sensor status mask */
+	int sbase;			/* status base register */
+	u32 gbit;			/* generic status bit */
+	const struct pmbus_limit_attr *limit;/* limit registers */
+	int nlimit;			/* # of limit registers */
+};
+
+/*
+ * Add a set of limit attributes and, if supported, the associated
+ * alarm attributes.
+ */
+static bool pmbus_add_limit_attrs(struct i2c_client *client,
+				  struct pmbus_data *data,
+				  const struct pmbus_driver_info *info,
+				  const char *name, int index, int page,
+				  int cbase,
+				  const struct pmbus_sensor_attr *attr)
+{
+	const struct pmbus_limit_attr *l = attr->limit;
+	int nlimit = attr->nlimit;
+	bool have_alarm = false;
+	int i, cindex;
+
+	for (i = 0; i < nlimit; i++) {
+		if (pmbus_check_word_register(client, page, l->reg)) {
+			cindex = data->num_sensors;
+			pmbus_add_sensor(data, name, l->attr, index, page,
+					 l->reg, attr->class, attr->update,
+					 false);
+			if (info->func[page] & attr->sfunc) {
+				if (attr->compare) {
+					pmbus_add_boolean_cmp(data, name,
+						l->alarm, index,
+						cbase, cindex,
+						attr->sbase + page, l->sbit);
+				} else {
+					pmbus_add_boolean_reg(data, name,
+						l->alarm, index,
+						attr->sbase + page, l->sbit);
+				}
+				have_alarm = true;
+			}
+		}
+		l++;
+	}
+	return have_alarm;
+}
+
+static void pmbus_add_sensor_attrs_one(struct i2c_client *client,
+				       struct pmbus_data *data,
+				       const struct pmbus_driver_info *info,
+				       const char *name,
+				       int index, int page,
+				       const struct pmbus_sensor_attr *attr)
+{
+	bool have_alarm;
+	int cbase = data->num_sensors;
+
+	if (attr->label)
+		pmbus_add_label(data, name, index, attr->label,
+				attr->paged ? page + 1 : 0);
+	pmbus_add_sensor(data, name, "input", index, page, attr->reg,
+			 attr->class, true, true);
+	if (attr->sfunc) {
+		have_alarm = pmbus_add_limit_attrs(client, data, info, name,
+						   index, page, cbase, attr);
+		/*
+		 * Add generic alarm attribute only if there are no individual
+		 * alarm attributes, and if there is a global alarm bit.
+		 */
+		if (!have_alarm && attr->gbit)
+			pmbus_add_boolean_reg(data, name, "alarm", index,
+					      PB_STATUS_BASE + page,
+					      attr->gbit);
+	}
+}
+
+static void pmbus_add_sensor_attrs(struct i2c_client *client,
+				   struct pmbus_data *data,
+				   const char *name,
+				   const struct pmbus_sensor_attr *attrs,
+				   int nattrs)
+{
+	const struct pmbus_driver_info *info = data->info;
+	int index, i;
+
+	index = 1;
+	for (i = 0; i < nattrs; i++) {
+		int page, pages;
+
+		pages = attrs->paged ? info->pages : 1;
+		for (page = 0; page < pages; page++) {
+			if (!(info->func[page] & attrs->func))
+				continue;
+			pmbus_add_sensor_attrs_one(client, data, info, name,
+						   index, page, attrs);
+			index++;
+		}
+		attrs++;
+	}
+}
+
+static const struct pmbus_limit_attr vin_limit_attrs[] = {
+	{
+		.reg = PMBUS_VIN_UV_WARN_LIMIT,
+		.attr = "min",
+		.alarm = "min_alarm",
+		.sbit = PB_VOLTAGE_UV_WARNING,
+	}, {
+		.reg = PMBUS_VIN_UV_FAULT_LIMIT,
+		.attr = "lcrit",
+		.alarm = "lcrit_alarm",
+		.sbit = PB_VOLTAGE_UV_FAULT,
+	}, {
+		.reg = PMBUS_VIN_OV_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_VOLTAGE_OV_WARNING,
+	}, {
+		.reg = PMBUS_VIN_OV_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_VOLTAGE_OV_FAULT,
+	},
+};
+
+static const struct pmbus_limit_attr vout_limit_attrs[] = {
+	{
+		.reg = PMBUS_VOUT_UV_WARN_LIMIT,
+		.attr = "min",
+		.alarm = "min_alarm",
+		.sbit = PB_VOLTAGE_UV_WARNING,
+	}, {
+		.reg = PMBUS_VOUT_UV_FAULT_LIMIT,
+		.attr = "lcrit",
+		.alarm = "lcrit_alarm",
+		.sbit = PB_VOLTAGE_UV_FAULT,
+	}, {
+		.reg = PMBUS_VOUT_OV_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_VOLTAGE_OV_WARNING,
+	}, {
+		.reg = PMBUS_VOUT_OV_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_VOLTAGE_OV_FAULT,
+	}
+};
+
+static const struct pmbus_sensor_attr voltage_attributes[] = {
+	{
+		.reg = PMBUS_READ_VIN,
+		.class = PSC_VOLTAGE_IN,
+		.label = "vin",
+		.func = PMBUS_HAVE_VIN,
+		.sfunc = PMBUS_HAVE_STATUS_INPUT,
+		.sbase = PB_STATUS_INPUT_BASE,
+		.gbit = PB_STATUS_VIN_UV,
+		.limit = vin_limit_attrs,
+		.nlimit = ARRAY_SIZE(vin_limit_attrs),
+	}, {
+		.reg = PMBUS_READ_VCAP,
+		.class = PSC_VOLTAGE_IN,
+		.label = "vcap",
+		.func = PMBUS_HAVE_VCAP,
+	}, {
+		.reg = PMBUS_READ_VOUT,
+		.class = PSC_VOLTAGE_OUT,
+		.label = "vout",
+		.paged = true,
+		.func = PMBUS_HAVE_VOUT,
+		.sfunc = PMBUS_HAVE_STATUS_VOUT,
+		.sbase = PB_STATUS_VOUT_BASE,
+		.gbit = PB_STATUS_VOUT_OV,
+		.limit = vout_limit_attrs,
+		.nlimit = ARRAY_SIZE(vout_limit_attrs),
+	}
+};
+
+/* Current attributes */
+
+static const struct pmbus_limit_attr iin_limit_attrs[] = {
+	{
+		.reg = PMBUS_IIN_OC_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_IIN_OC_WARNING,
+	}, {
+		.reg = PMBUS_IIN_OC_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_IIN_OC_FAULT,
+	}
+};
+
+static const struct pmbus_limit_attr iout_limit_attrs[] = {
+	{
+		.reg = PMBUS_IOUT_OC_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_IOUT_OC_WARNING,
+	}, {
+		.reg = PMBUS_IOUT_UC_FAULT_LIMIT,
+		.attr = "lcrit",
+		.alarm = "lcrit_alarm",
+		.sbit = PB_IOUT_UC_FAULT,
+	}, {
+		.reg = PMBUS_IOUT_OC_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_IOUT_OC_FAULT,
+	}
+};
+
+static const struct pmbus_sensor_attr current_attributes[] = {
+	{
+		.reg = PMBUS_READ_IIN,
+		.class = PSC_CURRENT_IN,
+		.label = "iin",
+		.func = PMBUS_HAVE_IIN,
+		.sfunc = PMBUS_HAVE_STATUS_INPUT,
+		.sbase = PB_STATUS_INPUT_BASE,
+		.limit = iin_limit_attrs,
+		.nlimit = ARRAY_SIZE(iin_limit_attrs),
+	}, {
+		.reg = PMBUS_READ_IOUT,
+		.class = PSC_CURRENT_OUT,
+		.label = "iout",
+		.paged = true,
+		.func = PMBUS_HAVE_IOUT,
+		.sfunc = PMBUS_HAVE_STATUS_IOUT,
+		.sbase = PB_STATUS_IOUT_BASE,
+		.gbit = PB_STATUS_IOUT_OC,
+		.limit = iout_limit_attrs,
+		.nlimit = ARRAY_SIZE(iout_limit_attrs),
+	}
+};
+
+/* Power attributes */
+
+static const struct pmbus_limit_attr pin_limit_attrs[] = {
+	{
+		.reg = PMBUS_PIN_OP_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "alarm",
+		.sbit = PB_PIN_OP_WARNING,
+	}
+};
+
+static const struct pmbus_limit_attr pout_limit_attrs[] = {
+	{
+		.reg = PMBUS_POUT_MAX,
+		.attr = "cap",
+		.alarm = "cap_alarm",
+		.sbit = PB_POWER_LIMITING,
+	}, {
+		.reg = PMBUS_POUT_OP_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_POUT_OP_WARNING,
+	}, {
+		.reg = PMBUS_POUT_OP_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_POUT_OP_FAULT,
+	}
+};
+
+static const struct pmbus_sensor_attr power_attributes[] = {
+	{
+		.reg = PMBUS_READ_PIN,
+		.class = PSC_POWER,
+		.label = "pin",
+		.func = PMBUS_HAVE_PIN,
+		.sfunc = PMBUS_HAVE_STATUS_INPUT,
+		.sbase = PB_STATUS_INPUT_BASE,
+		.limit = pin_limit_attrs,
+		.nlimit = ARRAY_SIZE(pin_limit_attrs),
+	}, {
+		.reg = PMBUS_READ_POUT,
+		.class = PSC_POWER,
+		.label = "pout",
+		.paged = true,
+		.func = PMBUS_HAVE_POUT,
+		.sfunc = PMBUS_HAVE_STATUS_IOUT,
+		.sbase = PB_STATUS_IOUT_BASE,
+		.limit = pout_limit_attrs,
+		.nlimit = ARRAY_SIZE(pout_limit_attrs),
+	}
+};
+
+/* Temperature atributes */
+
+static const struct pmbus_limit_attr temp_limit_attrs[] = {
+	{
+		.reg = PMBUS_UT_WARN_LIMIT,
+		.attr = "min",
+		.alarm = "min_alarm",
+		.sbit = PB_TEMP_UT_WARNING,
+	}, {
+		.reg = PMBUS_UT_FAULT_LIMIT,
+		.attr = "lcrit",
+		.alarm = "lcrit_alarm",
+		.sbit = PB_TEMP_UT_FAULT,
+	}, {
+		.reg = PMBUS_OT_WARN_LIMIT,
+		.attr = "max",
+		.alarm = "max_alarm",
+		.sbit = PB_TEMP_OT_WARNING,
+	}, {
+		.reg = PMBUS_OT_FAULT_LIMIT,
+		.attr = "crit",
+		.alarm = "crit_alarm",
+		.sbit = PB_TEMP_OT_FAULT,
+	}
+};
+
+static const struct pmbus_sensor_attr temp_attributes[] = {
+	{
+		.reg = PMBUS_READ_TEMPERATURE_1,
+		.class = PSC_TEMPERATURE,
+		.paged = true,
+		.update = true,
+		.compare = true,
+		.func = PMBUS_HAVE_TEMP,
+		.sfunc = PMBUS_HAVE_STATUS_TEMP,
+		.sbase = PB_STATUS_TEMP_BASE,
+		.gbit = PB_STATUS_TEMPERATURE,
+		.limit = temp_limit_attrs,
+		.nlimit = ARRAY_SIZE(temp_limit_attrs),
+	}, {
+		.reg = PMBUS_READ_TEMPERATURE_2,
+		.class = PSC_TEMPERATURE,
+		.paged = true,
+		.update = true,
+		.compare = true,
+		.func = PMBUS_HAVE_TEMP2,
+		.sfunc = PMBUS_HAVE_STATUS_TEMP,
+		.sbase = PB_STATUS_TEMP_BASE,
+		.gbit = PB_STATUS_TEMPERATURE,
+		.limit = temp_limit_attrs,
+		.nlimit = ARRAY_SIZE(temp_limit_attrs),
+	}, {
+		.reg = PMBUS_READ_TEMPERATURE_3,
+		.class = PSC_TEMPERATURE,
+		.paged = true,
+		.update = true,
+		.compare = true,
+		.func = PMBUS_HAVE_TEMP3,
+		.sfunc = PMBUS_HAVE_STATUS_TEMP,
+		.sbase = PB_STATUS_TEMP_BASE,
+		.gbit = PB_STATUS_TEMPERATURE,
+		.limit = temp_limit_attrs,
+		.nlimit = ARRAY_SIZE(temp_limit_attrs),
+	}
+};
+
+static const int pmbus_fan_registers[] = {
+	PMBUS_READ_FAN_SPEED_1,
+	PMBUS_READ_FAN_SPEED_2,
+	PMBUS_READ_FAN_SPEED_3,
+	PMBUS_READ_FAN_SPEED_4
+};
+
+static const int pmbus_fan_config_registers[] = {
+	PMBUS_FAN_CONFIG_12,
+	PMBUS_FAN_CONFIG_12,
+	PMBUS_FAN_CONFIG_34,
+	PMBUS_FAN_CONFIG_34
+};
+
+static const int pmbus_fan_status_registers[] = {
+	PMBUS_STATUS_FAN_12,
+	PMBUS_STATUS_FAN_12,
+	PMBUS_STATUS_FAN_34,
+	PMBUS_STATUS_FAN_34
+};
+
+static const u32 pmbus_fan_flags[] = {
+	PMBUS_HAVE_FAN12,
+	PMBUS_HAVE_FAN12,
+	PMBUS_HAVE_FAN34,
+	PMBUS_HAVE_FAN34
+};
+
+static const u32 pmbus_fan_status_flags[] = {
+	PMBUS_HAVE_STATUS_FAN12,
+	PMBUS_HAVE_STATUS_FAN12,
+	PMBUS_HAVE_STATUS_FAN34,
+	PMBUS_HAVE_STATUS_FAN34
+};
+
+/* Fans */
+static void pmbus_add_fan_attributes(struct i2c_client *client,
+				     struct pmbus_data *data)
+{
+	const struct pmbus_driver_info *info = data->info;
+	int index = 1;
+	int page;
+
+	for (page = 0; page < info->pages; page++) {
+		int f;
+
+		for (f = 0; f < ARRAY_SIZE(pmbus_fan_registers); f++) {
+			int regval;
+
+			if (!(info->func[page] & pmbus_fan_flags[f]))
+				break;
+
+			if (!pmbus_check_word_register(client, page,
+						       pmbus_fan_registers[f]))
+				break;
+
+			/*
+			 * Skip fan if not installed.
+			 * Each fan configuration register covers multiple fans,
+			 * so we have to do some magic.
+			 */
+			regval = _pmbus_read_byte_data(client, page,
+				pmbus_fan_config_registers[f]);
+			if (regval < 0 ||
+			    (!(regval & (PB_FAN_1_INSTALLED >> ((f & 1) * 4)))))
+				continue;
+
+			pmbus_add_sensor(data, "fan", "input", index, page,
+					 pmbus_fan_registers[f], PSC_FAN, true,
+					 true);
+
+			/*
+			 * Each fan status register covers multiple fans,
+			 * so we have to do some magic.
+			 */
+			if ((info->func[page] & pmbus_fan_status_flags[f]) &&
+			    pmbus_check_byte_register(client,
+					page, pmbus_fan_status_registers[f])) {
+				int base;
+
+				if (f > 1)	/* fan 3, 4 */
+					base = PB_STATUS_FAN34_BASE + page;
+				else
+					base = PB_STATUS_FAN_BASE + page;
+				pmbus_add_boolean_reg(data, "fan", "alarm",
+					index, base,
+					PB_FAN_FAN1_WARNING >> (f & 1));
+				pmbus_add_boolean_reg(data, "fan", "fault",
+					index, base,
+					PB_FAN_FAN1_FAULT >> (f & 1));
+			}
+			index++;
+		}
+	}
+}
+
+static void pmbus_find_attributes(struct i2c_client *client,
+				  struct pmbus_data *data)
+{
+	/* Voltage sensors */
+	pmbus_add_sensor_attrs(client, data, "in", voltage_attributes,
+			       ARRAY_SIZE(voltage_attributes));
+
+	/* Current sensors */
+	pmbus_add_sensor_attrs(client, data, "curr", current_attributes,
+			       ARRAY_SIZE(current_attributes));
+
+	/* Power sensors */
+	pmbus_add_sensor_attrs(client, data, "power", power_attributes,
+			       ARRAY_SIZE(power_attributes));
+
+	/* Temperature sensors */
+	pmbus_add_sensor_attrs(client, data, "temp", temp_attributes,
+			       ARRAY_SIZE(temp_attributes));
+
+	/* Fans */
+	pmbus_add_fan_attributes(client, data);
+}
+
+/*
+ * Identify chip parameters.
+ * This function is called for all chips.
+ */
+static int pmbus_identify_common(struct i2c_client *client,
+				 struct pmbus_data *data)
+{
+	int vout_mode = -1, exponent;
+
+	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE))
+		vout_mode = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
+	if (vout_mode >= 0 && vout_mode != 0xff) {
+		/*
+		 * Not all chips support the VOUT_MODE command,
+		 * so a failure to read it is not an error.
+		 */
+		switch (vout_mode >> 5) {
+		case 0:	/* linear mode      */
+			if (data->info->direct[PSC_VOLTAGE_OUT])
+				return -ENODEV;
+
+			exponent = vout_mode & 0x1f;
+			/* and sign-extend it */
+			if (exponent & 0x10)
+				exponent |= ~0x1f;
+			data->exponent = exponent;
+			break;
+		case 2:	/* direct mode      */
+			if (!data->info->direct[PSC_VOLTAGE_OUT])
+				return -ENODEV;
+			break;
+		default:
+			return -ENODEV;
+		}
+	}
+
+	/* Determine maximum number of sensors, booleans, and labels */
+	pmbus_find_max_attr(client, data);
+	pmbus_clear_fault_page(client, 0);
+	return 0;
+}
+
+int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
+		   struct pmbus_driver_info *info)
+{
+	const struct pmbus_platform_data *pdata = client->dev.platform_data;
+	struct pmbus_data *data;
+	int ret;
+
+	if (!info) {
+		dev_err(&client->dev, "Missing chip information");
+		return -ENODEV;
+	}
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WRITE_BYTE
+				     | I2C_FUNC_SMBUS_BYTE_DATA
+				     | I2C_FUNC_SMBUS_WORD_DATA))
+		return -ENODEV;
+
+	data = kzalloc(sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		dev_err(&client->dev, "No memory to allocate driver data\n");
+		return -ENOMEM;
+	}
+
+	i2c_set_clientdata(client, data);
+	mutex_init(&data->update_lock);
+
+	/* Bail out if PMBus status register does not exist. */
+	if (i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE) < 0) {
+		dev_err(&client->dev, "PMBus status register not found\n");
+		ret = -ENODEV;
+		goto out_data;
+	}
+
+	if (pdata)
+		data->flags = pdata->flags;
+	data->info = info;
+
+	pmbus_clear_faults(client);
+
+	if (info->identify) {
+		ret = (*info->identify)(client, info);
+		if (ret < 0) {
+			dev_err(&client->dev, "Chip identification failed\n");
+			goto out_data;
+		}
+	}
+
+	if (info->pages <= 0 || info->pages > PMBUS_PAGES) {
+		dev_err(&client->dev, "Bad number of PMBus pages: %d\n",
+			info->pages);
+		ret = -EINVAL;
+		goto out_data;
+	}
+	/*
+	 * Bail out if more than one page was configured, but we can not
+	 * select the highest page. This is an indication that the wrong
+	 * chip type was selected. Better bail out now than keep
+	 * returning errors later on.
+	 */
+	if (info->pages > 1 && pmbus_set_page(client, info->pages - 1) < 0) {
+		dev_err(&client->dev, "Failed to select page %d\n",
+			info->pages - 1);
+		ret = -EINVAL;
+		goto out_data;
+	}
+
+	ret = pmbus_identify_common(client, data);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to identify chip capabilities\n");
+		goto out_data;
+	}
+
+	ret = -ENOMEM;
+	data->sensors = kzalloc(sizeof(struct pmbus_sensor) * data->max_sensors,
+				GFP_KERNEL);
+	if (!data->sensors) {
+		dev_err(&client->dev, "No memory to allocate sensor data\n");
+		goto out_data;
+	}
+
+	data->booleans = kzalloc(sizeof(struct pmbus_boolean)
+				 * data->max_booleans, GFP_KERNEL);
+	if (!data->booleans) {
+		dev_err(&client->dev, "No memory to allocate boolean data\n");
+		goto out_sensors;
+	}
+
+	data->labels = kzalloc(sizeof(struct pmbus_label) * data->max_labels,
+			       GFP_KERNEL);
+	if (!data->labels) {
+		dev_err(&client->dev, "No memory to allocate label data\n");
+		goto out_booleans;
+	}
+
+	data->attributes = kzalloc(sizeof(struct attribute *)
+				   * data->max_attributes, GFP_KERNEL);
+	if (!data->attributes) {
+		dev_err(&client->dev, "No memory to allocate attribute data\n");
+		goto out_labels;
+	}
+
+	pmbus_find_attributes(client, data);
+
+	/*
+	 * If there are no attributes, something is wrong.
+	 * Bail out instead of trying to register nothing.
+	 */
+	if (!data->num_attributes) {
+		dev_err(&client->dev, "No attributes found\n");
+		ret = -ENODEV;
+		goto out_attributes;
+	}
+
+	/* Register sysfs hooks */
+	data->group.attrs = data->attributes;
+	ret = sysfs_create_group(&client->dev.kobj, &data->group);
+	if (ret) {
+		dev_err(&client->dev, "Failed to create sysfs entries\n");
+		goto out_attributes;
+	}
+	data->hwmon_dev = hwmon_device_register(&client->dev);
+	if (IS_ERR(data->hwmon_dev)) {
+		ret = PTR_ERR(data->hwmon_dev);
+		dev_err(&client->dev, "Failed to register hwmon device\n");
+		goto out_hwmon_device_register;
+	}
+	return 0;
+
+out_hwmon_device_register:
+	sysfs_remove_group(&client->dev.kobj, &data->group);
+out_attributes:
+	kfree(data->attributes);
+out_labels:
+	kfree(data->labels);
+out_booleans:
+	kfree(data->booleans);
+out_sensors:
+	kfree(data->sensors);
+out_data:
+	kfree(data);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pmbus_do_probe);
+
+int pmbus_do_remove(struct i2c_client *client)
+{
+	struct pmbus_data *data = i2c_get_clientdata(client);
+	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &data->group);
+	kfree(data->attributes);
+	kfree(data->labels);
+	kfree(data->booleans);
+	kfree(data->sensors);
+	kfree(data);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(pmbus_do_remove);
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("PMBus core driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/hwmon/pmbus/ucd9000.c b/drivers/hwmon/pmbus/ucd9000.c
new file mode 100644
index 0000000..ace1c73
--- /dev/null
+++ b/drivers/hwmon/pmbus/ucd9000.c
@@ -0,0 +1,278 @@
+/*
+ * Hardware monitoring driver for UCD90xxx Sequencer and System Health
+ * Controller series
+ *
+ * Copyright (C) 2011 Ericsson AB.
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
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c/pmbus.h>
+#include "pmbus.h"
+
+enum chips { ucd9000, ucd90120, ucd90124, ucd9090, ucd90910 };
+
+#define UCD9000_MONITOR_CONFIG		0xd5
+#define UCD9000_NUM_PAGES		0xd6
+#define UCD9000_FAN_CONFIG_INDEX	0xe7
+#define UCD9000_FAN_CONFIG		0xe8
+#define UCD9000_DEVICE_ID		0xfd
+
+#define UCD9000_MON_TYPE(x)	(((x) >> 5) & 0x07)
+#define UCD9000_MON_PAGE(x)	((x) & 0x0f)
+
+#define UCD9000_MON_VOLTAGE	1
+#define UCD9000_MON_TEMPERATURE	2
+#define UCD9000_MON_CURRENT	3
+#define UCD9000_MON_VOLTAGE_HW	4
+
+#define UCD9000_NUM_FAN		4
+
+struct ucd9000_data {
+	u8 fan_data[UCD9000_NUM_FAN][I2C_SMBUS_BLOCK_MAX];
+	struct pmbus_driver_info info;
+};
+#define to_ucd9000_data(_info) container_of(_info, struct ucd9000_data, info)
+
+static int ucd9000_get_fan_config(struct i2c_client *client, int fan)
+{
+	int fan_config = 0;
+	struct ucd9000_data *data
+	  = to_ucd9000_data(pmbus_get_driver_info(client));
+
+	if (data->fan_data[fan][3] & 1)
+		fan_config |= PB_FAN_2_INSTALLED;   /* Use lower bit position */
+
+	/* Pulses/revolution */
+	fan_config |= (data->fan_data[fan][3] & 0x06) >> 1;
+
+	return fan_config;
+}
+
+static int ucd9000_read_byte_data(struct i2c_client *client, int page, int reg)
+{
+	int ret = 0;
+	int fan_config;
+
+	switch (reg) {
+	case PMBUS_FAN_CONFIG_12:
+		if (page)
+			return -EINVAL;
+
+		ret = ucd9000_get_fan_config(client, 0);
+		if (ret < 0)
+			return ret;
+		fan_config = ret << 4;
+		ret = ucd9000_get_fan_config(client, 1);
+		if (ret < 0)
+			return ret;
+		fan_config |= ret;
+		ret = fan_config;
+		break;
+	case PMBUS_FAN_CONFIG_34:
+		if (page)
+			return -EINVAL;
+
+		ret = ucd9000_get_fan_config(client, 2);
+		if (ret < 0)
+			return ret;
+		fan_config = ret << 4;
+		ret = ucd9000_get_fan_config(client, 3);
+		if (ret < 0)
+			return ret;
+		fan_config |= ret;
+		ret = fan_config;
+		break;
+	default:
+		ret = -ENODATA;
+		break;
+	}
+	return ret;
+}
+
+static const struct i2c_device_id ucd9000_id[] = {
+	{"ucd9000", ucd9000},
+	{"ucd90120", ucd90120},
+	{"ucd90124", ucd90124},
+	{"ucd9090", ucd9090},
+	{"ucd90910", ucd90910},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ucd9000_id);
+
+static int ucd9000_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
+	struct ucd9000_data *data;
+	struct pmbus_driver_info *info;
+	const struct i2c_device_id *mid;
+	int i, ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_BLOCK_DATA))
+		return -ENODEV;
+
+	ret = i2c_smbus_read_block_data(client, UCD9000_DEVICE_ID,
+					block_buffer);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read device ID\n");
+		return ret;
+	}
+	block_buffer[ret] = '\0';
+	dev_info(&client->dev, "Device ID %s\n", block_buffer);
+
+	mid = NULL;
+	for (i = 0; i < ARRAY_SIZE(ucd9000_id); i++) {
+		mid = &ucd9000_id[i];
+		if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
+			break;
+	}
+	if (!mid || !strlen(mid->name)) {
+		dev_err(&client->dev, "Unsupported device\n");
+		return -ENODEV;
+	}
+
+	if (id->driver_data != ucd9000 && id->driver_data != mid->driver_data)
+		dev_notice(&client->dev,
+			   "Device mismatch: Configured %s, detected %s\n",
+			   id->name, mid->name);
+
+	data = kzalloc(sizeof(struct ucd9000_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
+	info = &data->info;
+
+	ret = i2c_smbus_read_byte_data(client, UCD9000_NUM_PAGES);
+	if (ret < 0) {
+		dev_err(&client->dev,
+			"Failed to read number of active pages\n");
+		goto out;
+	}
+	info->pages = ret;
+	if (!info->pages) {
+		dev_err(&client->dev, "No pages configured\n");
+		ret = -ENODEV;
+		goto out;
+	}
+
+	/* The internal temperature sensor is always active */
+	info->func[0] = PMBUS_HAVE_TEMP;
+
+	/* Everything else is configurable */
+	ret = i2c_smbus_read_block_data(client, UCD9000_MONITOR_CONFIG,
+					block_buffer);
+	if (ret <= 0) {
+		dev_err(&client->dev, "Failed to read configuration data\n");
+		ret = -ENODEV;
+		goto out;
+	}
+	for (i = 0; i < ret; i++) {
+		int page = UCD9000_MON_PAGE(block_buffer[i]);
+
+		if (page >= info->pages)
+			continue;
+
+		switch (UCD9000_MON_TYPE(block_buffer[i])) {
+		case UCD9000_MON_VOLTAGE:
+		case UCD9000_MON_VOLTAGE_HW:
+			info->func[page] |= PMBUS_HAVE_VOUT
+			  | PMBUS_HAVE_STATUS_VOUT;
+			break;
+		case UCD9000_MON_TEMPERATURE:
+			info->func[page] |= PMBUS_HAVE_TEMP2
+			  | PMBUS_HAVE_STATUS_TEMP;
+			break;
+		case UCD9000_MON_CURRENT:
+			info->func[page] |= PMBUS_HAVE_IOUT
+			  | PMBUS_HAVE_STATUS_IOUT;
+			break;
+		default:
+			break;
+		}
+	}
+
+	/* Fan configuration */
+	if (mid->driver_data = ucd90124) {
+		for (i = 0; i < UCD9000_NUM_FAN; i++) {
+			i2c_smbus_write_byte_data(client,
+						  UCD9000_FAN_CONFIG_INDEX, i);
+			ret = i2c_smbus_read_block_data(client,
+							UCD9000_FAN_CONFIG,
+							data->fan_data[i]);
+			if (ret < 0)
+				goto out;
+		}
+		i2c_smbus_write_byte_data(client, UCD9000_FAN_CONFIG_INDEX, 0);
+
+		info->read_byte_data = ucd9000_read_byte_data;
+		info->func[0] |= PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12
+		  | PMBUS_HAVE_FAN34 | PMBUS_HAVE_STATUS_FAN34;
+	}
+
+	ret = pmbus_do_probe(client, mid, info);
+	if (ret < 0)
+		goto out;
+	return 0;
+
+out:
+	kfree(data);
+	return ret;
+}
+
+static int ucd9000_remove(struct i2c_client *client)
+{
+	int ret;
+	struct ucd9000_data *data;
+
+	data = to_ucd9000_data(pmbus_get_driver_info(client));
+	ret = pmbus_do_remove(client);
+	kfree(data);
+	return ret;
+}
+
+
+/* This is the driver that will be inserted */
+static struct i2c_driver ucd9000_driver = {
+	.driver = {
+		.name = "ucd9000",
+	},
+	.probe = ucd9000_probe,
+	.remove = ucd9000_remove,
+	.id_table = ucd9000_id,
+};
+
+static int __init ucd9000_init(void)
+{
+	return i2c_add_driver(&ucd9000_driver);
+}
+
+static void __exit ucd9000_exit(void)
+{
+	i2c_del_driver(&ucd9000_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("PMBus driver for TI UCD90xxx");
+MODULE_LICENSE("GPL");
+module_init(ucd9000_init);
+module_exit(ucd9000_exit);
diff --git a/drivers/hwmon/pmbus/ucd9200.c b/drivers/hwmon/pmbus/ucd9200.c
new file mode 100644
index 0000000..ffcc1cf
--- /dev/null
+++ b/drivers/hwmon/pmbus/ucd9200.c
@@ -0,0 +1,210 @@
+/*
+ * Hardware monitoring driver for ucd9200 series Digital PWM System Controllers
+ *
+ * Copyright (C) 2011 Ericsson AB.
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
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/i2c/pmbus.h>
+#include "pmbus.h"
+
+#define UCD9200_PHASE_INFO	0xd2
+#define UCD9200_DEVICE_ID	0xfd
+
+enum chips { ucd9200, ucd9220, ucd9222, ucd9224, ucd9240, ucd9244, ucd9246,
+	     ucd9248 };
+
+static const struct i2c_device_id ucd9200_id[] = {
+	{"ucd9200", ucd9200},
+	{"ucd9220", ucd9220},
+	{"ucd9222", ucd9222},
+	{"ucd9224", ucd9224},
+	{"ucd9240", ucd9240},
+	{"ucd9244", ucd9244},
+	{"ucd9246", ucd9246},
+	{"ucd9248", ucd9248},
+	{}
+};
+MODULE_DEVICE_TABLE(i2c, ucd9200_id);
+
+static int ucd9200_probe(struct i2c_client *client,
+			 const struct i2c_device_id *id)
+{
+	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
+	struct pmbus_driver_info *info;
+	const struct i2c_device_id *mid;
+	int i, j, ret;
+
+	if (!i2c_check_functionality(client->adapter,
+				     I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_BLOCK_DATA))
+		return -ENODEV;
+
+	ret = i2c_smbus_read_block_data(client, UCD9200_DEVICE_ID,
+					block_buffer);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read device ID\n");
+		return ret;
+	}
+	block_buffer[ret] = '\0';
+	dev_info(&client->dev, "Device ID %s\n", block_buffer);
+
+	mid = NULL;
+	for (i = 0; i < ARRAY_SIZE(ucd9200_id); i++) {
+		mid = &ucd9200_id[i];
+		if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
+			break;
+	}
+	if (!mid || !strlen(mid->name)) {
+		dev_err(&client->dev, "Unsupported device\n");
+		return -ENODEV;
+	}
+	if (id->driver_data != ucd9200 && id->driver_data != mid->driver_data)
+		dev_notice(&client->dev,
+			   "Device mismatch: Configured %s, detected %s\n",
+			   id->name, mid->name);
+
+	info = kzalloc(sizeof(struct pmbus_driver_info), GFP_KERNEL);
+	if (!info)
+		return -ENOMEM;
+
+	ret = i2c_smbus_read_block_data(client, UCD9200_PHASE_INFO,
+					block_buffer);
+	if (ret < 0) {
+		dev_err(&client->dev, "Failed to read phase information\n");
+		goto out;
+	}
+
+	/*
+	 * Calculate number of configured pages (rails) from PHASE_INFO
+	 * register.
+	 * Rails have to be sequential, so we can abort after finding
+	 * the first unconfigured rail.
+	 */
+	info->pages = 0;
+	for (i = 0; i < ret; i++) {
+		if (!block_buffer[i])
+			break;
+		info->pages++;
+	}
+	if (!info->pages) {
+		dev_err(&client->dev, "No rails configured\n");
+		ret = -ENODEV;
+		goto out;
+	}
+	dev_info(&client->dev, "%d rails configured\n", info->pages);
+
+	/*
+	 * Set PHASE registers on all pages to 0xff to ensure that phase
+	 * specific commands will apply to all phases of a given page (rail).
+	 * This only affects the READ_IOUT and READ_TEMPERATURE2 registers.
+	 * READ_IOUT will return the sum of currents of all phases of a rail,
+	 * and READ_TEMPERATURE2 will return the maximum temperature detected
+	 * for the the phases of the rail.
+	 */
+	for (i = 0; i < info->pages; i++) {
+		/*
+		 * Setting PAGE & PHASE fails once in a while for no obvious
+		 * reason, so we need to retry a couple of times.
+		 */
+		for (j = 0; j < 3; j++) {
+			ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, i);
+			if (ret < 0)
+				continue;
+			ret = i2c_smbus_write_byte_data(client, PMBUS_PHASE,
+							0xff);
+			if (ret < 0)
+				continue;
+			break;
+		}
+		if (ret < 0) {
+			dev_err(&client->dev,
+				"Failed to initialize PHASE registers\n");
+			goto out;
+		}
+	}
+	if (info->pages > 1)
+		i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
+
+	info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT |
+			PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
+			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+			PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+			PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP |
+			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
+
+	for (i = 1; i < info->pages; i++)
+		info->func[i] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
+			PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
+			PMBUS_HAVE_POUT |
+			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
+
+	/* ucd9240 supports a single fan */
+	if (mid->driver_data = ucd9240)
+		info->func[0] |= PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12;
+
+	ret = pmbus_do_probe(client, mid, info);
+	if (ret < 0)
+		goto out;
+	return 0;
+out:
+	kfree(info);
+	return ret;
+}
+
+static int ucd9200_remove(struct i2c_client *client)
+{
+	int ret;
+	const struct pmbus_driver_info *info;
+
+	info = pmbus_get_driver_info(client);
+	ret = pmbus_do_remove(client);
+	kfree(info);
+	return ret;
+}
+
+
+/* This is the driver that will be inserted */
+static struct i2c_driver ucd9200_driver = {
+	.driver = {
+		.name = "ucd9200",
+	},
+	.probe = ucd9200_probe,
+	.remove = ucd9200_remove,
+	.id_table = ucd9200_id,
+};
+
+static int __init ucd9200_init(void)
+{
+	return i2c_add_driver(&ucd9200_driver);
+}
+
+static void __exit ucd9200_exit(void)
+{
+	i2c_del_driver(&ucd9200_driver);
+}
+
+MODULE_AUTHOR("Guenter Roeck");
+MODULE_DESCRIPTION("PMBus driver for TI UCD922x, UCD924x");
+MODULE_LICENSE("GPL");
+module_init(ucd9200_init);
+module_exit(ucd9200_exit);
diff --git a/drivers/hwmon/pmbus_core.c b/drivers/hwmon/pmbus_core.c
deleted file mode 100644
index 8e31a8e..0000000
--- a/drivers/hwmon/pmbus_core.c
+++ /dev/null
@@ -1,1567 +0,0 @@
-/*
- * Hardware monitoring driver for PMBus devices
- *
- * Copyright (c) 2010, 2011 Ericsson AB.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/hwmon.h>
-#include <linux/hwmon-sysfs.h>
-#include <linux/delay.h>
-#include <linux/i2c/pmbus.h>
-#include "pmbus.h"
-
-/*
- * Constants needed to determine number of sensors, booleans, and labels.
- */
-#define PMBUS_MAX_INPUT_SENSORS		11	/* 6*volt, 3*curr, 2*power */
-#define PMBUS_VOUT_SENSORS_PER_PAGE	5	/* input, min, max, lcrit,
-						   crit */
-#define PMBUS_IOUT_SENSORS_PER_PAGE	4	/* input, min, max, crit */
-#define PMBUS_POUT_SENSORS_PER_PAGE	4	/* input, cap, max, crit */
-#define PMBUS_MAX_SENSORS_PER_FAN	1	/* input */
-#define PMBUS_MAX_SENSORS_PER_TEMP	5	/* input, min, max, lcrit,
-						   crit */
-
-#define PMBUS_MAX_INPUT_BOOLEANS	7	/* v: min_alarm, max_alarm,
-						   lcrit_alarm, crit_alarm;
-						   c: alarm, crit_alarm;
-						   p: crit_alarm */
-#define PMBUS_VOUT_BOOLEANS_PER_PAGE	4	/* min_alarm, max_alarm,
-						   lcrit_alarm, crit_alarm */
-#define PMBUS_IOUT_BOOLEANS_PER_PAGE	3	/* alarm, lcrit_alarm,
-						   crit_alarm */
-#define PMBUS_POUT_BOOLEANS_PER_PAGE	2	/* alarm, crit_alarm */
-#define PMBUS_MAX_BOOLEANS_PER_FAN	2	/* alarm, fault */
-#define PMBUS_MAX_BOOLEANS_PER_TEMP	4	/* min_alarm, max_alarm,
-						   lcrit_alarm, crit_alarm */
-
-#define PMBUS_MAX_INPUT_LABELS		4	/* vin, vcap, iin, pin */
-
-/*
- * status, status_vout, status_iout, status_fans, status_fan34, and status_temp
- * are paged. status_input is unpaged.
- */
-#define PB_NUM_STATUS_REG	(PMBUS_PAGES * 6 + 1)
-
-/*
- * Index into status register array, per status register group
- */
-#define PB_STATUS_BASE		0
-#define PB_STATUS_VOUT_BASE	(PB_STATUS_BASE + PMBUS_PAGES)
-#define PB_STATUS_IOUT_BASE	(PB_STATUS_VOUT_BASE + PMBUS_PAGES)
-#define PB_STATUS_FAN_BASE	(PB_STATUS_IOUT_BASE + PMBUS_PAGES)
-#define PB_STATUS_FAN34_BASE	(PB_STATUS_FAN_BASE + PMBUS_PAGES)
-#define PB_STATUS_INPUT_BASE	(PB_STATUS_FAN34_BASE + PMBUS_PAGES)
-#define PB_STATUS_TEMP_BASE	(PB_STATUS_INPUT_BASE + 1)
-
-struct pmbus_sensor {
-	char name[I2C_NAME_SIZE];	/* sysfs sensor name */
-	struct sensor_device_attribute attribute;
-	u8 page;		/* page number */
-	u8 reg;			/* register */
-	enum pmbus_sensor_classes class;	/* sensor class */
-	bool update;		/* runtime sensor update needed */
-	int data;		/* Sensor data.
-				   Negative if there was a read error */
-};
-
-struct pmbus_boolean {
-	char name[I2C_NAME_SIZE];	/* sysfs boolean name */
-	struct sensor_device_attribute attribute;
-};
-
-struct pmbus_label {
-	char name[I2C_NAME_SIZE];	/* sysfs label name */
-	struct sensor_device_attribute attribute;
-	char label[I2C_NAME_SIZE];	/* label */
-};
-
-struct pmbus_data {
-	struct device *hwmon_dev;
-
-	u32 flags;		/* from platform data */
-
-	int exponent;		/* linear mode: exponent for output voltages */
-
-	const struct pmbus_driver_info *info;
-
-	int max_attributes;
-	int num_attributes;
-	struct attribute **attributes;
-	struct attribute_group group;
-
-	/*
-	 * Sensors cover both sensor and limit registers.
-	 */
-	int max_sensors;
-	int num_sensors;
-	struct pmbus_sensor *sensors;
-	/*
-	 * Booleans are used for alarms.
-	 * Values are determined from status registers.
-	 */
-	int max_booleans;
-	int num_booleans;
-	struct pmbus_boolean *booleans;
-	/*
-	 * Labels are used to map generic names (e.g., "in1")
-	 * to PMBus specific names (e.g., "vin" or "vout1").
-	 */
-	int max_labels;
-	int num_labels;
-	struct pmbus_label *labels;
-
-	struct mutex update_lock;
-	bool valid;
-	unsigned long last_updated;	/* in jiffies */
-
-	/*
-	 * A single status register covers multiple attributes,
-	 * so we keep them all together.
-	 */
-	u8 status[PB_NUM_STATUS_REG];
-
-	u8 currpage;
-};
-
-int pmbus_set_page(struct i2c_client *client, u8 page)
-{
-	struct pmbus_data *data = i2c_get_clientdata(client);
-	int rv = 0;
-	int newpage;
-
-	if (page != data->currpage) {
-		rv = i2c_smbus_write_byte_data(client, PMBUS_PAGE, page);
-		newpage = i2c_smbus_read_byte_data(client, PMBUS_PAGE);
-		if (newpage != page)
-			rv = -EINVAL;
-		else
-			data->currpage = page;
-	}
-	return rv;
-}
-EXPORT_SYMBOL_GPL(pmbus_set_page);
-
-static int pmbus_write_byte(struct i2c_client *client, u8 page, u8 value)
-{
-	int rv;
-
-	rv = pmbus_set_page(client, page);
-	if (rv < 0)
-		return rv;
-
-	return i2c_smbus_write_byte(client, value);
-}
-
-static int pmbus_write_word_data(struct i2c_client *client, u8 page, u8 reg,
-				 u16 word)
-{
-	int rv;
-
-	rv = pmbus_set_page(client, page);
-	if (rv < 0)
-		return rv;
-
-	return i2c_smbus_write_word_data(client, reg, word);
-}
-
-int pmbus_read_word_data(struct i2c_client *client, u8 page, u8 reg)
-{
-	int rv;
-
-	rv = pmbus_set_page(client, page);
-	if (rv < 0)
-		return rv;
-
-	return i2c_smbus_read_word_data(client, reg);
-}
-EXPORT_SYMBOL_GPL(pmbus_read_word_data);
-
-static int pmbus_read_byte_data(struct i2c_client *client, u8 page, u8 reg)
-{
-	int rv;
-
-	rv = pmbus_set_page(client, page);
-	if (rv < 0)
-		return rv;
-
-	return i2c_smbus_read_byte_data(client, reg);
-}
-
-static void pmbus_clear_fault_page(struct i2c_client *client, int page)
-{
-	pmbus_write_byte(client, page, PMBUS_CLEAR_FAULTS);
-}
-
-void pmbus_clear_faults(struct i2c_client *client)
-{
-	struct pmbus_data *data = i2c_get_clientdata(client);
-	int i;
-
-	for (i = 0; i < data->info->pages; i++)
-		pmbus_clear_fault_page(client, i);
-}
-EXPORT_SYMBOL_GPL(pmbus_clear_faults);
-
-static int pmbus_check_status_cml(struct i2c_client *client, int page)
-{
-	int status, status2;
-
-	status = pmbus_read_byte_data(client, page, PMBUS_STATUS_BYTE);
-	if (status < 0 || (status & PB_STATUS_CML)) {
-		status2 = pmbus_read_byte_data(client, page, PMBUS_STATUS_CML);
-		if (status2 < 0 || (status2 & PB_CML_FAULT_INVALID_COMMAND))
-			return -EINVAL;
-	}
-	return 0;
-}
-
-bool pmbus_check_byte_register(struct i2c_client *client, int page, int reg)
-{
-	int rv;
-	struct pmbus_data *data = i2c_get_clientdata(client);
-
-	rv = pmbus_read_byte_data(client, page, reg);
-	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
-		rv = pmbus_check_status_cml(client, page);
-	pmbus_clear_fault_page(client, page);
-	return rv >= 0;
-}
-EXPORT_SYMBOL_GPL(pmbus_check_byte_register);
-
-bool pmbus_check_word_register(struct i2c_client *client, int page, int reg)
-{
-	int rv;
-	struct pmbus_data *data = i2c_get_clientdata(client);
-
-	rv = pmbus_read_word_data(client, page, reg);
-	if (rv >= 0 && !(data->flags & PMBUS_SKIP_STATUS_CHECK))
-		rv = pmbus_check_status_cml(client, page);
-	pmbus_clear_fault_page(client, page);
-	return rv >= 0;
-}
-EXPORT_SYMBOL_GPL(pmbus_check_word_register);
-
-const struct pmbus_driver_info *pmbus_get_driver_info(struct i2c_client *client)
-{
-	struct pmbus_data *data = i2c_get_clientdata(client);
-
-	return data->info;
-}
-EXPORT_SYMBOL_GPL(pmbus_get_driver_info);
-
-/*
- * _pmbus_read_byte_data() is similar to pmbus_read_byte_data(), but checks if
- * a device specific mapping funcion exists and calls it if necessary.
- */
-static int _pmbus_read_byte_data(struct i2c_client *client, int page, int reg)
-{
-	struct pmbus_data *data = i2c_get_clientdata(client);
-	const struct pmbus_driver_info *info = data->info;
-	int status;
-
-	if (info->read_byte_data) {
-		status = info->read_byte_data(client, page, reg);
-		if (status != -ENODATA)
-			return status;
-	}
-	return pmbus_read_byte_data(client, page, reg);
-}
-
-static struct pmbus_data *pmbus_update_device(struct device *dev)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pmbus_data *data = i2c_get_clientdata(client);
-	const struct pmbus_driver_info *info = data->info;
-
-	mutex_lock(&data->update_lock);
-	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
-		int i;
-
-		for (i = 0; i < info->pages; i++)
-			data->status[PB_STATUS_BASE + i]
-			    = pmbus_read_byte_data(client, i,
-						   PMBUS_STATUS_BYTE);
-		for (i = 0; i < info->pages; i++) {
-			if (!(info->func[i] & PMBUS_HAVE_STATUS_VOUT))
-				continue;
-			data->status[PB_STATUS_VOUT_BASE + i]
-			  = _pmbus_read_byte_data(client, i, PMBUS_STATUS_VOUT);
-		}
-		for (i = 0; i < info->pages; i++) {
-			if (!(info->func[i] & PMBUS_HAVE_STATUS_IOUT))
-				continue;
-			data->status[PB_STATUS_IOUT_BASE + i]
-			  = _pmbus_read_byte_data(client, i, PMBUS_STATUS_IOUT);
-		}
-		for (i = 0; i < info->pages; i++) {
-			if (!(info->func[i] & PMBUS_HAVE_STATUS_TEMP))
-				continue;
-			data->status[PB_STATUS_TEMP_BASE + i]
-			  = _pmbus_read_byte_data(client, i,
-						  PMBUS_STATUS_TEMPERATURE);
-		}
-		for (i = 0; i < info->pages; i++) {
-			if (!(info->func[i] & PMBUS_HAVE_STATUS_FAN12))
-				continue;
-			data->status[PB_STATUS_FAN_BASE + i]
-			  = _pmbus_read_byte_data(client, i,
-						  PMBUS_STATUS_FAN_12);
-		}
-
-		for (i = 0; i < info->pages; i++) {
-			if (!(info->func[i] & PMBUS_HAVE_STATUS_FAN34))
-				continue;
-			data->status[PB_STATUS_FAN34_BASE + i]
-			  = _pmbus_read_byte_data(client, i,
-						  PMBUS_STATUS_FAN_34);
-		}
-
-		if (info->func[0] & PMBUS_HAVE_STATUS_INPUT)
-			data->status[PB_STATUS_INPUT_BASE]
-			  = _pmbus_read_byte_data(client, 0,
-						  PMBUS_STATUS_INPUT);
-
-		for (i = 0; i < data->num_sensors; i++) {
-			struct pmbus_sensor *sensor = &data->sensors[i];
-
-			if (!data->valid || sensor->update)
-				sensor->data
-				    = pmbus_read_word_data(client, sensor->page,
-							   sensor->reg);
-		}
-		pmbus_clear_faults(client);
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-	mutex_unlock(&data->update_lock);
-	return data;
-}
-
-/*
- * Convert linear sensor values to milli- or micro-units
- * depending on sensor type.
- */
-static long pmbus_reg2data_linear(struct pmbus_data *data,
-				  struct pmbus_sensor *sensor)
-{
-	s16 exponent;
-	s32 mantissa;
-	long val;
-
-	if (sensor->class = PSC_VOLTAGE_OUT) {	/* LINEAR16 */
-		exponent = data->exponent;
-		mantissa = (u16) sensor->data;
-	} else {				/* LINEAR11 */
-		exponent = (sensor->data >> 11) & 0x001f;
-		mantissa = sensor->data & 0x07ff;
-
-		if (exponent > 0x0f)
-			exponent |= 0xffe0;	/* sign extend exponent */
-		if (mantissa > 0x03ff)
-			mantissa |= 0xfffff800;	/* sign extend mantissa */
-	}
-
-	val = mantissa;
-
-	/* scale result to milli-units for all sensors except fans */
-	if (sensor->class != PSC_FAN)
-		val = val * 1000L;
-
-	/* scale result to micro-units for power sensors */
-	if (sensor->class = PSC_POWER)
-		val = val * 1000L;
-
-	if (exponent >= 0)
-		val <<= exponent;
-	else
-		val >>= -exponent;
-
-	return val;
-}
-
-/*
- * Convert direct sensor values to milli- or micro-units
- * depending on sensor type.
- */
-static long pmbus_reg2data_direct(struct pmbus_data *data,
-				  struct pmbus_sensor *sensor)
-{
-	long val = (s16) sensor->data;
-	long m, b, R;
-
-	m = data->info->m[sensor->class];
-	b = data->info->b[sensor->class];
-	R = data->info->R[sensor->class];
-
-	if (m = 0)
-		return 0;
-
-	/* X = 1/m * (Y * 10^-R - b) */
-	R = -R;
-	/* scale result to milli-units for everything but fans */
-	if (sensor->class != PSC_FAN) {
-		R += 3;
-		b *= 1000;
-	}
-
-	/* scale result to micro-units for power sensors */
-	if (sensor->class = PSC_POWER) {
-		R += 3;
-		b *= 1000;
-	}
-
-	while (R > 0) {
-		val *= 10;
-		R--;
-	}
-	while (R < 0) {
-		val = DIV_ROUND_CLOSEST(val, 10);
-		R++;
-	}
-
-	return (val - b) / m;
-}
-
-static long pmbus_reg2data(struct pmbus_data *data, struct pmbus_sensor *sensor)
-{
-	long val;
-
-	if (data->info->direct[sensor->class])
-		val = pmbus_reg2data_direct(data, sensor);
-	else
-		val = pmbus_reg2data_linear(data, sensor);
-
-	return val;
-}
-
-#define MAX_MANTISSA	(1023 * 1000)
-#define MIN_MANTISSA	(511 * 1000)
-
-static u16 pmbus_data2reg_linear(struct pmbus_data *data,
-				 enum pmbus_sensor_classes class, long val)
-{
-	s16 exponent = 0, mantissa;
-	bool negative = false;
-
-	/* simple case */
-	if (val = 0)
-		return 0;
-
-	if (class = PSC_VOLTAGE_OUT) {
-		/* LINEAR16 does not support negative voltages */
-		if (val < 0)
-			return 0;
-
-		/*
-		 * For a static exponents, we don't have a choice
-		 * but to adjust the value to it.
-		 */
-		if (data->exponent < 0)
-			val <<= -data->exponent;
-		else
-			val >>= data->exponent;
-		val = DIV_ROUND_CLOSEST(val, 1000);
-		return val & 0xffff;
-	}
-
-	if (val < 0) {
-		negative = true;
-		val = -val;
-	}
-
-	/* Power is in uW. Convert to mW before converting. */
-	if (class = PSC_POWER)
-		val = DIV_ROUND_CLOSEST(val, 1000L);
-
-	/*
-	 * For simplicity, convert fan data to milli-units
-	 * before calculating the exponent.
-	 */
-	if (class = PSC_FAN)
-		val = val * 1000;
-
-	/* Reduce large mantissa until it fits into 10 bit */
-	while (val >= MAX_MANTISSA && exponent < 15) {
-		exponent++;
-		val >>= 1;
-	}
-	/* Increase small mantissa to improve precision */
-	while (val < MIN_MANTISSA && exponent > -15) {
-		exponent--;
-		val <<= 1;
-	}
-
-	/* Convert mantissa from milli-units to units */
-	mantissa = DIV_ROUND_CLOSEST(val, 1000);
-
-	/* Ensure that resulting number is within range */
-	if (mantissa > 0x3ff)
-		mantissa = 0x3ff;
-
-	/* restore sign */
-	if (negative)
-		mantissa = -mantissa;
-
-	/* Convert to 5 bit exponent, 11 bit mantissa */
-	return (mantissa & 0x7ff) | ((exponent << 11) & 0xf800);
-}
-
-static u16 pmbus_data2reg_direct(struct pmbus_data *data,
-				 enum pmbus_sensor_classes class, long val)
-{
-	long m, b, R;
-
-	m = data->info->m[class];
-	b = data->info->b[class];
-	R = data->info->R[class];
-
-	/* Power is in uW. Adjust R and b. */
-	if (class = PSC_POWER) {
-		R -= 3;
-		b *= 1000;
-	}
-
-	/* Calculate Y = (m * X + b) * 10^R */
-	if (class != PSC_FAN) {
-		R -= 3;		/* Adjust R and b for data in milli-units */
-		b *= 1000;
-	}
-	val = val * m + b;
-
-	while (R > 0) {
-		val *= 10;
-		R--;
-	}
-	while (R < 0) {
-		val = DIV_ROUND_CLOSEST(val, 10);
-		R++;
-	}
-
-	return val;
-}
-
-static u16 pmbus_data2reg(struct pmbus_data *data,
-			  enum pmbus_sensor_classes class, long val)
-{
-	u16 regval;
-
-	if (data->info->direct[class])
-		regval = pmbus_data2reg_direct(data, class, val);
-	else
-		regval = pmbus_data2reg_linear(data, class, val);
-
-	return regval;
-}
-
-/*
- * Return boolean calculated from converted data.
- * <index> defines a status register index and mask, and optionally
- * two sensor indexes.
- * The upper half-word references the two sensors,
- * two sensor indices.
- * The upper half-word references the two optional sensors,
- * the lower half word references status register and mask.
- * The function returns true if (status[reg] & mask) is true and,
- * if specified, if v1 >= v2.
- * To determine if an object exceeds upper limits, specify <v, limit>.
- * To determine if an object exceeds lower limits, specify <limit, v>.
- *
- * For booleans created with pmbus_add_boolean_reg(), only the lower 16 bits of
- * index are set. s1 and s2 (the sensor index values) are zero in this case.
- * The function returns true if (status[reg] & mask) is true.
- *
- * If the boolean was created with pmbus_add_boolean_cmp(), a comparison against
- * a specified limit has to be performed to determine the boolean result.
- * In this case, the function returns true if v1 >= v2 (where v1 and v2 are
- * sensor values referenced by sensor indices s1 and s2).
- *
- * To determine if an object exceeds upper limits, specify <s1,s2> = <v,limit>.
- * To determine if an object exceeds lower limits, specify <s1,s2> = <limit,v>.
- *
- * If a negative value is stored in any of the referenced registers, this value
- * reflects an error code which will be returned.
- */
-static int pmbus_get_boolean(struct pmbus_data *data, int index, int *val)
-{
-	u8 s1 = (index >> 24) & 0xff;
-	u8 s2 = (index >> 16) & 0xff;
-	u8 reg = (index >> 8) & 0xff;
-	u8 mask = index & 0xff;
-	int status;
-	u8 regval;
-
-	status = data->status[reg];
-	if (status < 0)
-		return status;
-
-	regval = status & mask;
-	if (!s1 && !s2)
-		*val = !!regval;
-	else {
-		long v1, v2;
-		struct pmbus_sensor *sensor1, *sensor2;
-
-		sensor1 = &data->sensors[s1];
-		if (sensor1->data < 0)
-			return sensor1->data;
-		sensor2 = &data->sensors[s2];
-		if (sensor2->data < 0)
-			return sensor2->data;
-
-		v1 = pmbus_reg2data(data, sensor1);
-		v2 = pmbus_reg2data(data, sensor2);
-		*val = !!(regval && v1 >= v2);
-	}
-	return 0;
-}
-
-static ssize_t pmbus_show_boolean(struct device *dev,
-				  struct device_attribute *da, char *buf)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct pmbus_data *data = pmbus_update_device(dev);
-	int val;
-	int err;
-
-	err = pmbus_get_boolean(data, attr->index, &val);
-	if (err)
-		return err;
-	return snprintf(buf, PAGE_SIZE, "%d\n", val);
-}
-
-static ssize_t pmbus_show_sensor(struct device *dev,
-				 struct device_attribute *da, char *buf)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct pmbus_data *data = pmbus_update_device(dev);
-	struct pmbus_sensor *sensor;
-
-	sensor = &data->sensors[attr->index];
-	if (sensor->data < 0)
-		return sensor->data;
-
-	return snprintf(buf, PAGE_SIZE, "%ld\n", pmbus_reg2data(data, sensor));
-}
-
-static ssize_t pmbus_set_sensor(struct device *dev,
-				struct device_attribute *devattr,
-				const char *buf, size_t count)
-{
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pmbus_data *data = i2c_get_clientdata(client);
-	struct pmbus_sensor *sensor = &data->sensors[attr->index];
-	ssize_t rv = count;
-	long val = 0;
-	int ret;
-	u16 regval;
-
-	if (strict_strtol(buf, 10, &val) < 0)
-		return -EINVAL;
-
-	mutex_lock(&data->update_lock);
-	regval = pmbus_data2reg(data, sensor->class, val);
-	ret = pmbus_write_word_data(client, sensor->page, sensor->reg, regval);
-	if (ret < 0)
-		rv = ret;
-	else
-		data->sensors[attr->index].data = regval;
-	mutex_unlock(&data->update_lock);
-	return rv;
-}
-
-static ssize_t pmbus_show_label(struct device *dev,
-				struct device_attribute *da, char *buf)
-{
-	struct i2c_client *client = to_i2c_client(dev);
-	struct pmbus_data *data = i2c_get_clientdata(client);
-	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-
-	return snprintf(buf, PAGE_SIZE, "%s\n",
-			data->labels[attr->index].label);
-}
-
-#define PMBUS_ADD_ATTR(data, _name, _idx, _mode, _type, _show, _set)	\
-do {									\
-	struct sensor_device_attribute *a				\
-	    = &data->_type##s[data->num_##_type##s].attribute;		\
-	BUG_ON(data->num_attributes >= data->max_attributes);		\
-	sysfs_attr_init(&a->dev_attr.attr);				\
-	a->dev_attr.attr.name = _name;					\
-	a->dev_attr.attr.mode = _mode;					\
-	a->dev_attr.show = _show;					\
-	a->dev_attr.store = _set;					\
-	a->index = _idx;						\
-	data->attributes[data->num_attributes] = &a->dev_attr.attr;	\
-	data->num_attributes++;						\
-} while (0)
-
-#define PMBUS_ADD_GET_ATTR(data, _name, _type, _idx)			\
-	PMBUS_ADD_ATTR(data, _name, _idx, S_IRUGO, _type,		\
-		       pmbus_show_##_type,  NULL)
-
-#define PMBUS_ADD_SET_ATTR(data, _name, _type, _idx)			\
-	PMBUS_ADD_ATTR(data, _name, _idx, S_IWUSR | S_IRUGO, _type,	\
-		       pmbus_show_##_type, pmbus_set_##_type)
-
-static void pmbus_add_boolean(struct pmbus_data *data,
-			      const char *name, const char *type, int seq,
-			      int idx)
-{
-	struct pmbus_boolean *boolean;
-
-	BUG_ON(data->num_booleans >= data->max_booleans);
-
-	boolean = &data->booleans[data->num_booleans];
-
-	snprintf(boolean->name, sizeof(boolean->name), "%s%d_%s",
-		 name, seq, type);
-	PMBUS_ADD_GET_ATTR(data, boolean->name, boolean, idx);
-	data->num_booleans++;
-}
-
-static void pmbus_add_boolean_reg(struct pmbus_data *data,
-				  const char *name, const char *type,
-				  int seq, int reg, int bit)
-{
-	pmbus_add_boolean(data, name, type, seq, (reg << 8) | bit);
-}
-
-static void pmbus_add_boolean_cmp(struct pmbus_data *data,
-				  const char *name, const char *type,
-				  int seq, int i1, int i2, int reg, int mask)
-{
-	pmbus_add_boolean(data, name, type, seq,
-			  (i1 << 24) | (i2 << 16) | (reg << 8) | mask);
-}
-
-static void pmbus_add_sensor(struct pmbus_data *data,
-			     const char *name, const char *type, int seq,
-			     int page, int reg, enum pmbus_sensor_classes class,
-			     bool update, bool readonly)
-{
-	struct pmbus_sensor *sensor;
-
-	BUG_ON(data->num_sensors >= data->max_sensors);
-
-	sensor = &data->sensors[data->num_sensors];
-	snprintf(sensor->name, sizeof(sensor->name), "%s%d_%s",
-		 name, seq, type);
-	sensor->page = page;
-	sensor->reg = reg;
-	sensor->class = class;
-	sensor->update = update;
-	if (readonly)
-		PMBUS_ADD_GET_ATTR(data, sensor->name, sensor,
-				   data->num_sensors);
-	else
-		PMBUS_ADD_SET_ATTR(data, sensor->name, sensor,
-				   data->num_sensors);
-	data->num_sensors++;
-}
-
-static void pmbus_add_label(struct pmbus_data *data,
-			    const char *name, int seq,
-			    const char *lstring, int index)
-{
-	struct pmbus_label *label;
-
-	BUG_ON(data->num_labels >= data->max_labels);
-
-	label = &data->labels[data->num_labels];
-	snprintf(label->name, sizeof(label->name), "%s%d_label", name, seq);
-	if (!index)
-		strncpy(label->label, lstring, sizeof(label->label) - 1);
-	else
-		snprintf(label->label, sizeof(label->label), "%s%d", lstring,
-			 index);
-
-	PMBUS_ADD_GET_ATTR(data, label->name, label, data->num_labels);
-	data->num_labels++;
-}
-
-/*
- * Determine maximum number of sensors, booleans, and labels.
- * To keep things simple, only make a rough high estimate.
- */
-static void pmbus_find_max_attr(struct i2c_client *client,
-				struct pmbus_data *data)
-{
-	const struct pmbus_driver_info *info = data->info;
-	int page, max_sensors, max_booleans, max_labels;
-
-	max_sensors = PMBUS_MAX_INPUT_SENSORS;
-	max_booleans = PMBUS_MAX_INPUT_BOOLEANS;
-	max_labels = PMBUS_MAX_INPUT_LABELS;
-
-	for (page = 0; page < info->pages; page++) {
-		if (info->func[page] & PMBUS_HAVE_VOUT) {
-			max_sensors += PMBUS_VOUT_SENSORS_PER_PAGE;
-			max_booleans += PMBUS_VOUT_BOOLEANS_PER_PAGE;
-			max_labels++;
-		}
-		if (info->func[page] & PMBUS_HAVE_IOUT) {
-			max_sensors += PMBUS_IOUT_SENSORS_PER_PAGE;
-			max_booleans += PMBUS_IOUT_BOOLEANS_PER_PAGE;
-			max_labels++;
-		}
-		if (info->func[page] & PMBUS_HAVE_POUT) {
-			max_sensors += PMBUS_POUT_SENSORS_PER_PAGE;
-			max_booleans += PMBUS_POUT_BOOLEANS_PER_PAGE;
-			max_labels++;
-		}
-		if (info->func[page] & PMBUS_HAVE_FAN12) {
-			max_sensors += 2 * PMBUS_MAX_SENSORS_PER_FAN;
-			max_booleans += 2 * PMBUS_MAX_BOOLEANS_PER_FAN;
-		}
-		if (info->func[page] & PMBUS_HAVE_FAN34) {
-			max_sensors += 2 * PMBUS_MAX_SENSORS_PER_FAN;
-			max_booleans += 2 * PMBUS_MAX_BOOLEANS_PER_FAN;
-		}
-		if (info->func[page] & PMBUS_HAVE_TEMP) {
-			max_sensors += PMBUS_MAX_SENSORS_PER_TEMP;
-			max_booleans += PMBUS_MAX_BOOLEANS_PER_TEMP;
-		}
-		if (info->func[page] & PMBUS_HAVE_TEMP2) {
-			max_sensors += PMBUS_MAX_SENSORS_PER_TEMP;
-			max_booleans += PMBUS_MAX_BOOLEANS_PER_TEMP;
-		}
-		if (info->func[page] & PMBUS_HAVE_TEMP3) {
-			max_sensors += PMBUS_MAX_SENSORS_PER_TEMP;
-			max_booleans += PMBUS_MAX_BOOLEANS_PER_TEMP;
-		}
-	}
-	data->max_sensors = max_sensors;
-	data->max_booleans = max_booleans;
-	data->max_labels = max_labels;
-	data->max_attributes = max_sensors + max_booleans + max_labels;
-}
-
-/*
- * Search for attributes. Allocate sensors, booleans, and labels as needed.
- */
-
-/*
- * The pmbus_limit_attr structure describes a single limit attribute
- * and its associated alarm attribute.
- */
-struct pmbus_limit_attr {
-	u8 reg;			/* Limit register */
-	const char *attr;	/* Attribute name */
-	const char *alarm;	/* Alarm attribute name */
-	u32 sbit;		/* Alarm attribute status bit */
-};
-
-/*
- * The pmbus_sensor_attr structure describes one sensor attribute. This
- * description includes a reference to the associated limit attributes.
- */
-struct pmbus_sensor_attr {
-	u8 reg;				/* sensor register */
-	enum pmbus_sensor_classes class;/* sensor class */
-	const char *label;		/* sensor label */
-	bool paged;			/* true if paged sensor */
-	bool update;			/* true if update needed */
-	bool compare;			/* true if compare function needed */
-	u32 func;			/* sensor mask */
-	u32 sfunc;			/* sensor status mask */
-	int sbase;			/* status base register */
-	u32 gbit;			/* generic status bit */
-	const struct pmbus_limit_attr *limit;/* limit registers */
-	int nlimit;			/* # of limit registers */
-};
-
-/*
- * Add a set of limit attributes and, if supported, the associated
- * alarm attributes.
- */
-static bool pmbus_add_limit_attrs(struct i2c_client *client,
-				  struct pmbus_data *data,
-				  const struct pmbus_driver_info *info,
-				  const char *name, int index, int page,
-				  int cbase,
-				  const struct pmbus_sensor_attr *attr)
-{
-	const struct pmbus_limit_attr *l = attr->limit;
-	int nlimit = attr->nlimit;
-	bool have_alarm = false;
-	int i, cindex;
-
-	for (i = 0; i < nlimit; i++) {
-		if (pmbus_check_word_register(client, page, l->reg)) {
-			cindex = data->num_sensors;
-			pmbus_add_sensor(data, name, l->attr, index, page,
-					 l->reg, attr->class, attr->update,
-					 false);
-			if (info->func[page] & attr->sfunc) {
-				if (attr->compare) {
-					pmbus_add_boolean_cmp(data, name,
-						l->alarm, index,
-						cbase, cindex,
-						attr->sbase + page, l->sbit);
-				} else {
-					pmbus_add_boolean_reg(data, name,
-						l->alarm, index,
-						attr->sbase + page, l->sbit);
-				}
-				have_alarm = true;
-			}
-		}
-		l++;
-	}
-	return have_alarm;
-}
-
-static void pmbus_add_sensor_attrs_one(struct i2c_client *client,
-				       struct pmbus_data *data,
-				       const struct pmbus_driver_info *info,
-				       const char *name,
-				       int index, int page,
-				       const struct pmbus_sensor_attr *attr)
-{
-	bool have_alarm;
-	int cbase = data->num_sensors;
-
-	if (attr->label)
-		pmbus_add_label(data, name, index, attr->label,
-				attr->paged ? page + 1 : 0);
-	pmbus_add_sensor(data, name, "input", index, page, attr->reg,
-			 attr->class, true, true);
-	if (attr->sfunc) {
-		have_alarm = pmbus_add_limit_attrs(client, data, info, name,
-						   index, page, cbase, attr);
-		/*
-		 * Add generic alarm attribute only if there are no individual
-		 * alarm attributes, and if there is a global alarm bit.
-		 */
-		if (!have_alarm && attr->gbit)
-			pmbus_add_boolean_reg(data, name, "alarm", index,
-					      PB_STATUS_BASE + page,
-					      attr->gbit);
-	}
-}
-
-static void pmbus_add_sensor_attrs(struct i2c_client *client,
-				   struct pmbus_data *data,
-				   const char *name,
-				   const struct pmbus_sensor_attr *attrs,
-				   int nattrs)
-{
-	const struct pmbus_driver_info *info = data->info;
-	int index, i;
-
-	index = 1;
-	for (i = 0; i < nattrs; i++) {
-		int page, pages;
-
-		pages = attrs->paged ? info->pages : 1;
-		for (page = 0; page < pages; page++) {
-			if (!(info->func[page] & attrs->func))
-				continue;
-			pmbus_add_sensor_attrs_one(client, data, info, name,
-						   index, page, attrs);
-			index++;
-		}
-		attrs++;
-	}
-}
-
-static const struct pmbus_limit_attr vin_limit_attrs[] = {
-	{
-		.reg = PMBUS_VIN_UV_WARN_LIMIT,
-		.attr = "min",
-		.alarm = "min_alarm",
-		.sbit = PB_VOLTAGE_UV_WARNING,
-	}, {
-		.reg = PMBUS_VIN_UV_FAULT_LIMIT,
-		.attr = "lcrit",
-		.alarm = "lcrit_alarm",
-		.sbit = PB_VOLTAGE_UV_FAULT,
-	}, {
-		.reg = PMBUS_VIN_OV_WARN_LIMIT,
-		.attr = "max",
-		.alarm = "max_alarm",
-		.sbit = PB_VOLTAGE_OV_WARNING,
-	}, {
-		.reg = PMBUS_VIN_OV_FAULT_LIMIT,
-		.attr = "crit",
-		.alarm = "crit_alarm",
-		.sbit = PB_VOLTAGE_OV_FAULT,
-	},
-};
-
-static const struct pmbus_limit_attr vout_limit_attrs[] = {
-	{
-		.reg = PMBUS_VOUT_UV_WARN_LIMIT,
-		.attr = "min",
-		.alarm = "min_alarm",
-		.sbit = PB_VOLTAGE_UV_WARNING,
-	}, {
-		.reg = PMBUS_VOUT_UV_FAULT_LIMIT,
-		.attr = "lcrit",
-		.alarm = "lcrit_alarm",
-		.sbit = PB_VOLTAGE_UV_FAULT,
-	}, {
-		.reg = PMBUS_VOUT_OV_WARN_LIMIT,
-		.attr = "max",
-		.alarm = "max_alarm",
-		.sbit = PB_VOLTAGE_OV_WARNING,
-	}, {
-		.reg = PMBUS_VOUT_OV_FAULT_LIMIT,
-		.attr = "crit",
-		.alarm = "crit_alarm",
-		.sbit = PB_VOLTAGE_OV_FAULT,
-	}
-};
-
-static const struct pmbus_sensor_attr voltage_attributes[] = {
-	{
-		.reg = PMBUS_READ_VIN,
-		.class = PSC_VOLTAGE_IN,
-		.label = "vin",
-		.func = PMBUS_HAVE_VIN,
-		.sfunc = PMBUS_HAVE_STATUS_INPUT,
-		.sbase = PB_STATUS_INPUT_BASE,
-		.gbit = PB_STATUS_VIN_UV,
-		.limit = vin_limit_attrs,
-		.nlimit = ARRAY_SIZE(vin_limit_attrs),
-	}, {
-		.reg = PMBUS_READ_VCAP,
-		.class = PSC_VOLTAGE_IN,
-		.label = "vcap",
-		.func = PMBUS_HAVE_VCAP,
-	}, {
-		.reg = PMBUS_READ_VOUT,
-		.class = PSC_VOLTAGE_OUT,
-		.label = "vout",
-		.paged = true,
-		.func = PMBUS_HAVE_VOUT,
-		.sfunc = PMBUS_HAVE_STATUS_VOUT,
-		.sbase = PB_STATUS_VOUT_BASE,
-		.gbit = PB_STATUS_VOUT_OV,
-		.limit = vout_limit_attrs,
-		.nlimit = ARRAY_SIZE(vout_limit_attrs),
-	}
-};
-
-/* Current attributes */
-
-static const struct pmbus_limit_attr iin_limit_attrs[] = {
-	{
-		.reg = PMBUS_IIN_OC_WARN_LIMIT,
-		.attr = "max",
-		.alarm = "max_alarm",
-		.sbit = PB_IIN_OC_WARNING,
-	}, {
-		.reg = PMBUS_IIN_OC_FAULT_LIMIT,
-		.attr = "crit",
-		.alarm = "crit_alarm",
-		.sbit = PB_IIN_OC_FAULT,
-	}
-};
-
-static const struct pmbus_limit_attr iout_limit_attrs[] = {
-	{
-		.reg = PMBUS_IOUT_OC_WARN_LIMIT,
-		.attr = "max",
-		.alarm = "max_alarm",
-		.sbit = PB_IOUT_OC_WARNING,
-	}, {
-		.reg = PMBUS_IOUT_UC_FAULT_LIMIT,
-		.attr = "lcrit",
-		.alarm = "lcrit_alarm",
-		.sbit = PB_IOUT_UC_FAULT,
-	}, {
-		.reg = PMBUS_IOUT_OC_FAULT_LIMIT,
-		.attr = "crit",
-		.alarm = "crit_alarm",
-		.sbit = PB_IOUT_OC_FAULT,
-	}
-};
-
-static const struct pmbus_sensor_attr current_attributes[] = {
-	{
-		.reg = PMBUS_READ_IIN,
-		.class = PSC_CURRENT_IN,
-		.label = "iin",
-		.func = PMBUS_HAVE_IIN,
-		.sfunc = PMBUS_HAVE_STATUS_INPUT,
-		.sbase = PB_STATUS_INPUT_BASE,
-		.limit = iin_limit_attrs,
-		.nlimit = ARRAY_SIZE(iin_limit_attrs),
-	}, {
-		.reg = PMBUS_READ_IOUT,
-		.class = PSC_CURRENT_OUT,
-		.label = "iout",
-		.paged = true,
-		.func = PMBUS_HAVE_IOUT,
-		.sfunc = PMBUS_HAVE_STATUS_IOUT,
-		.sbase = PB_STATUS_IOUT_BASE,
-		.gbit = PB_STATUS_IOUT_OC,
-		.limit = iout_limit_attrs,
-		.nlimit = ARRAY_SIZE(iout_limit_attrs),
-	}
-};
-
-/* Power attributes */
-
-static const struct pmbus_limit_attr pin_limit_attrs[] = {
-	{
-		.reg = PMBUS_PIN_OP_WARN_LIMIT,
-		.attr = "max",
-		.alarm = "alarm",
-		.sbit = PB_PIN_OP_WARNING,
-	}
-};
-
-static const struct pmbus_limit_attr pout_limit_attrs[] = {
-	{
-		.reg = PMBUS_POUT_MAX,
-		.attr = "cap",
-		.alarm = "cap_alarm",
-		.sbit = PB_POWER_LIMITING,
-	}, {
-		.reg = PMBUS_POUT_OP_WARN_LIMIT,
-		.attr = "max",
-		.alarm = "max_alarm",
-		.sbit = PB_POUT_OP_WARNING,
-	}, {
-		.reg = PMBUS_POUT_OP_FAULT_LIMIT,
-		.attr = "crit",
-		.alarm = "crit_alarm",
-		.sbit = PB_POUT_OP_FAULT,
-	}
-};
-
-static const struct pmbus_sensor_attr power_attributes[] = {
-	{
-		.reg = PMBUS_READ_PIN,
-		.class = PSC_POWER,
-		.label = "pin",
-		.func = PMBUS_HAVE_PIN,
-		.sfunc = PMBUS_HAVE_STATUS_INPUT,
-		.sbase = PB_STATUS_INPUT_BASE,
-		.limit = pin_limit_attrs,
-		.nlimit = ARRAY_SIZE(pin_limit_attrs),
-	}, {
-		.reg = PMBUS_READ_POUT,
-		.class = PSC_POWER,
-		.label = "pout",
-		.paged = true,
-		.func = PMBUS_HAVE_POUT,
-		.sfunc = PMBUS_HAVE_STATUS_IOUT,
-		.sbase = PB_STATUS_IOUT_BASE,
-		.limit = pout_limit_attrs,
-		.nlimit = ARRAY_SIZE(pout_limit_attrs),
-	}
-};
-
-/* Temperature atributes */
-
-static const struct pmbus_limit_attr temp_limit_attrs[] = {
-	{
-		.reg = PMBUS_UT_WARN_LIMIT,
-		.attr = "min",
-		.alarm = "min_alarm",
-		.sbit = PB_TEMP_UT_WARNING,
-	}, {
-		.reg = PMBUS_UT_FAULT_LIMIT,
-		.attr = "lcrit",
-		.alarm = "lcrit_alarm",
-		.sbit = PB_TEMP_UT_FAULT,
-	}, {
-		.reg = PMBUS_OT_WARN_LIMIT,
-		.attr = "max",
-		.alarm = "max_alarm",
-		.sbit = PB_TEMP_OT_WARNING,
-	}, {
-		.reg = PMBUS_OT_FAULT_LIMIT,
-		.attr = "crit",
-		.alarm = "crit_alarm",
-		.sbit = PB_TEMP_OT_FAULT,
-	}
-};
-
-static const struct pmbus_sensor_attr temp_attributes[] = {
-	{
-		.reg = PMBUS_READ_TEMPERATURE_1,
-		.class = PSC_TEMPERATURE,
-		.paged = true,
-		.update = true,
-		.compare = true,
-		.func = PMBUS_HAVE_TEMP,
-		.sfunc = PMBUS_HAVE_STATUS_TEMP,
-		.sbase = PB_STATUS_TEMP_BASE,
-		.gbit = PB_STATUS_TEMPERATURE,
-		.limit = temp_limit_attrs,
-		.nlimit = ARRAY_SIZE(temp_limit_attrs),
-	}, {
-		.reg = PMBUS_READ_TEMPERATURE_2,
-		.class = PSC_TEMPERATURE,
-		.paged = true,
-		.update = true,
-		.compare = true,
-		.func = PMBUS_HAVE_TEMP2,
-		.sfunc = PMBUS_HAVE_STATUS_TEMP,
-		.sbase = PB_STATUS_TEMP_BASE,
-		.gbit = PB_STATUS_TEMPERATURE,
-		.limit = temp_limit_attrs,
-		.nlimit = ARRAY_SIZE(temp_limit_attrs),
-	}, {
-		.reg = PMBUS_READ_TEMPERATURE_3,
-		.class = PSC_TEMPERATURE,
-		.paged = true,
-		.update = true,
-		.compare = true,
-		.func = PMBUS_HAVE_TEMP3,
-		.sfunc = PMBUS_HAVE_STATUS_TEMP,
-		.sbase = PB_STATUS_TEMP_BASE,
-		.gbit = PB_STATUS_TEMPERATURE,
-		.limit = temp_limit_attrs,
-		.nlimit = ARRAY_SIZE(temp_limit_attrs),
-	}
-};
-
-static const int pmbus_fan_registers[] = {
-	PMBUS_READ_FAN_SPEED_1,
-	PMBUS_READ_FAN_SPEED_2,
-	PMBUS_READ_FAN_SPEED_3,
-	PMBUS_READ_FAN_SPEED_4
-};
-
-static const int pmbus_fan_config_registers[] = {
-	PMBUS_FAN_CONFIG_12,
-	PMBUS_FAN_CONFIG_12,
-	PMBUS_FAN_CONFIG_34,
-	PMBUS_FAN_CONFIG_34
-};
-
-static const int pmbus_fan_status_registers[] = {
-	PMBUS_STATUS_FAN_12,
-	PMBUS_STATUS_FAN_12,
-	PMBUS_STATUS_FAN_34,
-	PMBUS_STATUS_FAN_34
-};
-
-static const u32 pmbus_fan_flags[] = {
-	PMBUS_HAVE_FAN12,
-	PMBUS_HAVE_FAN12,
-	PMBUS_HAVE_FAN34,
-	PMBUS_HAVE_FAN34
-};
-
-static const u32 pmbus_fan_status_flags[] = {
-	PMBUS_HAVE_STATUS_FAN12,
-	PMBUS_HAVE_STATUS_FAN12,
-	PMBUS_HAVE_STATUS_FAN34,
-	PMBUS_HAVE_STATUS_FAN34
-};
-
-/* Fans */
-static void pmbus_add_fan_attributes(struct i2c_client *client,
-				     struct pmbus_data *data)
-{
-	const struct pmbus_driver_info *info = data->info;
-	int index = 1;
-	int page;
-
-	for (page = 0; page < info->pages; page++) {
-		int f;
-
-		for (f = 0; f < ARRAY_SIZE(pmbus_fan_registers); f++) {
-			int regval;
-
-			if (!(info->func[page] & pmbus_fan_flags[f]))
-				break;
-
-			if (!pmbus_check_word_register(client, page,
-						       pmbus_fan_registers[f]))
-				break;
-
-			/*
-			 * Skip fan if not installed.
-			 * Each fan configuration register covers multiple fans,
-			 * so we have to do some magic.
-			 */
-			regval = _pmbus_read_byte_data(client, page,
-				pmbus_fan_config_registers[f]);
-			if (regval < 0 ||
-			    (!(regval & (PB_FAN_1_INSTALLED >> ((f & 1) * 4)))))
-				continue;
-
-			pmbus_add_sensor(data, "fan", "input", index, page,
-					 pmbus_fan_registers[f], PSC_FAN, true,
-					 true);
-
-			/*
-			 * Each fan status register covers multiple fans,
-			 * so we have to do some magic.
-			 */
-			if ((info->func[page] & pmbus_fan_status_flags[f]) &&
-			    pmbus_check_byte_register(client,
-					page, pmbus_fan_status_registers[f])) {
-				int base;
-
-				if (f > 1)	/* fan 3, 4 */
-					base = PB_STATUS_FAN34_BASE + page;
-				else
-					base = PB_STATUS_FAN_BASE + page;
-				pmbus_add_boolean_reg(data, "fan", "alarm",
-					index, base,
-					PB_FAN_FAN1_WARNING >> (f & 1));
-				pmbus_add_boolean_reg(data, "fan", "fault",
-					index, base,
-					PB_FAN_FAN1_FAULT >> (f & 1));
-			}
-			index++;
-		}
-	}
-}
-
-static void pmbus_find_attributes(struct i2c_client *client,
-				  struct pmbus_data *data)
-{
-	/* Voltage sensors */
-	pmbus_add_sensor_attrs(client, data, "in", voltage_attributes,
-			       ARRAY_SIZE(voltage_attributes));
-
-	/* Current sensors */
-	pmbus_add_sensor_attrs(client, data, "curr", current_attributes,
-			       ARRAY_SIZE(current_attributes));
-
-	/* Power sensors */
-	pmbus_add_sensor_attrs(client, data, "power", power_attributes,
-			       ARRAY_SIZE(power_attributes));
-
-	/* Temperature sensors */
-	pmbus_add_sensor_attrs(client, data, "temp", temp_attributes,
-			       ARRAY_SIZE(temp_attributes));
-
-	/* Fans */
-	pmbus_add_fan_attributes(client, data);
-}
-
-/*
- * Identify chip parameters.
- * This function is called for all chips.
- */
-static int pmbus_identify_common(struct i2c_client *client,
-				 struct pmbus_data *data)
-{
-	int vout_mode = -1, exponent;
-
-	if (pmbus_check_byte_register(client, 0, PMBUS_VOUT_MODE))
-		vout_mode = pmbus_read_byte_data(client, 0, PMBUS_VOUT_MODE);
-	if (vout_mode >= 0 && vout_mode != 0xff) {
-		/*
-		 * Not all chips support the VOUT_MODE command,
-		 * so a failure to read it is not an error.
-		 */
-		switch (vout_mode >> 5) {
-		case 0:	/* linear mode      */
-			if (data->info->direct[PSC_VOLTAGE_OUT])
-				return -ENODEV;
-
-			exponent = vout_mode & 0x1f;
-			/* and sign-extend it */
-			if (exponent & 0x10)
-				exponent |= ~0x1f;
-			data->exponent = exponent;
-			break;
-		case 2:	/* direct mode      */
-			if (!data->info->direct[PSC_VOLTAGE_OUT])
-				return -ENODEV;
-			break;
-		default:
-			return -ENODEV;
-		}
-	}
-
-	/* Determine maximum number of sensors, booleans, and labels */
-	pmbus_find_max_attr(client, data);
-	pmbus_clear_fault_page(client, 0);
-	return 0;
-}
-
-int pmbus_do_probe(struct i2c_client *client, const struct i2c_device_id *id,
-		   struct pmbus_driver_info *info)
-{
-	const struct pmbus_platform_data *pdata = client->dev.platform_data;
-	struct pmbus_data *data;
-	int ret;
-
-	if (!info) {
-		dev_err(&client->dev, "Missing chip information");
-		return -ENODEV;
-	}
-
-	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WRITE_BYTE
-				     | I2C_FUNC_SMBUS_BYTE_DATA
-				     | I2C_FUNC_SMBUS_WORD_DATA))
-		return -ENODEV;
-
-	data = kzalloc(sizeof(*data), GFP_KERNEL);
-	if (!data) {
-		dev_err(&client->dev, "No memory to allocate driver data\n");
-		return -ENOMEM;
-	}
-
-	i2c_set_clientdata(client, data);
-	mutex_init(&data->update_lock);
-
-	/* Bail out if PMBus status register does not exist. */
-	if (i2c_smbus_read_byte_data(client, PMBUS_STATUS_BYTE) < 0) {
-		dev_err(&client->dev, "PMBus status register not found\n");
-		ret = -ENODEV;
-		goto out_data;
-	}
-
-	if (pdata)
-		data->flags = pdata->flags;
-	data->info = info;
-
-	pmbus_clear_faults(client);
-
-	if (info->identify) {
-		ret = (*info->identify)(client, info);
-		if (ret < 0) {
-			dev_err(&client->dev, "Chip identification failed\n");
-			goto out_data;
-		}
-	}
-
-	if (info->pages <= 0 || info->pages > PMBUS_PAGES) {
-		dev_err(&client->dev, "Bad number of PMBus pages: %d\n",
-			info->pages);
-		ret = -EINVAL;
-		goto out_data;
-	}
-	/*
-	 * Bail out if more than one page was configured, but we can not
-	 * select the highest page. This is an indication that the wrong
-	 * chip type was selected. Better bail out now than keep
-	 * returning errors later on.
-	 */
-	if (info->pages > 1 && pmbus_set_page(client, info->pages - 1) < 0) {
-		dev_err(&client->dev, "Failed to select page %d\n",
-			info->pages - 1);
-		ret = -EINVAL;
-		goto out_data;
-	}
-
-	ret = pmbus_identify_common(client, data);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to identify chip capabilities\n");
-		goto out_data;
-	}
-
-	ret = -ENOMEM;
-	data->sensors = kzalloc(sizeof(struct pmbus_sensor) * data->max_sensors,
-				GFP_KERNEL);
-	if (!data->sensors) {
-		dev_err(&client->dev, "No memory to allocate sensor data\n");
-		goto out_data;
-	}
-
-	data->booleans = kzalloc(sizeof(struct pmbus_boolean)
-				 * data->max_booleans, GFP_KERNEL);
-	if (!data->booleans) {
-		dev_err(&client->dev, "No memory to allocate boolean data\n");
-		goto out_sensors;
-	}
-
-	data->labels = kzalloc(sizeof(struct pmbus_label) * data->max_labels,
-			       GFP_KERNEL);
-	if (!data->labels) {
-		dev_err(&client->dev, "No memory to allocate label data\n");
-		goto out_booleans;
-	}
-
-	data->attributes = kzalloc(sizeof(struct attribute *)
-				   * data->max_attributes, GFP_KERNEL);
-	if (!data->attributes) {
-		dev_err(&client->dev, "No memory to allocate attribute data\n");
-		goto out_labels;
-	}
-
-	pmbus_find_attributes(client, data);
-
-	/*
-	 * If there are no attributes, something is wrong.
-	 * Bail out instead of trying to register nothing.
-	 */
-	if (!data->num_attributes) {
-		dev_err(&client->dev, "No attributes found\n");
-		ret = -ENODEV;
-		goto out_attributes;
-	}
-
-	/* Register sysfs hooks */
-	data->group.attrs = data->attributes;
-	ret = sysfs_create_group(&client->dev.kobj, &data->group);
-	if (ret) {
-		dev_err(&client->dev, "Failed to create sysfs entries\n");
-		goto out_attributes;
-	}
-	data->hwmon_dev = hwmon_device_register(&client->dev);
-	if (IS_ERR(data->hwmon_dev)) {
-		ret = PTR_ERR(data->hwmon_dev);
-		dev_err(&client->dev, "Failed to register hwmon device\n");
-		goto out_hwmon_device_register;
-	}
-	return 0;
-
-out_hwmon_device_register:
-	sysfs_remove_group(&client->dev.kobj, &data->group);
-out_attributes:
-	kfree(data->attributes);
-out_labels:
-	kfree(data->labels);
-out_booleans:
-	kfree(data->booleans);
-out_sensors:
-	kfree(data->sensors);
-out_data:
-	kfree(data);
-	return ret;
-}
-EXPORT_SYMBOL_GPL(pmbus_do_probe);
-
-int pmbus_do_remove(struct i2c_client *client)
-{
-	struct pmbus_data *data = i2c_get_clientdata(client);
-	hwmon_device_unregister(data->hwmon_dev);
-	sysfs_remove_group(&client->dev.kobj, &data->group);
-	kfree(data->attributes);
-	kfree(data->labels);
-	kfree(data->booleans);
-	kfree(data->sensors);
-	kfree(data);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(pmbus_do_remove);
-
-MODULE_AUTHOR("Guenter Roeck");
-MODULE_DESCRIPTION("PMBus core driver");
-MODULE_LICENSE("GPL");
diff --git a/drivers/hwmon/ucd9000.c b/drivers/hwmon/ucd9000.c
deleted file mode 100644
index ace1c73..0000000
--- a/drivers/hwmon/ucd9000.c
+++ /dev/null
@@ -1,278 +0,0 @@
-/*
- * Hardware monitoring driver for UCD90xxx Sequencer and System Health
- * Controller series
- *
- * Copyright (C) 2011 Ericsson AB.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/i2c/pmbus.h>
-#include "pmbus.h"
-
-enum chips { ucd9000, ucd90120, ucd90124, ucd9090, ucd90910 };
-
-#define UCD9000_MONITOR_CONFIG		0xd5
-#define UCD9000_NUM_PAGES		0xd6
-#define UCD9000_FAN_CONFIG_INDEX	0xe7
-#define UCD9000_FAN_CONFIG		0xe8
-#define UCD9000_DEVICE_ID		0xfd
-
-#define UCD9000_MON_TYPE(x)	(((x) >> 5) & 0x07)
-#define UCD9000_MON_PAGE(x)	((x) & 0x0f)
-
-#define UCD9000_MON_VOLTAGE	1
-#define UCD9000_MON_TEMPERATURE	2
-#define UCD9000_MON_CURRENT	3
-#define UCD9000_MON_VOLTAGE_HW	4
-
-#define UCD9000_NUM_FAN		4
-
-struct ucd9000_data {
-	u8 fan_data[UCD9000_NUM_FAN][I2C_SMBUS_BLOCK_MAX];
-	struct pmbus_driver_info info;
-};
-#define to_ucd9000_data(_info) container_of(_info, struct ucd9000_data, info)
-
-static int ucd9000_get_fan_config(struct i2c_client *client, int fan)
-{
-	int fan_config = 0;
-	struct ucd9000_data *data
-	  = to_ucd9000_data(pmbus_get_driver_info(client));
-
-	if (data->fan_data[fan][3] & 1)
-		fan_config |= PB_FAN_2_INSTALLED;   /* Use lower bit position */
-
-	/* Pulses/revolution */
-	fan_config |= (data->fan_data[fan][3] & 0x06) >> 1;
-
-	return fan_config;
-}
-
-static int ucd9000_read_byte_data(struct i2c_client *client, int page, int reg)
-{
-	int ret = 0;
-	int fan_config;
-
-	switch (reg) {
-	case PMBUS_FAN_CONFIG_12:
-		if (page)
-			return -EINVAL;
-
-		ret = ucd9000_get_fan_config(client, 0);
-		if (ret < 0)
-			return ret;
-		fan_config = ret << 4;
-		ret = ucd9000_get_fan_config(client, 1);
-		if (ret < 0)
-			return ret;
-		fan_config |= ret;
-		ret = fan_config;
-		break;
-	case PMBUS_FAN_CONFIG_34:
-		if (page)
-			return -EINVAL;
-
-		ret = ucd9000_get_fan_config(client, 2);
-		if (ret < 0)
-			return ret;
-		fan_config = ret << 4;
-		ret = ucd9000_get_fan_config(client, 3);
-		if (ret < 0)
-			return ret;
-		fan_config |= ret;
-		ret = fan_config;
-		break;
-	default:
-		ret = -ENODATA;
-		break;
-	}
-	return ret;
-}
-
-static const struct i2c_device_id ucd9000_id[] = {
-	{"ucd9000", ucd9000},
-	{"ucd90120", ucd90120},
-	{"ucd90124", ucd90124},
-	{"ucd9090", ucd9090},
-	{"ucd90910", ucd90910},
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, ucd9000_id);
-
-static int ucd9000_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
-{
-	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
-	struct ucd9000_data *data;
-	struct pmbus_driver_info *info;
-	const struct i2c_device_id *mid;
-	int i, ret;
-
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_BYTE_DATA |
-				     I2C_FUNC_SMBUS_BLOCK_DATA))
-		return -ENODEV;
-
-	ret = i2c_smbus_read_block_data(client, UCD9000_DEVICE_ID,
-					block_buffer);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to read device ID\n");
-		return ret;
-	}
-	block_buffer[ret] = '\0';
-	dev_info(&client->dev, "Device ID %s\n", block_buffer);
-
-	mid = NULL;
-	for (i = 0; i < ARRAY_SIZE(ucd9000_id); i++) {
-		mid = &ucd9000_id[i];
-		if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
-			break;
-	}
-	if (!mid || !strlen(mid->name)) {
-		dev_err(&client->dev, "Unsupported device\n");
-		return -ENODEV;
-	}
-
-	if (id->driver_data != ucd9000 && id->driver_data != mid->driver_data)
-		dev_notice(&client->dev,
-			   "Device mismatch: Configured %s, detected %s\n",
-			   id->name, mid->name);
-
-	data = kzalloc(sizeof(struct ucd9000_data), GFP_KERNEL);
-	if (!data)
-		return -ENOMEM;
-	info = &data->info;
-
-	ret = i2c_smbus_read_byte_data(client, UCD9000_NUM_PAGES);
-	if (ret < 0) {
-		dev_err(&client->dev,
-			"Failed to read number of active pages\n");
-		goto out;
-	}
-	info->pages = ret;
-	if (!info->pages) {
-		dev_err(&client->dev, "No pages configured\n");
-		ret = -ENODEV;
-		goto out;
-	}
-
-	/* The internal temperature sensor is always active */
-	info->func[0] = PMBUS_HAVE_TEMP;
-
-	/* Everything else is configurable */
-	ret = i2c_smbus_read_block_data(client, UCD9000_MONITOR_CONFIG,
-					block_buffer);
-	if (ret <= 0) {
-		dev_err(&client->dev, "Failed to read configuration data\n");
-		ret = -ENODEV;
-		goto out;
-	}
-	for (i = 0; i < ret; i++) {
-		int page = UCD9000_MON_PAGE(block_buffer[i]);
-
-		if (page >= info->pages)
-			continue;
-
-		switch (UCD9000_MON_TYPE(block_buffer[i])) {
-		case UCD9000_MON_VOLTAGE:
-		case UCD9000_MON_VOLTAGE_HW:
-			info->func[page] |= PMBUS_HAVE_VOUT
-			  | PMBUS_HAVE_STATUS_VOUT;
-			break;
-		case UCD9000_MON_TEMPERATURE:
-			info->func[page] |= PMBUS_HAVE_TEMP2
-			  | PMBUS_HAVE_STATUS_TEMP;
-			break;
-		case UCD9000_MON_CURRENT:
-			info->func[page] |= PMBUS_HAVE_IOUT
-			  | PMBUS_HAVE_STATUS_IOUT;
-			break;
-		default:
-			break;
-		}
-	}
-
-	/* Fan configuration */
-	if (mid->driver_data = ucd90124) {
-		for (i = 0; i < UCD9000_NUM_FAN; i++) {
-			i2c_smbus_write_byte_data(client,
-						  UCD9000_FAN_CONFIG_INDEX, i);
-			ret = i2c_smbus_read_block_data(client,
-							UCD9000_FAN_CONFIG,
-							data->fan_data[i]);
-			if (ret < 0)
-				goto out;
-		}
-		i2c_smbus_write_byte_data(client, UCD9000_FAN_CONFIG_INDEX, 0);
-
-		info->read_byte_data = ucd9000_read_byte_data;
-		info->func[0] |= PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12
-		  | PMBUS_HAVE_FAN34 | PMBUS_HAVE_STATUS_FAN34;
-	}
-
-	ret = pmbus_do_probe(client, mid, info);
-	if (ret < 0)
-		goto out;
-	return 0;
-
-out:
-	kfree(data);
-	return ret;
-}
-
-static int ucd9000_remove(struct i2c_client *client)
-{
-	int ret;
-	struct ucd9000_data *data;
-
-	data = to_ucd9000_data(pmbus_get_driver_info(client));
-	ret = pmbus_do_remove(client);
-	kfree(data);
-	return ret;
-}
-
-
-/* This is the driver that will be inserted */
-static struct i2c_driver ucd9000_driver = {
-	.driver = {
-		.name = "ucd9000",
-	},
-	.probe = ucd9000_probe,
-	.remove = ucd9000_remove,
-	.id_table = ucd9000_id,
-};
-
-static int __init ucd9000_init(void)
-{
-	return i2c_add_driver(&ucd9000_driver);
-}
-
-static void __exit ucd9000_exit(void)
-{
-	i2c_del_driver(&ucd9000_driver);
-}
-
-MODULE_AUTHOR("Guenter Roeck");
-MODULE_DESCRIPTION("PMBus driver for TI UCD90xxx");
-MODULE_LICENSE("GPL");
-module_init(ucd9000_init);
-module_exit(ucd9000_exit);
diff --git a/drivers/hwmon/ucd9200.c b/drivers/hwmon/ucd9200.c
deleted file mode 100644
index ffcc1cf..0000000
--- a/drivers/hwmon/ucd9200.c
+++ /dev/null
@@ -1,210 +0,0 @@
-/*
- * Hardware monitoring driver for ucd9200 series Digital PWM System Controllers
- *
- * Copyright (C) 2011 Ericsson AB.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/err.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
-#include <linux/i2c/pmbus.h>
-#include "pmbus.h"
-
-#define UCD9200_PHASE_INFO	0xd2
-#define UCD9200_DEVICE_ID	0xfd
-
-enum chips { ucd9200, ucd9220, ucd9222, ucd9224, ucd9240, ucd9244, ucd9246,
-	     ucd9248 };
-
-static const struct i2c_device_id ucd9200_id[] = {
-	{"ucd9200", ucd9200},
-	{"ucd9220", ucd9220},
-	{"ucd9222", ucd9222},
-	{"ucd9224", ucd9224},
-	{"ucd9240", ucd9240},
-	{"ucd9244", ucd9244},
-	{"ucd9246", ucd9246},
-	{"ucd9248", ucd9248},
-	{}
-};
-MODULE_DEVICE_TABLE(i2c, ucd9200_id);
-
-static int ucd9200_probe(struct i2c_client *client,
-			 const struct i2c_device_id *id)
-{
-	u8 block_buffer[I2C_SMBUS_BLOCK_MAX + 1];
-	struct pmbus_driver_info *info;
-	const struct i2c_device_id *mid;
-	int i, j, ret;
-
-	if (!i2c_check_functionality(client->adapter,
-				     I2C_FUNC_SMBUS_BYTE_DATA |
-				     I2C_FUNC_SMBUS_BLOCK_DATA))
-		return -ENODEV;
-
-	ret = i2c_smbus_read_block_data(client, UCD9200_DEVICE_ID,
-					block_buffer);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to read device ID\n");
-		return ret;
-	}
-	block_buffer[ret] = '\0';
-	dev_info(&client->dev, "Device ID %s\n", block_buffer);
-
-	mid = NULL;
-	for (i = 0; i < ARRAY_SIZE(ucd9200_id); i++) {
-		mid = &ucd9200_id[i];
-		if (!strncasecmp(mid->name, block_buffer, strlen(mid->name)))
-			break;
-	}
-	if (!mid || !strlen(mid->name)) {
-		dev_err(&client->dev, "Unsupported device\n");
-		return -ENODEV;
-	}
-	if (id->driver_data != ucd9200 && id->driver_data != mid->driver_data)
-		dev_notice(&client->dev,
-			   "Device mismatch: Configured %s, detected %s\n",
-			   id->name, mid->name);
-
-	info = kzalloc(sizeof(struct pmbus_driver_info), GFP_KERNEL);
-	if (!info)
-		return -ENOMEM;
-
-	ret = i2c_smbus_read_block_data(client, UCD9200_PHASE_INFO,
-					block_buffer);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to read phase information\n");
-		goto out;
-	}
-
-	/*
-	 * Calculate number of configured pages (rails) from PHASE_INFO
-	 * register.
-	 * Rails have to be sequential, so we can abort after finding
-	 * the first unconfigured rail.
-	 */
-	info->pages = 0;
-	for (i = 0; i < ret; i++) {
-		if (!block_buffer[i])
-			break;
-		info->pages++;
-	}
-	if (!info->pages) {
-		dev_err(&client->dev, "No rails configured\n");
-		ret = -ENODEV;
-		goto out;
-	}
-	dev_info(&client->dev, "%d rails configured\n", info->pages);
-
-	/*
-	 * Set PHASE registers on all pages to 0xff to ensure that phase
-	 * specific commands will apply to all phases of a given page (rail).
-	 * This only affects the READ_IOUT and READ_TEMPERATURE2 registers.
-	 * READ_IOUT will return the sum of currents of all phases of a rail,
-	 * and READ_TEMPERATURE2 will return the maximum temperature detected
-	 * for the the phases of the rail.
-	 */
-	for (i = 0; i < info->pages; i++) {
-		/*
-		 * Setting PAGE & PHASE fails once in a while for no obvious
-		 * reason, so we need to retry a couple of times.
-		 */
-		for (j = 0; j < 3; j++) {
-			ret = i2c_smbus_write_byte_data(client, PMBUS_PAGE, i);
-			if (ret < 0)
-				continue;
-			ret = i2c_smbus_write_byte_data(client, PMBUS_PHASE,
-							0xff);
-			if (ret < 0)
-				continue;
-			break;
-		}
-		if (ret < 0) {
-			dev_err(&client->dev,
-				"Failed to initialize PHASE registers\n");
-			goto out;
-		}
-	}
-	if (info->pages > 1)
-		i2c_smbus_write_byte_data(client, PMBUS_PAGE, 0);
-
-	info->func[0] = PMBUS_HAVE_VIN | PMBUS_HAVE_STATUS_INPUT |
-			PMBUS_HAVE_IIN | PMBUS_HAVE_PIN |
-			PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
-			PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
-			PMBUS_HAVE_POUT | PMBUS_HAVE_TEMP |
-			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
-
-	for (i = 1; i < info->pages; i++)
-		info->func[i] = PMBUS_HAVE_VOUT | PMBUS_HAVE_STATUS_VOUT |
-			PMBUS_HAVE_IOUT | PMBUS_HAVE_STATUS_IOUT |
-			PMBUS_HAVE_POUT |
-			PMBUS_HAVE_TEMP2 | PMBUS_HAVE_STATUS_TEMP;
-
-	/* ucd9240 supports a single fan */
-	if (mid->driver_data = ucd9240)
-		info->func[0] |= PMBUS_HAVE_FAN12 | PMBUS_HAVE_STATUS_FAN12;
-
-	ret = pmbus_do_probe(client, mid, info);
-	if (ret < 0)
-		goto out;
-	return 0;
-out:
-	kfree(info);
-	return ret;
-}
-
-static int ucd9200_remove(struct i2c_client *client)
-{
-	int ret;
-	const struct pmbus_driver_info *info;
-
-	info = pmbus_get_driver_info(client);
-	ret = pmbus_do_remove(client);
-	kfree(info);
-	return ret;
-}
-
-
-/* This is the driver that will be inserted */
-static struct i2c_driver ucd9200_driver = {
-	.driver = {
-		.name = "ucd9200",
-	},
-	.probe = ucd9200_probe,
-	.remove = ucd9200_remove,
-	.id_table = ucd9200_id,
-};
-
-static int __init ucd9200_init(void)
-{
-	return i2c_add_driver(&ucd9200_driver);
-}
-
-static void __exit ucd9200_exit(void)
-{
-	i2c_del_driver(&ucd9200_driver);
-}
-
-MODULE_AUTHOR("Guenter Roeck");
-MODULE_DESCRIPTION("PMBus driver for TI UCD922x, UCD924x");
-MODULE_LICENSE("GPL");
-module_init(ucd9200_init);
-module_exit(ucd9200_exit);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
