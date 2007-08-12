From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 12 Aug 2007 18:47:30 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627ehf) read fan_div values during
Message-Id: <11869444522773-git-send-email-mhoffman@lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Mark M. Hoffman <mhoffman@lightlink.com>

This patch forces the driver to read the fan divider values during early init.
Otherwise, a call to store_fan_min() could access uninitialized variables.

Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627ehf.c |   48 +++++++++++++++++++++++++++-----------------
 1 files changed, 29 insertions(+), 19 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index c51ae2e..bca7fbc 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -421,6 +421,31 @@ static void w83627ehf_write_fan_div(struct w83627ehf_data *data, int nr)
 	}
 }
 
+static void w83627ehf_update_fan_div(struct w83627ehf_data *data)
+{
+	int i;
+
+	i = w83627ehf_read_value(data, W83627EHF_REG_FANDIV1);
+	data->fan_div[0] = (i >> 4) & 0x03;
+	data->fan_div[1] = (i >> 6) & 0x03;
+	i = w83627ehf_read_value(data, W83627EHF_REG_FANDIV2);
+	data->fan_div[2] = (i >> 6) & 0x03;
+	i = w83627ehf_read_value(data, W83627EHF_REG_VBAT);
+	data->fan_div[0] |= (i >> 3) & 0x04;
+	data->fan_div[1] |= (i >> 4) & 0x04;
+	data->fan_div[2] |= (i >> 5) & 0x04;
+	if (data->has_fan & ((1 << 3) | (1 << 4))) {
+		i = w83627ehf_read_value(data, W83627EHF_REG_DIODE);
+		data->fan_div[3] = i & 0x03;
+		data->fan_div[4] = ((i >> 2) & 0x03)
+				 | ((i >> 5) & 0x04);
+	}
+	if (data->has_fan & (1 << 3)) {
+		i = w83627ehf_read_value(data, W83627EHF_REG_SMI_OVT);
+		data->fan_div[3] |= (i >> 5) & 0x04;
+	}
+}
+
 static struct w83627ehf_data *w83627ehf_update_device(struct device *dev)
 {
 	struct w83627ehf_data *data = dev_get_drvdata(dev);
@@ -432,25 +457,7 @@ static struct w83627ehf_data *w83627ehf_update_device(struct device *dev)
 	if (time_after(jiffies, data->last_updated + HZ + HZ/2)
 	 || !data->valid) {
 		/* Fan clock dividers */
-		i = w83627ehf_read_value(data, W83627EHF_REG_FANDIV1);
-		data->fan_div[0] = (i >> 4) & 0x03;
-		data->fan_div[1] = (i >> 6) & 0x03;
-		i = w83627ehf_read_value(data, W83627EHF_REG_FANDIV2);
-		data->fan_div[2] = (i >> 6) & 0x03;
-		i = w83627ehf_read_value(data, W83627EHF_REG_VBAT);
-		data->fan_div[0] |= (i >> 3) & 0x04;
-		data->fan_div[1] |= (i >> 4) & 0x04;
-		data->fan_div[2] |= (i >> 5) & 0x04;
-		if (data->has_fan & ((1 << 3) | (1 << 4))) {
-			i = w83627ehf_read_value(data, W83627EHF_REG_DIODE);
-			data->fan_div[3] = i & 0x03;
-			data->fan_div[4] = ((i >> 2) & 0x03)
-					 | ((i >> 5) & 0x04);
-		}
-		if (data->has_fan & (1 << 3)) {
-			i = w83627ehf_read_value(data, W83627EHF_REG_SMI_OVT);
-			data->fan_div[3] |= (i >> 5) & 0x04;
-		}
+		w83627ehf_update_fan_div(data);
 
 		/* Measured voltages and limits */
 		for (i = 0; i < data->in_num; i++) {
@@ -1312,6 +1319,9 @@ static int __devinit w83627ehf_probe(struct platform_device *pdev)
 	if (!(i & (1 << 1)) && (!fan5pin))
 		data->has_fan |= (1 << 4);
 
+	/* Read fan clock dividers immediately */
+	w83627ehf_update_fan_div(data);
+
 	/* Register sysfs hooks */
   	for (i = 0; i < ARRAY_SIZE(sda_sf3_arrays); i++)
 		if ((err = device_create_file(dev,
-- 
1.5.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
