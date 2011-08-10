From: Keerthy <j-keerthy@ti.com>
Date: Wed, 10 Aug 2011 12:37:21 +0000
Subject: [lm-sensors] [RFC PATCH 5/6] OMAP4460: Temperature sensor data
Message-Id: <1312979122-5896-6-git-send-email-j-keerthy@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1312979122-5896-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: vishwanath.bs@ti.com, linux-omap@vger.kernel.org, b-cousson@ti.com, rnayak@ti.com, j-keerthy@ti.com

The register set and the
bit fields might vary across OMAP versions. Hence
creating a structure comprising of all the registers
and bit fields to make the driver uniform for all the
versions with different register sets. The data file
contains the structure populated with register offsets
and bit fields corresponding to OMAP4460 on die sensor.

Signed-off-by: Keerthy <j-keerthy@ti.com>
---
 arch/arm/mach-omap2/temp_sensor4460_data.c |   63 ++++++++++++++++++++++++++++
 1 files changed, 63 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-omap2/temp_sensor4460_data.c

diff --git a/arch/arm/mach-omap2/temp_sensor4460_data.c b/arch/arm/mach-omap2/temp_sensor4460_data.c
new file mode 100644
index 0000000..294963d
--- /dev/null
+++ b/arch/arm/mach-omap2/temp_sensor4460_data.c
@@ -0,0 +1,63 @@
+/*
+ * OMAP4460 on die Temperature sensor data file
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
+#include <linux/slab.h>
+#include "control.h"
+#include <plat/temperature_sensor.h>
+
+/*
+ * OMAP4460 has one instance of thermal sensor for MPU
+ * need to describe the individual bit fields
+ */
+struct omap_temp_sensor_registers omap_mpu_temp_sensor_registers = {
+	.temp_sensor_ctrl		= OMAP4460_TEMP_SENSOR_CTRL_OFFSET,
+	.bgap_tempsoff_mask		= OMAP4460_BGAP_TEMPSOFF_MASK,
+	.bgap_soc_mask			= OMAP4460_BGAP_TEMP_SENSOR_SOC_MASK,
+	.bgap_eocz_mask			= OMAP4460_BGAP_TEMP_SENSOR_EOCZ_MASK,
+	.bgap_dtemp_mask		= OMAP4460_BGAP_TEMP_SENSOR_DTEMP_MASK,
+
+	.bgap_mask_ctrl			= OMAP4460_BGAP_CTRL_OFFSET,
+	.mask_hot_mask			= OMAP4460_MASK_HOT_MASK,
+	.mask_cold_mask			= OMAP4460_MASK_COLD_MASK,
+
+	.bgap_mode_ctrl			= OMAP4460_BGAP_CTRL_OFFSET,
+	.mode_ctrl_mask			= OMAP4460_SINGLE_MODE_MASK,
+
+	.bgap_counter			= OMAP4460_BGAP_COUNTER_OFFSET,
+	.counter_mask			= OMAP4460_COUNTER_MASK,
+
+	.bgap_threshold			= OMAP4460_BGAP_THRESHOLD_OFFSET,
+	.threshold_thot_mask		= OMAP4460_T_HOT_MASK,
+	.threshold_tcold_mask		= OMAP4460_T_COLD_MASK,
+
+	.thsut_threshold		= OMAP4460_BGAP_TSHUT_OFFSET,
+	.tshut_hot_mask			= OMAP4460_TSHUT_HOT_MASK,
+	.tshut_cold_mask		= OMAP4460_TSHUT_COLD_MASK,
+
+	.bgap_status			= OMAP4460_BGAP_STATUS_OFFSET,
+	.status_clean_stop_mask		= OMAP4460_CLEAN_STOP_MASK,
+	.status_bgap_alert_mask		= OMAP4460_BGAP_ALERT_MASK,
+	.status_hot_mask		= OMAP4460_HOT_FLAG_MASK,
+	.status_cold_mask		= OMAP4460_COLD_FLAG_MASK,
+
+	.bgap_efuse			= OMAP4460_FUSE_OPP_BGAP,
+};
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
