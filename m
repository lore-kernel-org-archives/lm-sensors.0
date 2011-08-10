From: Keerthy <j-keerthy@ti.com>
Date: Wed, 10 Aug 2011 12:37:20 +0000
Subject: [lm-sensors] [RFC PATCH 4/6] OMAP4: Temperature sensor device
Message-Id: <1312979122-5896-5-git-send-email-j-keerthy@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com, j-keerthy@ti.com

The device file adds the device support for OMAP4
on die temperature sensor.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/Makefile                       |    3 +-
 arch/arm/mach-omap2/temp_sensor_device.c           |   85 +++++++++++++++++++
 arch/arm/plat-omap/Kconfig                         |   12 +++
 .../plat-omap/include/plat/temperature_sensor.h    |   87 ++++++++++++++++++++
 4 files changed, 186 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-omap2/temp_sensor_device.c
 create mode 100644 arch/arm/plat-omap/include/plat/temperature_sensor.h

diff --git a/arch/arm/mach-omap2/Makefile b/arch/arm/mach-omap2/Makefile
index fb02937..5812fb4 100644
--- a/arch/arm/mach-omap2/Makefile
+++ b/arch/arm/mach-omap2/Makefile
@@ -18,6 +18,7 @@ obj-$(CONFIG_ARCH_OMAP4) += prm44xx.o $(hwmod-common)
 
 obj-$(CONFIG_OMAP_MCBSP) += mcbsp.o
 
+obj-$(CONFIG_OMAP_TEMP_SENSOR)          += temp_sensor_device.o
 obj-$(CONFIG_TWL4030_CORE) += omap_twl.o
 
 # SMP support ONLY available for OMAP4
@@ -86,7 +87,7 @@ obj-$(CONFIG_ARCH_OMAP3)		+= prcm.o cm2xxx_3xxx.o prm2xxx_3xxx.o \
 obj-$(CONFIG_ARCH_OMAP4)		+= prcm.o cm2xxx_3xxx.o cminst44xx.o \
 					   cm44xx.o prcm_mpu44xx.o \
 					   prminst44xx.o vc44xx_data.o \
-					   vp44xx_data.o
+					   vp44xx_data.o temp_sensor4460_data.o
 
 # OMAP voltage domains
 ifeq ($(CONFIG_PM),y)
