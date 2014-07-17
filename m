From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 17 Jul 2014 11:15:36 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (smsc47m1) Avoid forward declaration
Message-Id: <1405595736.13586.6.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/smsc47m1.c | 115 +++++++++++++++++++++++------------------------
 1 file changed, 55 insertions(+), 60 deletions(-)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index 23a22c4..d748565 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -142,11 +142,6 @@ struct smsc47m1_sio_data {
 	u8 activate;		/* Remember initial device state */
 };
 
-
-static int __exit smsc47m1_remove(struct platform_device *pdev);
-static struct smsc47m1_data *smsc47m1_update_device(struct device *dev,
-		int init);
-
 static inline int smsc47m1_read_value(struct smsc47m1_data *data, u8 reg)
 {
 	return inb_p(data->addr + reg);
@@ -158,13 +153,54 @@ static inline void smsc47m1_write_value(struct smsc47m1_data *data, u8 reg,
 	outb_p(value, data->addr + reg);
 }
 
-static struct platform_driver smsc47m1_driver = {
-	.driver = {
-		.owner	= THIS_MODULE,
-		.name	= DRVNAME,
-	},
-	.remove		= __exit_p(smsc47m1_remove),
-};
+static struct smsc47m1_data *smsc47m1_update_device(struct device *dev,
+		int init)
+{
+	struct smsc47m1_data *data = dev_get_drvdata(dev);
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2) || init) {
+		int i, fan_nr;
+		fan_nr = data->type = smsc47m2 ? 3 : 2;
+
+		for (i = 0; i < fan_nr; i++) {
+			data->fan[i] = smsc47m1_read_value(data,
+				       SMSC47M1_REG_FAN[i]);
+			data->fan_preload[i] = smsc47m1_read_value(data,
+					       SMSC47M1_REG_FAN_PRELOAD[i]);
+			data->pwm[i] = smsc47m1_read_value(data,
+				       SMSC47M1_REG_PWM[i]);
+		}
+
+		i = smsc47m1_read_value(data, SMSC47M1_REG_FANDIV);
+		data->fan_div[0] = (i >> 4) & 0x03;
+		data->fan_div[1] = i >> 6;
+
+		data->alarms = smsc47m1_read_value(data,
+			       SMSC47M1_REG_ALARM) >> 6;
+		/* Clear alarms if needed */
+		if (data->alarms)
+			smsc47m1_write_value(data, SMSC47M1_REG_ALARM, 0xC0);
+
+		if (fan_nr >= 3) {
+			data->fan_div[2] = (smsc47m1_read_value(data,
+					    SMSC47M2_REG_FANDIV3) >> 4) & 0x03;
+			data->alarms |= (smsc47m1_read_value(data,
+					 SMSC47M2_REG_ALARM6) & 0x40) >> 4;
+			/* Clear alarm if needed */
+			if (data->alarms & 0x04)
+				smsc47m1_write_value(data,
+						     SMSC47M2_REG_ALARM6,
+						     0x40);
+		}
+
+		data->last_updated = jiffies;
+	}
+
+	mutex_unlock(&data->update_lock);
+	return data;
+}
 
 static ssize_t get_fan(struct device *dev, struct device_attribute
 		       *devattr, char *buf)
@@ -811,54 +847,13 @@ static int __exit smsc47m1_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct smsc47m1_data *smsc47m1_update_device(struct device *dev,
-		int init)
-{
-	struct smsc47m1_data *data = dev_get_drvdata(dev);
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2) || init) {
-		int i, fan_nr;
-		fan_nr = data->type = smsc47m2 ? 3 : 2;
-
-		for (i = 0; i < fan_nr; i++) {
-			data->fan[i] = smsc47m1_read_value(data,
-				       SMSC47M1_REG_FAN[i]);
-			data->fan_preload[i] = smsc47m1_read_value(data,
-					       SMSC47M1_REG_FAN_PRELOAD[i]);
-			data->pwm[i] = smsc47m1_read_value(data,
-				       SMSC47M1_REG_PWM[i]);
-		}
-
-		i = smsc47m1_read_value(data, SMSC47M1_REG_FANDIV);
-		data->fan_div[0] = (i >> 4) & 0x03;
-		data->fan_div[1] = i >> 6;
-
-		data->alarms = smsc47m1_read_value(data,
-			       SMSC47M1_REG_ALARM) >> 6;
-		/* Clear alarms if needed */
-		if (data->alarms)
-			smsc47m1_write_value(data, SMSC47M1_REG_ALARM, 0xC0);
-
-		if (fan_nr >= 3) {
-			data->fan_div[2] = (smsc47m1_read_value(data,
-					    SMSC47M2_REG_FANDIV3) >> 4) & 0x03;
-			data->alarms |= (smsc47m1_read_value(data,
-					 SMSC47M2_REG_ALARM6) & 0x40) >> 4;
-			/* Clear alarm if needed */
-			if (data->alarms & 0x04)
-				smsc47m1_write_value(data,
-						     SMSC47M2_REG_ALARM6,
-						     0x40);
-		}
-
-		data->last_updated = jiffies;
-	}
-
-	mutex_unlock(&data->update_lock);
-	return data;
-}
+static struct platform_driver smsc47m1_driver = {
+	.driver = {
+		.owner	= THIS_MODULE,
+		.name	= DRVNAME,
+	},
+	.remove		= __exit_p(smsc47m1_remove),
+};
 
 static int __init smsc47m1_device_add(unsigned short address,
 				      const struct smsc47m1_sio_data *sio_data)
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
