From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 19 Jan 2012 23:56:16 +0000
Subject: [lm-sensors] [PATCH 82/82] hwmon: (wm831x-hwmon) Fix multi-line comments
Message-Id: <1327017376-20466-83-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/wm831x-hwmon.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/wm831x-hwmon.c b/drivers/hwmon/wm831x-hwmon.c
index 23b44de..07cb25a 100644
--- a/drivers/hwmon/wm831x-hwmon.c
+++ b/drivers/hwmon/wm831x-hwmon.c
@@ -117,8 +117,10 @@ static SENSOR_DEVICE_ATTR(temp1_input, S_IRUGO, show_chip_temp, NULL,
 			  WM831X_AUX_CHIP_TEMP);
 static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_label, NULL,
 			  WM831X_AUX_CHIP_TEMP);
-/* Report as a voltage since conversion depends on external components
- * and that's what the ABI wants. */
+/*
+ * Report as a voltage since conversion depends on external components
+ * and that's what the ABI wants.
+ */
 static SENSOR_DEVICE_ATTR(temp2_input, S_IRUGO, show_voltage, NULL,
 			  WM831X_AUX_BATT_TEMP);
 static SENSOR_DEVICE_ATTR(temp2_label, S_IRUGO, show_label, NULL,
-- 
1.7.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
