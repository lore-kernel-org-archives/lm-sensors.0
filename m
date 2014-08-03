From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 03 Aug 2014 03:41:40 +0000
Subject: [lm-sensors] [RFT][PATCH 1/2] hwmon: (via686a) Avoid forward declaration
Message-Id: <1407037300.30587.0.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Reorder functions to avoid forward declaration.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/via686a.c | 180 +++++++++++++++++++++++-------------------------
 1 file changed, 88 insertions(+), 92 deletions(-)

diff --git a/drivers/hwmon/via686a.c b/drivers/hwmon/via686a.c
index babd732..a995986 100644
--- a/drivers/hwmon/via686a.c
+++ b/drivers/hwmon/via686a.c
@@ -349,8 +349,94 @@ static inline void via686a_write_value(struct via686a_data *data, u8 reg,
 	outb_p(value, data->addr + reg);
 }
 
-static struct via686a_data *via686a_update_device(struct device *dev);
-static void via686a_init_device(struct via686a_data *data);
+static void via686a_update_fan_div(struct via686a_data *data)
+{
+	int reg = via686a_read_value(data, VIA686A_REG_FANDIV);
+	data->fan_div[0] = (reg >> 4) & 0x03;
+	data->fan_div[1] = reg >> 6;
+}
+
+static void via686a_init_device(struct via686a_data *data)
+{
+	u8 reg;
+
+	/* Start monitoring */
+	reg = via686a_read_value(data, VIA686A_REG_CONFIG);
+	via686a_write_value(data, VIA686A_REG_CONFIG, (reg | 0x01) & 0x7F);
+
+	/* Configure temp interrupt mode for continuous-interrupt operation */
+	reg = via686a_read_value(data, VIA686A_REG_TEMP_MODE);
+	via686a_write_value(data, VIA686A_REG_TEMP_MODE,
+			    (reg & ~VIA686A_TEMP_MODE_MASK)
+			    | VIA686A_TEMP_MODE_CONTINUOUS);
+
+	/* Pre-read fan clock divisor values */
+	via686a_update_fan_div(data);
+}
+
+static struct via686a_data *via686a_update_device(struct device *dev)
+{
+	struct via686a_data *data = dev_get_drvdata(dev);
+	int i;
+
+	mutex_lock(&data->update_lock);
+
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
+	    || !data->valid) {
+		for (i = 0; i <= 4; i++) {
+			data->in[i] +			    via686a_read_value(data, VIA686A_REG_IN(i));
+			data->in_min[i] = via686a_read_value(data,
+							     VIA686A_REG_IN_MIN
+							     (i));
+			data->in_max[i] +			    via686a_read_value(data, VIA686A_REG_IN_MAX(i));
+		}
+		for (i = 1; i <= 2; i++) {
+			data->fan[i - 1] +			    via686a_read_value(data, VIA686A_REG_FAN(i));
+			data->fan_min[i - 1] = via686a_read_value(data,
+						     VIA686A_REG_FAN_MIN(i));
+		}
+		for (i = 0; i <= 2; i++) {
+			data->temp[i] = via686a_read_value(data,
+						 VIA686A_REG_TEMP[i]) << 2;
+			data->temp_over[i] +			    via686a_read_value(data,
+					       VIA686A_REG_TEMP_OVER[i]);
+			data->temp_hyst[i] +			    via686a_read_value(data,
+					       VIA686A_REG_TEMP_HYST[i]);
+		}
+		/*
+		 * add in lower 2 bits
+		 * temp1 uses bits 7-6 of VIA686A_REG_TEMP_LOW1
+		 * temp2 uses bits 5-4 of VIA686A_REG_TEMP_LOW23
+		 * temp3 uses bits 7-6 of VIA686A_REG_TEMP_LOW23
+		 */
+		data->temp[0] |= (via686a_read_value(data,
+						     VIA686A_REG_TEMP_LOW1)
+				  & 0xc0) >> 6;
+		data->temp[1] |+		    (via686a_read_value(data, VIA686A_REG_TEMP_LOW23) &
+		     0x30) >> 4;
+		data->temp[2] |+		    (via686a_read_value(data, VIA686A_REG_TEMP_LOW23) &
+		     0xc0) >> 6;
+
+		via686a_update_fan_div(data);
+		data->alarms +		    via686a_read_value(data,
+				       VIA686A_REG_ALARM1) |
+		    (via686a_read_value(data, VIA686A_REG_ALARM2) << 8);
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	mutex_unlock(&data->update_lock);
+
+	return data;
+}
 
 /* following are the sysfs callback functions */
 
