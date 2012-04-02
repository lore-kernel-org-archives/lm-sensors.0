From: Kyle McMartin <kyle@redhat.com>
Date: Mon, 02 Apr 2012 18:19:01 +0000
Subject: [lm-sensors] [PATCH 2/5] acpi_power_meter: use a {RW, RO}_SENSOR_TEMPLATE macro to clean things up
Message-Id: <cde41080fea38b61ccf5edbf841a6578f19052ca.1333390501.git.kyle@mcmartin.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Kyle McMartin <kyle@mcmartin.ca>

Similar to how we do PCI/USB device id structs.

Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 drivers/hwmon/acpi_power_meter.c |  130 +++++++++++---------------------------
 1 files changed, 37 insertions(+), 93 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 4656a72..35d1f09 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -460,128 +460,72 @@ static ssize_t show_name(struct device *dev,
 	return sprintf(buf, "%s\n", ACPI_POWER_METER_NAME);
 }
 
+#define RO_SENSOR_TEMPLATE(_label, _show, _index)	\
+	{						\
+		.label = _label,			\
+		.show  = _show,				\
+		.index = _index,			\
+	}
+
+#define RW_SENSOR_TEMPLATE(_label, _show, _set, _index)	\
+	{						\
+		.label = _label,			\
+		.show  = _show,				\
+		.set   = _set,				\
+		.index = _index,			\
+	}
+
 /* Sensor descriptions.  If you add a sensor, update NUM_SENSORS above! */
 static struct sensor_template meter_ro_attrs[] = {
-	{
-		.label = POWER_AVERAGE_NAME,
-		.show  = show_power,
-		.index = 0,
-	},
-	{
-		.label = "power1_accuracy",
-		.show  = show_accuracy,
-		.index = 0,
-	},
-	{	.label = "power1_average_interval_min",
-		.show  = show_val,
-		.index = 0
-	},
-	{
-		.label = "power1_average_interval_max",
-		.show  = show_val,
-		.index = 1,
-	},
-	{
-		.label = "power1_is_battery",
-		.show = show_val,
-		.index = 5,
-	},
+	RO_SENSOR_TEMPLATE(POWER_AVERAGE_NAME, show_power, 0),
+	RO_SENSOR_TEMPLATE("power1_accuracy", show_accuracy, 0),
+	RO_SENSOR_TEMPLATE("power1_average_interval_min", show_val, 0),
+	RO_SENSOR_TEMPLATE("power1_average_interval_max", show_val, 1),
+	RO_SENSOR_TEMPLATE("power1_is_battery", show_val, 5),
 	{},
 };
 
 static struct sensor_template meter_rw_attrs[] = {
-	{
-		.label = POWER_AVG_INTERVAL_NAME,
-		.show  = show_avg_interval,
-		.set   = set_avg_interval,
-		.index = 0,
-	},
+	RW_SENSOR_TEMPLATE(POWER_AVG_INTERVAL_NAME, show_avg_interval,
+		set_avg_interval, 0),
 	{},
 };
 
 static struct sensor_template misc_cap_attrs[] = {
-	{
-		.label = "power1_cap_min",
-		.show  = show_val,
-		.index = 2,
-	},
-	{
-		.label = "power1_cap_max",
-		.show  = show_val,
-		.index = 3,
-	},
-	{
-		.label = "power1_cap_hyst",
-		.show  = show_val,
-		.index = 4,
-	},
-	{
-		.label = POWER_ALARM_NAME,
-		.show  = show_val,
-		.index = 6,
-	},
+	RO_SENSOR_TEMPLATE("power1_cap_min", show_val, 2),
+	RO_SENSOR_TEMPLATE("power1_cap_max", show_val, 3),
+	RO_SENSOR_TEMPLATE("power1_cap_hyst", show_val, 4),
+	RO_SENSOR_TEMPLATE(POWER_ALARM_NAME, show_val, 6),
 	{},
 };
 
 static struct sensor_template ro_cap_attrs[] = {
-	{
-		.label = POWER_CAP_NAME,
-		.show  = show_cap,
-		.index = 0,
-	},
+	RO_SENSOR_TEMPLATE(POWER_CAP_NAME, show_cap, 0),
 	{},
 };
 
 static struct sensor_template rw_cap_attrs[] = {
-	{
-		.label = POWER_CAP_NAME,
-		.show  = show_cap,
-		.set   = set_cap,
-		.index = 0,
-	},
+	RW_SENSOR_TEMPLATE(POWER_CAP_NAME, show_cap, set_cap, 0),
 	{},
 };
 
 static struct sensor_template trip_attrs[] = {
-	{
-		.label = "power1_average_min",
-		.show  = show_val,
-		.set   = set_trip,
-		.index = 7,
-	},
-	{
-		.label = "power1_average_max",
-		.show  = show_val,
-		.set   = set_trip,
-		.index = 8,
-	},
+	RW_SENSOR_TEMPLATE("power1_average_min", show_val, set_trip, 7),
+	RW_SENSOR_TEMPLATE("power1_average_max", show_val, set_trip, 8),
 	{},
 };
 
 static struct sensor_template misc_attrs[] = {
-	{
-		.label = "name",
-		.show  = show_name,
-		.index = 0,
-	},
-	{
-		.label = "power1_model_number",
-		.show  = show_str,
-		.index = 0,
-	},
-	{
-		.label = "power1_oem_info",
-		.show  = show_str,
-		.index = 2,
-	},
-	{
-		.label = "power1_serial_number",
-		.show  = show_str,
-		.index = 1,
-	},
+	RO_SENSOR_TEMPLATE("name", show_name, 0),
+	RO_SENSOR_TEMPLATE("power1_model_number", show_str, 0),
+	RO_SENSOR_TEMPLATE("power1_oem_info", show_str, 2),
+	RO_SENSOR_TEMPLATE("power1_serial_number", show_str, 1),
 	{},
 };
 
+#undef RO_SENSOR_TEMPLATE
+#undef RW_SENSOR_TEMPLATE
+
 /* Read power domain data */
 static void remove_domain_devices(struct acpi_power_meter_resource *resource)
 {
-- 
1.7.7.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
