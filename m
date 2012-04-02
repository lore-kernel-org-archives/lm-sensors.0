From: Kyle McMartin <kyle@redhat.com>
Date: Mon, 02 Apr 2012 18:19:03 +0000
Subject: [lm-sensors] [PATCH 4/5] acpi_power_meter: drop meter_rw_attrs, use common meter_attrs
Message-Id: <07d303ae2a55badcf93160caedad63ae88284b7a.1333390501.git.kyle@mcmartin.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Kyle McMartin <kyle@mcmartin.ca>

We always register these two together, so move meter_rw_attrs into
meter_ro_attrs and use the same for both since we no longer have two
register_attr paths.

Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 drivers/hwmon/acpi_power_meter.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index c9df810..16ab439 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -476,16 +476,12 @@ static ssize_t show_name(struct device *dev,
 	}
 
 /* Sensor descriptions.  If you add a sensor, update NUM_SENSORS above! */
-static struct sensor_template meter_ro_attrs[] = {
+static struct sensor_template meter_attrs[] = {
 	RO_SENSOR_TEMPLATE(POWER_AVERAGE_NAME, show_power, 0),
 	RO_SENSOR_TEMPLATE("power1_accuracy", show_accuracy, 0),
 	RO_SENSOR_TEMPLATE("power1_average_interval_min", show_val, 0),
 	RO_SENSOR_TEMPLATE("power1_average_interval_max", show_val, 1),
 	RO_SENSOR_TEMPLATE("power1_is_battery", show_val, 5),
-	{},
-};
-
-static struct sensor_template meter_rw_attrs[] = {
 	RW_SENSOR_TEMPLATE(POWER_AVG_INTERVAL_NAME, show_avg_interval,
 		set_avg_interval, 0),
 	{},
@@ -687,10 +683,7 @@ static int setup_attrs(struct acpi_power_meter_resource *resource)
 		return res;
 
 	if (resource->caps.flags & POWER_METER_CAN_MEASURE) {
-		res = register_attrs(resource, meter_ro_attrs);
-		if (res)
-			goto error;
-		res = register_attrs(resource, meter_rw_attrs);
+		res = register_attrs(resource, meter_attrs);
 		if (res)
 			goto error;
 	}
-- 
1.7.7.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
