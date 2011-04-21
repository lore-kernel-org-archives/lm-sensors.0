From: Hans de Goede <hdegoede@redhat.com>
Date: Thu, 21 Apr 2011 13:35:19 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon/sch5627: Trigger Vbat measurements
Message-Id: <1303392919-3667-2-git-send-email-hdegoede@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The sch5627 needs to be explicitly told to start an adc conversion
for Vbat, once in a while. Without this Vbat may read 0, and will never
get updated.

Signed-off-By: Hans de Goede <hdegoede@redhat.com>
---
 drivers/hwmon/sch5627.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/sch5627.c b/drivers/hwmon/sch5627.c
index 09a47bf..e23ea34 100644
--- a/drivers/hwmon/sch5627.c
+++ b/drivers/hwmon/sch5627.c
@@ -94,6 +94,7 @@ static const char * const SCH5627_IN_LABELS[SCH5627_NO_IN] = {
 struct sch5627_data {
 	unsigned short addr;
 	struct device *hwmon_dev;
+	u8 control;
 	u8 temp_max[SCH5627_NO_TEMPS];
 	u8 temp_crit[SCH5627_NO_TEMPS];
 	u16 fan_min[SCH5627_NO_FANS];
@@ -101,6 +102,7 @@ struct sch5627_data {
 	struct mutex update_lock;
 	char valid;			/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
+	unsigned long last_battery;	/* In jiffies */
 	u16 temp[SCH5627_NO_TEMPS];
 	u16 fan[SCH5627_NO_FANS];
 	u16 in[SCH5627_NO_IN];
@@ -327,6 +329,14 @@ static struct sch5627_data *sch5627_update_device(struct device *dev)
 		}
 
 		data->last_updated = jiffies;
+	}
+
+	/* Trigger a Vbat voltage measurement every minute */
+	if (time_after(jiffies, data->last_battery + 60 * HZ) ||
+	    !data->valid) {
+		sch5627_write_virtual_reg(data, SCH5627_REG_CTRL,
+					  data->control | 0x10);
+		data->last_battery = jiffies;
 		data->valid = 1;
 	}
 abort:
@@ -714,11 +724,16 @@ static int __devinit sch5627_probe(struct platform_device *pdev)
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
 
 	/*
 	 * Read limits, we do this only once as reading a register on
-- 
1.7.4.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