diff --git a/arch/arm/mach-omap2/temp_sensor_device.c b/arch/arm/mach-omap2/temp_sensor_device.c
new file mode 100644
index 0000000..5d5e92f
--- /dev/null
+++ b/arch/arm/mach-omap2/temp_sensor_device.c
@@ -0,0 +1,85 @@
+/*
+ * OMAP on die Temperature sensor device file
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Author: J Keerthy <j-keerthy@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/io.h>
+#include <linux/pm_runtime.h>
+#include <plat/omap_device.h>
+#include "control.h"
+#include "pm.h"
+#include <plat/temperature_sensor.h>
+
+static struct omap_device_pm_latency omap_temp_sensor_latency[] = {
+	{
+	 .deactivate_func = omap_device_idle_hwmods,
+	 .activate_func = omap_device_enable_hwmods,
+	 .flags = OMAP_DEVICE_LATENCY_AUTO_ADJUST,
+	}
+};
+
+static int temp_sensor_dev_init(struct omap_hwmod *oh, void *user)
+{
+	struct	omap_temp_sensor_pdata		*temp_sensor_pdata;
+	struct	omap_device			*od;
+	struct	omap_temp_sensor_dev_attr	*temp_sensor_dev_attr;
+	int					ret;
+	static int				device_count;
+
+	ret = 0;
+	temp_sensor_pdata +	    kzalloc(sizeof(*temp_sensor_pdata), GFP_KERNEL);
+	if (!temp_sensor_pdata) {
+		dev_err(&oh->od->pdev.dev,
+			"Unable to allocate memory for temp sensor pdata\n");
+		return -ENOMEM;
+	}
+
+	temp_sensor_dev_attr = oh->dev_attr;
+	if (!strcmp(temp_sensor_dev_attr->name, "mpu"))
+		temp_sensor_pdata->registers = &omap_mpu_temp_sensor_registers;
+
+	od = omap_device_build("omap_temp_sensor", device_count++,
+		oh, temp_sensor_pdata, sizeof(*temp_sensor_pdata),
+	       omap_temp_sensor_latency,
+			ARRAY_SIZE(omap_temp_sensor_latency), 0);
+	if (IS_ERR(od)) {
+		dev_warn(&oh->od->pdev.dev,
+			"Could not build omap_device for %s\n", oh->name);
+		ret = PTR_ERR(od);
+	}
+
+	kfree(temp_sensor_pdata);
+
+	return ret;
+}
+
+int __init omap_devinit_temp_sensor(void)
+{
+	if (!cpu_is_omap446x())
+		return 0;
+
+	return omap_hwmod_for_each_by_class("temperature_sensor",
+			temp_sensor_dev_init, NULL);
+}
+
+arch_initcall(omap_devinit_temp_sensor);
diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
index 6e6735f..8fd8e80 100644
--- a/arch/arm/plat-omap/Kconfig
+++ b/arch/arm/plat-omap/Kconfig
@@ -115,6 +115,18 @@ config OMAP_MCBSP
 	  Say Y here if you want support for the OMAP Multichannel
 	  Buffered Serial Port.
 
+config OMAP_TEMP_SENSOR
+	bool "OMAP Temp Sensor Support"
+	depends on ARCH_OMAP
+	default n
+	help
+	  Say Y here if you want support for the temp sensor
+	  on OMAP4460.
+
+	  This provides the temperature of the MPU
+	  subsystem. Only one instance of on die temperature
+	  sensor is present.
+
 config OMAP_MBOX_FWK
 	tristate "Mailbox framework support"
 	depends on ARCH_OMAP
diff --git a/arch/arm/plat-omap/include/plat/temperature_sensor.h b/arch/arm/plat-omap/include/plat/temperature_sensor.h
new file mode 100644
index 0000000..692ebdc
--- /dev/null
+++ b/arch/arm/plat-omap/include/plat/temperature_sensor.h
@@ -0,0 +1,87 @@
+/*
+ * OMAP Temperature sensor header file
+ *
+ * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
+ * Author: J Keerthy <j-keerthy@ti.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
+ * 02110-1301 USA
+ *
+ */
+
+#ifndef __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
+#define __ARCH_ARM_PLAT_OMAP_INCLUDE_PLAT_TEMPERATURE_SENSOR_H
+
+/* Offsets from the base of temperature sensor registers */
+
+#define OMAP4460_TEMP_SENSOR_CTRL_OFFSET	0x00
+#define OMAP4460_BGAP_CTRL_OFFSET		0x4c
+#define OMAP4460_BGAP_COUNTER_OFFSET		0x50
+#define OMAP4460_BGAP_THRESHOLD_OFFSET		0x54
+#define OMAP4460_BGAP_TSHUT_OFFSET		0x58
+#define OMAP4460_BGAP_STATUS_OFFSET		0x5c
+#define OMAP4460_FUSE_OPP_BGAP			-0xcc
+
+struct omap_temp_sensor_registers {
+	u32	temp_sensor_ctrl;
+	u32	bgap_tempsoff_mask;
+	u32	bgap_soc_mask;
+	u32	bgap_eocz_mask;
+	u32	bgap_dtemp_mask;
+
+	u32	bgap_mask_ctrl;
+	u32	mask_hot_mask;
+	u32	mask_cold_mask;
+
+	u32	bgap_mode_ctrl;
+	u32	mode_ctrl_mask;
+
+	u32	bgap_counter;
+	u32	counter_mask;
+
+	u32	bgap_threshold;
+	u32	threshold_thot_mask;
+	u32	threshold_tcold_mask;
+
+	u32	thsut_threshold;
+	u32	tshut_hot_mask;
+	u32	tshut_cold_mask;
+
+	u32	bgap_status;
+	u32	status_clean_stop_mask;
+	u32	status_bgap_alert_mask;
+	u32	status_hot_mask;
+	u32	status_cold_mask;
+
+	u32	bgap_efuse;
+};
+
+/*
+ * @name: Name of the domain of the temperature sensor
+ */
+struct omap_temp_sensor_dev_attr {
+	const char *name;
+};
+
+extern struct omap_temp_sensor_registers omap_mpu_temp_sensor_registers;
+
+/*
+ * omap_temp_sensor platform data
+ * @registers - pointer to register set and thier bit fields information
+ */
+struct omap_temp_sensor_pdata {
+	struct omap_temp_sensor_registers *registers;
+};
+
+#endif
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
