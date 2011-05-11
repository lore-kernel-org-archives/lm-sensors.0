From: Hans de Goede <hdegoede@redhat.com>
Date: Wed, 11 May 2011 12:31:41 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon/sch5627: Trigger Vbat measurements
Message-Id: <1305117101-4325-2-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The sch5627 needs to be explicitly told to start an adc conversion
for Vbat, once in a while. Without this Vbat may read 0, and will never
get updated.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/sch5627.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index d785a2c..020c872 100644
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -97,11 +97,13 @@ static const char * const SCH5627_IN_LABELS[SCH5627_NO_IN] = {
 struct sch5627_data {
 	unsigned short addr;
 	struct device *hwmon_dev;
+	u8 control;
 	u8 temp_max[SCH5627_NO_TEMPS];
 	u8 temp_crit[SCH5627_NO_TEMPS];
 	u16 fan_min[SCH5627_NO_FANS];
 
 	struct mutex update_lock;
+	unsigned long last_battery;	/* In jiffies */
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 	u16 temp[SCH5627_NO_TEMPS];
@@ -243,6 +245,12 @@ static int sch5627_read_virtual_reg(struct sch5627_data *data, u16 reg)
 	return sch5627_send_cmd(data, SCH5627_CMD_READ, reg, 0);
 }
 
+static int sch5627_write_virtual_reg(struct sch5627_data *data,
+				     u16 reg, u8 val)
+{
+	return sch5627_send_cmd(data, SCH5627_CMD_WRITE, reg, val);
+}
+
 static int sch5627_read_virtual_reg16(struct sch5627_data *data, u16 reg)
 {
 	int lsb, msb;
@@ -287,6 +295,13 @@ static struct sch5627_data *sch5627_update_device(struct device *dev)
 
 	mutex_lock(&data->update_lock);
 
+	/* Trigger a Vbat voltage measurement every 5 minutes */
+	if (time_after(jiffies, data->last_battery + 300 * HZ)) {
+		sch5627_write_virtual_reg(data, SCH5627_REG_CTRL,
+					  data->control | 0x10);
+		data->last_battery = jiffies;
+	}
+
 	/* Cache the values for 1 second */
 	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 		for (i = 0; i < SCH5627_NO_TEMPS; i++) {
@@ -711,11 +726,17 @@ static int __devinit sch5627_probe(struct platform_device *pdev)
 		err = val;
 		goto error;
 	}
-	if (!(val & 0x01)) {
+	data->control = val;
+	if (!(data->control & 0x01)) {
 		pr_err("hardware monitoring not enabled\n");
 		err = -ENODEV;
 		goto error;
 	}
+	/* Trigger a Vbat voltage measurement, so that we get a valid reading
+	   the first time we read Vbat */
+	sch5627_write_virtual_reg(data, SCH5627_REG_CTRL,
+				  data->control | 0x10);
+	data->last_battery = jiffies;
 
 	/*
 	 * Read limits, we do this only once as reading a register on
-- 
1.7.5.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
