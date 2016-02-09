From: Sudeep Holla <sudeep.holla@arm.com>
Date: Tue, 09 Feb 2016 14:32:56 +0000
Subject: [lm-sensors] [PATCH 1/2] firmware: arm_scpi: add support for 64-bit sensor values
Message-Id: <1455028377-12728-1-git-send-email-sudeep.holla@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Guenter Roeck <linux@roeck-us.net>
Cc: Sudeep Holla <sudeep.holla@arm.com>, lm-sensors@lm-sensors.org, Jean Delvare <jdelvare@suse.com>, Punit Agrawal <punit.agrawal@arm.com>

SCPI specification version 1.1 extended the sensor from 32-bit to 64-bit
values in order to accommodate new sensor class with 64-bit requirements

Since the SCPI driver sets the higher 32-bit for older protocol version
to zeros, there's no need to explicitly check the SCPI protocol version
and the backward compatibility is maintainted.

Cc: Punit Agrawal <punit.agrawal@arm.com>
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c   | 8 +++++---
 drivers/hwmon/scpi-hwmon.c    | 6 +++---
 include/linux/scpi_protocol.h | 2 +-
 3 files changed, 9 insertions(+), 7 deletions(-)

Hi Guenter,

Since I have couple of other fixes for SCPI driver, if you can provide
your ACKs to this couple of patches after your review, I can take all of
them together via ARM-SoC if that's fine with you.

Regards,
Sudeep

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index c32ac6e61ba2..7e3e595c9f30 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -231,7 +231,8 @@ struct _scpi_sensor_info {
 };
 
 struct sensor_value {
-	__le32 val;
+	__le32 lo_val;
+	__le32 hi_val;
 } __packed;
 
 static struct scpi_drvinfo *scpi_info;
@@ -525,7 +526,7 @@ static int scpi_sensor_get_info(u16 sensor_id, struct scpi_sensor_info *info)
 	return ret;
 }
 
-int scpi_sensor_get_value(u16 sensor, u32 *val)
+int scpi_sensor_get_value(u16 sensor, u64 *val)
 {
 	__le16 id = cpu_to_le16(sensor);
 	struct sensor_value buf;
@@ -534,7 +535,8 @@ int scpi_sensor_get_value(u16 sensor, u32 *val)
 	ret = scpi_send_message(SCPI_CMD_SENSOR_VALUE, &id, sizeof(id),
 				&buf, sizeof(buf));
 	if (!ret)
-		*val = le32_to_cpu(buf.val);
+		*val = (u64)le32_to_cpu(buf.hi_val) << 32 |
+			le32_to_cpu(buf.lo_val);
 
 	return ret;
 }
diff --git a/drivers/hwmon/scpi-hwmon.c b/drivers/hwmon/scpi-hwmon.c
index 7e20567bc369..7101b14b5137 100644
--- a/drivers/hwmon/scpi-hwmon.c
+++ b/drivers/hwmon/scpi-hwmon.c
@@ -52,7 +52,7 @@ static int scpi_read_temp(void *dev, int *temp)
 	struct scpi_sensors *scpi_sensors = zone->scpi_sensors;
 	struct scpi_ops *scpi_ops = scpi_sensors->scpi_ops;
 	struct sensor_data *sensor = &scpi_sensors->data[zone->sensor_id];
-	u32 value;
+	u64 value;
 	int ret;
 
 	ret = scpi_ops->sensor_get_value(sensor->info.sensor_id, &value);
@@ -70,7 +70,7 @@ scpi_show_sensor(struct device *dev, struct device_attribute *attr, char *buf)
 	struct scpi_sensors *scpi_sensors = dev_get_drvdata(dev);
 	struct scpi_ops *scpi_ops = scpi_sensors->scpi_ops;
 	struct sensor_data *sensor;
-	u32 value;
+	u64 value;
 	int ret;
 
 	sensor = container_of(attr, struct sensor_data, dev_attr_input);
@@ -79,7 +79,7 @@ scpi_show_sensor(struct device *dev, struct device_attribute *attr, char *buf)
 	if (ret)
 		return ret;
 
-	return sprintf(buf, "%u\n", value);
+	return sprintf(buf, "%llu\n", value);
 }
 
 static ssize_t
diff --git a/include/linux/scpi_protocol.h b/include/linux/scpi_protocol.h
index 72ce932c69b2..ecd248d46281 100644
--- a/include/linux/scpi_protocol.h
+++ b/include/linux/scpi_protocol.h
@@ -68,7 +68,7 @@ struct scpi_ops {
 	struct scpi_dvfs_info *(*dvfs_get_info)(u8);
 	int (*sensor_get_capability)(u16 *sensors);
 	int (*sensor_get_info)(u16 sensor_id, struct scpi_sensor_info *);
-	int (*sensor_get_value)(u16, u32 *);
+	int (*sensor_get_value)(u16, u64 *);
 };
 
 #if IS_REACHABLE(CONFIG_ARM_SCPI_PROTOCOL)
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
