From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 19 Jun 2012 15:46:42 +0000
Subject: [lm-sensors] [PATCH 3/4] hwmon: (acpi_power_meter) Remove unnecessary if statement
Message-Id: <1340120803-23543-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

An unsigned value is never smaller than 0. Remove the check for it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/acpi_power_meter.c |    2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 34ad5a2..e2b0ae8 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -308,8 +308,6 @@ static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
 		return res;
 
 	temp /= 1000;
-	if (temp < 0)
-		return -EINVAL;
 
 	mutex_lock(&resource->lock);
 	resource->trip[attr->index - 7] = temp;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
