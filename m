From: Sudeep Holla <sudeep.holla@arm.com>
Date: Wed, 28 Oct 2015 14:08:03 +0000
Subject: [lm-sensors] [PATCH] hwmon: (scpi) skip unsupported sensors properly
Message-Id: <1446041283-19702-1-git-send-email-sudeep.holla@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Punit Agrawal <punit.agrawal@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>

Currently it's assumed that firmware exports only the class of sensors
supported by the driver. However with newer firmware or SCPI protocol
revision, support for newer classes of sensors can be present.

The driver fails to probe with the following warning if an unsupported
class of sensor is encountered in the firmware.

sysfs: cannot create duplicate filename
	'/devices/platform/scpi/scpi:sensors/hwmon/hwmon0/'
------------[ cut here ]------------
WARNING: at fs/sysfs/dir.c:31
Modules linked in:

CPU: 0 PID: 6 Comm: kworker/u12:0 Not tainted 4.3.0-rc7 #137
Hardware name: ARM Juno development board (r0) (DT)
Workqueue: deferwq deferred_probe_work_func
PC is at sysfs_warn_dup+0x54/0x78
LR is at sysfs_warn_dup+0x54/0x78

This patch fixes the above issue by skipping through the unsupported
class of SCPI sensors.

Fixes: 68acc77a2d51 ("hwmon: Support thermal zones registration for SCP temperature sensors")
Fixes: ea98b29a05e9 ("hwmon: Support sensors exported via ARM SCP interface")
Cc: Punit Agrawal <punit.agrawal@arm.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/hwmon/scpi-hwmon.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 2c1241bbf9af..5b80cd7f5c86 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -117,7 +117,7 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 	struct scpi_ops *scpi_ops;
 	struct device *hwdev, *dev = &pdev->dev;
 	struct scpi_sensors *scpi_sensors;
-	int ret;
+	int ret, idx;

 	scpi_ops = get_scpi_ops();
 	if (!scpi_ops)
@@ -146,8 +146,8 @@ static int scpi_hwmon_probe(struct platform_device *pdev)

 	scpi_sensors->scpi_ops = scpi_ops;

-	for (i = 0; i < nr_sensors; i++) {
-		struct sensor_data *sensor = &scpi_sensors->data[i];
+	for (i = 0, idx = 0; i < nr_sensors; i++) {
+		struct sensor_data *sensor = &scpi_sensors->data[idx];

 		ret = scpi_ops->sensor_get_info(i, &sensor->info);
 		if (ret)
@@ -183,7 +183,7 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 			num_power++;
 			break;
 		default:
-			break;
+			continue;
 		}

 		sensor->dev_attr_input.attr.mode = S_IRUGO;
@@ -194,11 +194,12 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 		sensor->dev_attr_label.show = scpi_show_label;
 		sensor->dev_attr_label.attr.name = sensor->label;

-		scpi_sensors->attrs[i << 1] = &sensor->dev_attr_input.attr;
-		scpi_sensors->attrs[(i << 1) + 1] = &sensor->dev_attr_label.attr;
+		scpi_sensors->attrs[idx << 1] = &sensor->dev_attr_input.attr;
+		scpi_sensors->attrs[(idx << 1) + 1] = &sensor->dev_attr_label.attr;

-		sysfs_attr_init(scpi_sensors->attrs[i << 1]);
-		sysfs_attr_init(scpi_sensors->attrs[(i << 1) + 1]);
+		sysfs_attr_init(scpi_sensors->attrs[idx << 1]);
+		sysfs_attr_init(scpi_sensors->attrs[(idx << 1) + 1]);
+		idx++;
 	}

 	scpi_sensors->group.attrs = scpi_sensors->attrs;
@@ -234,9 +235,9 @@ static int scpi_hwmon_probe(struct platform_device *pdev)
 			goto unregister_tzd;
 		}

-		zone->sensor_id = i;
+		zone->sensor_id = sensor->info.sensor_id;
 		zone->scpi_sensors = scpi_sensors;
-		zone->tzd = thermal_zone_of_sensor_register(dev, i, zone,
+		zone->tzd = thermal_zone_of_sensor_register(dev, zone->sensor_id, zone,
 							    &scpi_sensor_ops);
 		/*
 		 * The call to thermal_zone_of_sensor_register returns
--
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