@@ -677,7 +763,6 @@ static struct platform_driver via686a_driver = {
 	.remove		= via686a_remove,
 };
 
-
 /* This is called when the module is loaded */
 static int via686a_probe(struct platform_device *pdev)
 {
@@ -735,95 +820,6 @@ static int via686a_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static void via686a_update_fan_div(struct via686a_data *data)
-{
-	int reg = via686a_read_value(data, VIA686A_REG_FANDIV);
-	data->fan_div[0] = (reg >> 4) & 0x03;
-	data->fan_div[1] = reg >> 6;
-}
-
-static void via686a_init_device(struct via686a_data *data)
-{
-	u8 reg;
-
-	/* Start monitoring */
-	reg = via686a_read_value(data, VIA686A_REG_CONFIG);
-	via686a_write_value(data, VIA686A_REG_CONFIG, (reg | 0x01) & 0x7F);
-
-	/* Configure temp interrupt mode for continuous-interrupt operation */
-	reg = via686a_read_value(data, VIA686A_REG_TEMP_MODE);
-	via686a_write_value(data, VIA686A_REG_TEMP_MODE,
-			    (reg & ~VIA686A_TEMP_MODE_MASK)
-			    | VIA686A_TEMP_MODE_CONTINUOUS);
-
-	/* Pre-read fan clock divisor values */
-	via686a_update_fan_div(data);
-}
-
-static struct via686a_data *via686a_update_device(struct device *dev)
-{
-	struct via686a_data *data = dev_get_drvdata(dev);
-	int i;
-
-	mutex_lock(&data->update_lock);
-
-	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
-	    || !data->valid) {
-		for (i = 0; i <= 4; i++) {
-			data->in[i] -			    via686a_read_value(data, VIA686A_REG_IN(i));
-			data->in_min[i] = via686a_read_value(data,
-							     VIA686A_REG_IN_MIN
-							     (i));
-			data->in_max[i] -			    via686a_read_value(data, VIA686A_REG_IN_MAX(i));
-		}
-		for (i = 1; i <= 2; i++) {
-			data->fan[i - 1] -			    via686a_read_value(data, VIA686A_REG_FAN(i));
-			data->fan_min[i - 1] = via686a_read_value(data,
-						     VIA686A_REG_FAN_MIN(i));
-		}
-		for (i = 0; i <= 2; i++) {
-			data->temp[i] = via686a_read_value(data,
-						 VIA686A_REG_TEMP[i]) << 2;
-			data->temp_over[i] -			    via686a_read_value(data,
-					       VIA686A_REG_TEMP_OVER[i]);
-			data->temp_hyst[i] -			    via686a_read_value(data,
-					       VIA686A_REG_TEMP_HYST[i]);
-		}
-		/*
-		 * add in lower 2 bits
-		 * temp1 uses bits 7-6 of VIA686A_REG_TEMP_LOW1
-		 * temp2 uses bits 5-4 of VIA686A_REG_TEMP_LOW23
-		 * temp3 uses bits 7-6 of VIA686A_REG_TEMP_LOW23
-		 */
-		data->temp[0] |= (via686a_read_value(data,
-						     VIA686A_REG_TEMP_LOW1)
-				  & 0xc0) >> 6;
-		data->temp[1] |-		    (via686a_read_value(data, VIA686A_REG_TEMP_LOW23) &
-		     0x30) >> 4;
-		data->temp[2] |-		    (via686a_read_value(data, VIA686A_REG_TEMP_LOW23) &
-		     0xc0) >> 6;
-
-		via686a_update_fan_div(data);
-		data->alarms -		    via686a_read_value(data,
-				       VIA686A_REG_ALARM1) |
-		    (via686a_read_value(data, VIA686A_REG_ALARM2) << 8);
-		data->last_updated = jiffies;
-		data->valid = 1;
-	}
-
-	mutex_unlock(&data->update_lock);
-
-	return data;
-}
-
 static const struct pci_device_id via686a_pci_ids[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C686_4) },
 	{ }
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
