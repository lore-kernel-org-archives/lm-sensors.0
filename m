From: Kyle McMartin <kyle@redhat.com>
Date: Mon, 02 Apr 2012 18:19:02 +0000
Subject: [lm-sensors] [PATCH 3/5] acpi_power_meter: remove duplicate code between register_{ro, rw}_attrs
Message-Id: <514f4e9eac4c6ff507fa0866b6df68b951d5893f.1333390501.git.kyle@mcmartin.ca>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Kyle McMartin <kyle@mcmartin.ca>

Key off the attr->set method being present to set the sysfs attribute
as writable.

Signed-off-by: Kyle McMartin <kyle@redhat.com>
---
 drivers/hwmon/acpi_power_meter.c |   58 +++++++++++--------------------------
 1 files changed, 17 insertions(+), 41 deletions(-)

diff --git a/drivers/hwmon/acpi_power_meter.c b/drivers/hwmon/acpi_power_meter.c
index 35d1f09..c9df810 100644
--- a/drivers/hwmon/acpi_power_meter.c
+++ b/drivers/hwmon/acpi_power_meter.c
@@ -629,48 +629,24 @@ end:
 }
 
 /* Registration and deregistration */
-static int register_ro_attrs(struct acpi_power_meter_resource *resource,
-			     struct sensor_template *ro)
+static int register_attrs(struct acpi_power_meter_resource *resource,
+			  struct sensor_template *attrs)
 {
 	struct device *dev = &resource->acpi_dev->dev;
 	struct sensor_device_attribute *sensors  		&resource->sensors[resource->num_sensors];
 	int res = 0;
 
-	while (ro->label) {
-		sensors->dev_attr.attr.name = ro->label;
+	while (attrs->label) {
+		sensors->dev_attr.attr.name = attrs->label;
 		sensors->dev_attr.attr.mode = S_IRUGO;
-		sensors->dev_attr.show = ro->show;
-		sensors->index = ro->index;
+		sensors->dev_attr.show = attrs->show;
+		sensors->index = attrs->index;
 
-		res = device_create_file(dev, &sensors->dev_attr);
-		if (res) {
-			sensors->dev_attr.attr.name = NULL;
-			goto error;
+		if (attrs->set) {
+			sensors->dev_attr.attr.mode |= S_IWUSR;
+			sensors->dev_attr.store = attrs->set;
 		}
-		sensors++;
-		resource->num_sensors++;
-		ro++;
-	}
-
-error:
-	return res;
-}
-
-static int register_rw_attrs(struct acpi_power_meter_resource *resource,
-			     struct sensor_template *rw)
-{
-	struct device *dev = &resource->acpi_dev->dev;
-	struct sensor_device_attribute *sensors -		&resource->sensors[resource->num_sensors];
-	int res = 0;
-
-	while (rw->label) {
-		sensors->dev_attr.attr.name = rw->label;
-		sensors->dev_attr.attr.mode = S_IRUGO | S_IWUSR;
-		sensors->dev_attr.show = rw->show;
-		sensors->dev_attr.store = rw->set;
-		sensors->index = rw->index;
 
 		res = device_create_file(dev, &sensors->dev_attr);
 		if (res) {
@@ -679,7 +655,7 @@ static int register_rw_attrs(struct acpi_power_meter_resource *resource,
 		}
 		sensors++;
 		resource->num_sensors++;
-		rw++;
+		attrs++;
 	}
 
 error:
@@ -711,10 +687,10 @@ static int setup_attrs(struct acpi_power_meter_resource *resource)
 		return res;
 
 	if (resource->caps.flags & POWER_METER_CAN_MEASURE) {
-		res = register_ro_attrs(resource, meter_ro_attrs);
+		res = register_attrs(resource, meter_ro_attrs);
 		if (res)
 			goto error;
-		res = register_rw_attrs(resource, meter_rw_attrs);
+		res = register_attrs(resource, meter_rw_attrs);
 		if (res)
 			goto error;
 	}
@@ -727,27 +703,27 @@ static int setup_attrs(struct acpi_power_meter_resource *resource)
 		}
 
 		if (resource->caps.configurable_cap) {
-			res = register_rw_attrs(resource, rw_cap_attrs);
+			res = register_attrs(resource, rw_cap_attrs);
 			if (res)
 				goto error;
 		} else {
-			res = register_ro_attrs(resource, ro_cap_attrs);
+			res = register_attrs(resource, ro_cap_attrs);
 			if (res)
 				goto error;
 		}
-		res = register_ro_attrs(resource, misc_cap_attrs);
+		res = register_attrs(resource, misc_cap_attrs);
 		if (res)
 			goto error;
 	}
 skip_unsafe_cap:
 
 	if (resource->caps.flags & POWER_METER_CAN_TRIP) {
-		res = register_rw_attrs(resource, trip_attrs);
+		res = register_attrs(resource, trip_attrs);
 		if (res)
 			goto error;
 	}
 
-	res = register_ro_attrs(resource, misc_attrs);
+	res = register_attrs(resource, misc_attrs);
 	if (res)
 		goto error;
 
-- 
1.7.7.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
