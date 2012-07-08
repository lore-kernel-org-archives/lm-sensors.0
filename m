From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 08 Jul 2012 16:50:38 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (acpi_power_meter) Fix unintentional integer overflow
Message-Id: <1341766238-10943-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Expression with two integer variables is calculated as integer before it is
converted to u64. This may result in an integer overflow. Fix by declaring
trip point variables as s64 instead of int.

This patch addresses Coverity #200596: Unintentional integer overflow.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Fix by declaring trip point variables as s64 instead of multiplying with
    1000ULL. This is more consistent with the rest of the code.

 drivers/hwmon/acpi_power_meter.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 9a0821f1..5363da5 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -101,7 +101,7 @@ struct acpi_power_meter_resource {
 	unsigned long		sensors_last_updated;
 	struct sensor_device_attribute	sensors[NUM_SENSORS];
 	int			num_sensors;
-	int			trip[2];
+	s64			trip[2];
 	int			num_domain_devices;
 	struct acpi_device	**domain_devices;
 	struct kobject		*holders_dir;
@@ -308,8 +308,6 @@ static ssize_t set_trip(struct device *dev, struct device_attribute *devattr,
 		return res;
 
 	temp = DIV_ROUND_CLOSEST(temp, 1000);
-	if (temp > INT_MAX)
-		return -EINVAL;
 
 	mutex_lock(&resource->lock);
 	resource->trip[attr->index - 7] = temp;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
