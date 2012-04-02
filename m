From: Kyle McMartin <kyle@redhat.com>
Date: Mon, 02 Apr 2012 18:19:00 +0000
Subject: [lm-sensors] [PATCH 1/5] acpi_power_meter: use the same struct {rw, ro}_sensor_template for both
Message-Id: <2abfc9009356ebbb6ac3df0210845ab5c43d3766.1333390501.git.kyle@mcmartin.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Kyle McMartin <kyle@mcmartin.ca>

We don't need both, when we can just key the read/write off of the
presence of the .set member.

Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 drivers/hwmon/acpi_power_meter.c |  153 +++++++++++++++++++++++++++-----------
 1 files changed, 110 insertions(+), 43 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 554f046..4656a72 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -107,15 +107,7 @@ struct acpi_power_meter_resource {
 	struct kobject		*holders_dir;
 };
 
-struct ro_sensor_template {
-	char *label;
-	ssize_t (*show)(struct device *dev,
-			struct device_attribute *devattr,
-			char *buf);
-	int index;
-};
-
-struct rw_sensor_template {
+struct sensor_template {
 	char *label;
 	ssize_t (*show)(struct device *dev,
 			struct device_attribute *devattr,
@@ -469,50 +461,125 @@ static ssize_t show_name(struct device *dev,
 }
 
 /* Sensor descriptions.  If you add a sensor, update NUM_SENSORS above! */
-static struct ro_sensor_template meter_ro_attrs[] = {
-{POWER_AVERAGE_NAME, show_power, 0},
-{"power1_accuracy", show_accuracy, 0},
-{"power1_average_interval_min", show_val, 0},
-{"power1_average_interval_max", show_val, 1},
-{"power1_is_battery", show_val, 5},
-{NULL, NULL, 0},
+static struct sensor_template meter_ro_attrs[] = {
+	{
+		.label = POWER_AVERAGE_NAME,
+		.show  = show_power,
+		.index = 0,
+	},
+	{
+		.label = "power1_accuracy",
+		.show  = show_accuracy,
+		.index = 0,
+	},
+	{	.label = "power1_average_interval_min",
+		.show  = show_val,
+		.index = 0
+	},
+	{
+		.label = "power1_average_interval_max",
+		.show  = show_val,
+		.index = 1,
+	},
+	{
+		.label = "power1_is_battery",
+		.show = show_val,
+		.index = 5,
+	},
+	{},
 };
 
-static struct rw_sensor_template meter_rw_attrs[] = {
-{POWER_AVG_INTERVAL_NAME, show_avg_interval, set_avg_interval, 0},
-{NULL, NULL, NULL, 0},
+static struct sensor_template meter_rw_attrs[] = {
+	{
+		.label = POWER_AVG_INTERVAL_NAME,
+		.show  = show_avg_interval,
+		.set   = set_avg_interval,
+		.index = 0,
+	},
+	{},
 };
 
-static struct ro_sensor_template misc_cap_attrs[] = {
-{"power1_cap_min", show_val, 2},
-{"power1_cap_max", show_val, 3},
-{"power1_cap_hyst", show_val, 4},
-{POWER_ALARM_NAME, show_val, 6},
-{NULL, NULL, 0},
+static struct sensor_template misc_cap_attrs[] = {
+	{
+		.label = "power1_cap_min",
+		.show  = show_val,
+		.index = 2,
+	},
+	{
+		.label = "power1_cap_max",
+		.show  = show_val,
+		.index = 3,
+	},
+	{
+		.label = "power1_cap_hyst",
+		.show  = show_val,
+		.index = 4,
+	},
+	{
+		.label = POWER_ALARM_NAME,
+		.show  = show_val,
+		.index = 6,
+	},
+	{},
 };
 
-static struct ro_sensor_template ro_cap_attrs[] = {
-{POWER_CAP_NAME, show_cap, 0},
-{NULL, NULL, 0},
+static struct sensor_template ro_cap_attrs[] = {
+	{
+		.label = POWER_CAP_NAME,
+		.show  = show_cap,
+		.index = 0,
+	},
+	{},
 };
 
-static struct rw_sensor_template rw_cap_attrs[] = {
-{POWER_CAP_NAME, show_cap, set_cap, 0},
-{NULL, NULL, NULL, 0},
+static struct sensor_template rw_cap_attrs[] = {
+	{
+		.label = POWER_CAP_NAME,
+		.show  = show_cap,
+		.set   = set_cap,
+		.index = 0,
+	},
+	{},
 };
 
-static struct rw_sensor_template trip_attrs[] = {
-{"power1_average_min", show_val, set_trip, 7},
-{"power1_average_max", show_val, set_trip, 8},
-{NULL, NULL, NULL, 0},
+static struct sensor_template trip_attrs[] = {
+	{
+		.label = "power1_average_min",
+		.show  = show_val,
+		.set   = set_trip,
+		.index = 7,
+	},
+	{
+		.label = "power1_average_max",
+		.show  = show_val,
+		.set   = set_trip,
+		.index = 8,
+	},
+	{},
 };
 
-static struct ro_sensor_template misc_attrs[] = {
-{"name", show_name, 0},
-{"power1_model_number", show_str, 0},
-{"power1_oem_info", show_str, 2},
-{"power1_serial_number", show_str, 1},
-{NULL, NULL, 0},
+static struct sensor_template misc_attrs[] = {
+	{
+		.label = "name",
+		.show  = show_name,
+		.index = 0,
+	},
+	{
+		.label = "power1_model_number",
+		.show  = show_str,
+		.index = 0,
+	},
+	{
+		.label = "power1_oem_info",
+		.show  = show_str,
+		.index = 2,
+	},
+	{
+		.label = "power1_serial_number",
+		.show  = show_str,
+		.index = 1,
+	},
+	{},
 };
 
 /* Read power domain data */
@@ -619,7 +686,7 @@ end:
 
 /* Registration and deregistration */
 static int register_ro_attrs(struct acpi_power_meter_resource *resource,
-			     struct ro_sensor_template *ro)
+			     struct sensor_template *ro)
 {
 	struct device *dev = &resource->acpi_dev->dev;
 	struct sensor_device_attribute *sensors @@ -647,7 +714,7 @@ error:
 }
 
 static int register_rw_attrs(struct acpi_power_meter_resource *resource,
-			     struct rw_sensor_template *rw)
+			     struct sensor_template *rw)
 {
 	struct device *dev = &resource->acpi_dev->dev;
 	struct sensor_device_attribute *sensors -- 
1.7.7.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
