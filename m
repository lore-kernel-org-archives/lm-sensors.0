From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Wed, 12 Sep 2012 16:23:44 +0000
Subject: [lm-sensors] [PATCH] hwmon: (sht15) move header to linux/platform_data/
Message-Id: <1347467024-3231-1-git-send-email-vivien.didelot@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

This patch moves the sht15.h header from include/linux to
include/linux/platform_data, and update existing support (stargate2
platform) accordingly.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 arch/arm/mach-pxa/stargate2.c       |  2 +-
 drivers/hwmon/sht15.c               |  2 +-
 include/linux/platform_data/sht15.h | 34 ++++++++++++++++++++++++++++++++++
 include/linux/sht15.h               | 34 ----------------------------------
 4 files changed, 36 insertions(+), 36 deletions(-)
 create mode 100644 include/linux/platform_data/sht15.h
 delete mode 100644 include/linux/sht15.h

diff --git a/arch/arm/mach-pxa/stargate2.c b/arch/arm/mach-pxa/stargate2.c
index 30b1b0b..0701ca7 100644
--- a/arch/arm/mach-pxa/stargate2.c
+++ b/arch/arm/mach-pxa/stargate2.c
@@ -52,7 +52,7 @@
 #include <linux/spi/spi.h>
 #include <linux/spi/pxa2xx_spi.h>
 #include <linux/mfd/da903x.h>
-#include <linux/sht15.h>
+#include <linux/platform_data/sht15.h>
 
 #include "devices.h"
 #include "generic.h"
diff --git a/drivers/hwmon/sht15.c b/drivers/hwmon/sht15.c
index 38e0233..febb273 100644
--- a/drivers/hwmon/sht15.c
+++ b/drivers/hwmon/sht15.c
@@ -24,12 +24,12 @@
 #include <linux/hwmon.h>
 #include <linux/hwmon-sysfs.h>
 #include <linux/mutex.h>
+#include <linux/platform_data/sht15.h>
 #include <linux/platform_device.h>
 #include <linux/sched.h>
 #include <linux/delay.h>
 #include <linux/jiffies.h>
 #include <linux/err.h>
-#include <linux/sht15.h>
 #include <linux/regulator/consumer.h>
 #include <linux/slab.h>
 #include <linux/atomic.h>
diff --git a/include/linux/platform_data/sht15.h b/include/linux/platform_data/sht15.h
new file mode 100644
index 0000000..f85c7c5
--- /dev/null
+++ b/include/linux/platform_data/sht15.h
@@ -0,0 +1,34 @@
+/*
+ * sht15.h - support for the SHT15 Temperature and Humidity Sensor
+ *
+ * Copyright (c) 2009 Jonathan Cameron
+ *
+ * Copyright (c) 2007 Wouter Horre
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * For further information, see the Documentation/hwmon/sht15 file.
+ */
+
+/**
+ * struct sht15_platform_data - sht15 connectivity info
+ * @gpio_data:		no. of gpio to which bidirectional data line is
+ *			connected.
+ * @gpio_sck:		no. of gpio to which the data clock is connected.
+ * @supply_mv:		supply voltage in mv. Overridden by regulator if
+ *			available.
+ * @checksum:		flag to indicate the checksum should be validated.
+ * @no_otp_reload:	flag to indicate no reload from OTP.
+ * @low_resolution:	flag to indicate the temp/humidity resolution to use.
+ */
+struct sht15_platform_data {
+	int gpio_data;
+	int gpio_sck;
+	int supply_mv;
+	bool checksum;
+	bool no_otp_reload;
+	bool low_resolution;
+};
+
diff --git a/include/linux/sht15.h b/include/linux/sht15.h
deleted file mode 100644
index f85c7c5..0000000
--- a/include/linux/sht15.h
+++ /dev/null
@@ -1,34 +0,0 @@
-/*
- * sht15.h - support for the SHT15 Temperature and Humidity Sensor
- *
- * Copyright (c) 2009 Jonathan Cameron
- *
- * Copyright (c) 2007 Wouter Horre
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- *
- * For further information, see the Documentation/hwmon/sht15 file.
- */
-
-/**
- * struct sht15_platform_data - sht15 connectivity info
- * @gpio_data:		no. of gpio to which bidirectional data line is
- *			connected.
- * @gpio_sck:		no. of gpio to which the data clock is connected.
- * @supply_mv:		supply voltage in mv. Overridden by regulator if
- *			available.
- * @checksum:		flag to indicate the checksum should be validated.
- * @no_otp_reload:	flag to indicate no reload from OTP.
- * @low_resolution:	flag to indicate the temp/humidity resolution to use.
- */
-struct sht15_platform_data {
-	int gpio_data;
-	int gpio_sck;
-	int supply_mv;
-	bool checksum;
-	bool no_otp_reload;
-	bool low_resolution;
-};
-
-- 
1.7.11.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
