From: Punit Agrawal <punit.agrawal@arm.com>
Date: Wed, 22 Jul 2015 14:02:39 +0000
Subject: [lm-sensors] [PATCH 5/9] firmware: arm_scpi: Extend to support sensors
Message-Id: <1437573763-6525-6-git-send-email-punit.agrawal@arm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1437573763-6525-1-git-send-email-punit.agrawal@arm.com>
In-Reply-To: <1437573763-6525-1-git-send-email-punit.agrawal@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-pm@vger.kernel.org
Cc: Punit Agrawal <punit.agrawal@arm.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, Sudeep Holla <sudeep.holla@arm.com>

ARM System Control Processor (SCP) provides an API to query and use
the sensors available in the system. Extend the SCPI driver to support
 sensor messages.

Signed-off-by: Punit Agrawal <punit.agrawal@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/arm_scpi.c   | 60 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/scpi_protocol.h | 17 ++++++++++++
 2 files changed, 77 insertions(+)

diff --git a/drivers/firmware/arm_scpi.c b/drivers/firmware/arm_scpi.c
index a70b7ba..478c5c5 100644
--- a/drivers/firmware/arm_scpi.c
+++ b/drivers/firmware/arm_scpi.c
@@ -219,6 +219,21 @@ struct dvfs_set {
 	u8 index;
 } __packed;
 
+struct sensor_capabilities {
+	__le16 sensors;
+} __packed;
+
+struct _scpi_sensor_info {
+	__le16 sensor_id;
+	u8 class;
+	u8 trigger_type;
+	char name[20];
+};
+
+struct sensor_value {
+	__le32 val;
+} __packed;
+
 static struct scpi_drvinfo *scpi_info;
 
 static int scpi_linux_errmap[SCPI_ERR_MAX] = {
@@ -481,6 +496,48 @@ static struct scpi_dvfs_info *scpi_dvfs_get_info(u8 domain)
 	return info;
 }
 
+static int scpi_sensor_get_capability(u16 *sensors)
+{
+	struct sensor_capabilities cap_buf;
+	int ret;
+
+	ret = scpi_send_message(SCPI_CMD_SENSOR_CAPABILITIES, NULL, 0, &cap_buf,
+				sizeof(cap_buf));
+	if (!ret)
+		*sensors = le16_to_cpu(cap_buf.sensors);
+
+	return ret;
+}
+
+static int scpi_sensor_get_info(u16 sensor_id, struct scpi_sensor_info *info)
+{
+	__le16 id = cpu_to_le16(sensor_id);
+	struct _scpi_sensor_info _info;
+	int ret;
+
+	ret = scpi_send_message(SCPI_CMD_SENSOR_INFO, &id,
+				 sizeof(id), &_info, sizeof(_info));
+	if (!ret) {
+		memcpy(info, &_info, sizeof(*info));
+		info->sensor_id = le16_to_cpu(_info.sensor_id);
+	}
+
+	return ret;
+}
+
+int scpi_sensor_get_value(u16 sensor, u32 *val)
+{
+	struct sensor_value buf;
+	int ret;
+
+	ret = scpi_send_message(SCPI_CMD_SENSOR_VALUE, &sensor, sizeof(sensor),
+				&buf, sizeof(buf));
+	if (!ret)
+		*val = le32_to_cpu(buf.val);
+
+	return ret;
+}
+
 static struct scpi_ops scpi_ops = {
 	.get_version = scpi_get_version,
 	.clk_get_range = scpi_clk_get_range,
@@ -489,6 +546,9 @@ static struct scpi_ops scpi_ops = {
 	.dvfs_get_idx = scpi_dvfs_get_idx,
 	.dvfs_set_idx = scpi_dvfs_set_idx,
 	.dvfs_get_info = scpi_dvfs_get_info,
+	.sensor_get_capability = scpi_sensor_get_capability,
+	.sensor_get_info = scpi_sensor_get_info,
+	.sensor_get_value = scpi_sensor_get_value,
 };
 
 struct scpi_ops *get_scpi_ops(void)
diff --git a/include/linux/scpi_protocol.h b/include/linux/scpi_protocol.h
index e7169cd..80af3cd 100644
--- a/include/linux/scpi_protocol.h
+++ b/include/linux/scpi_protocol.h
@@ -28,6 +28,20 @@ struct scpi_dvfs_info {
 	struct scpi_opp *opps;
 };
 
+enum scpi_sensor_class {
+	TEMPERATURE,
+	VOLTAGE,
+	CURRENT,
+	POWER,
+};
+
+struct scpi_sensor_info {
+	u16 sensor_id;
+	u8 class;
+	u8 trigger_type;
+	char name[20];
+} __packed;
+
 /**
  * struct scpi_ops - represents the various operations provided
  *	by SCP through SCPI message protocol
@@ -52,6 +66,9 @@ struct scpi_ops {
 	int (*dvfs_get_idx)(u8);
 	int (*dvfs_set_idx)(u8, u8);
 	struct scpi_dvfs_info *(*dvfs_get_info)(u8);
+	int (*sensor_get_capability)(u16 *sensors);
+	int (*sensor_get_info)(u16 sensor_id, struct scpi_sensor_info *);
+	int (*sensor_get_value)(u16, u32 *);
 };
 
 #if IS_ENABLED(CONFIG_ARM_SCPI_PROTOCOL)
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
