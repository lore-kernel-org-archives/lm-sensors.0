From: Josef Gajdusek <atx@atx.name>
Date: Wed, 25 Jun 2014 14:21:21 +0000
Subject: [lm-sensors] [PATCH] hwmon: (emc1403) Fix missing 'select REGMAP_I2C' in Kconfig
Message-Id: <20140625142121.GA14873@dashie>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: jdelvare@suse.de, linux@roeck-us.net, linux-kernel@vger.kernel.org

In commit 4cab259f, the emc1403 driver was converted to use regmap but the 
necessary Kconfig option was not added.

Signed-off-by: Josef Gajdusek <atx@atx.name>
---
diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 08531a1..bdb90a0 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -1176,6 +1176,7 @@ config SENSORS_DME1737
 config SENSORS_EMC1403
 	tristate "SMSC EMC1403/23 thermal sensor"
 	depends on I2C
+	select REGMAP_I2C
 	help
 	  If you say yes here you get support for the SMSC EMC1403/23
 	  temperature monitoring chip.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
