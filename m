From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 26 Feb 2013 18:23:39 +0000
Subject: [lm-sensors] [PATCH v5 11/12] hwmon: (nct6775) Detect and report additional temperature sources
Message-Id: <1361903020-18526-12-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1361903020-18526-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1361903020-18526-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

Scan all temperature sources used for fan control and report if additional
monitoring registers are available.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |   33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 50e38c6..a4b076a 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -3361,6 +3361,32 @@ nct6775_check_fan_inputs(const struct nct6775_sio_data *sio_data,
 	return 0;
 }
 
+static void add_temp_sensors(struct nct6775_data *data, const u16 *regp,
+			     int *available, int *mask)
+{
+	int i;
+	u8 src;
+
+	for (i = 0; i < data->pwm_num && *available; i++) {
+		int index;
+
+		if (!regp[i])
+			continue;
+		src = nct6775_read_value(data, regp[i]);
+		src &= 0x1f;
+		if (!src || (*mask & (1 << src)))
+			continue;
+		if (src >= data->temp_label_num ||
+		    !strlen(data->temp_label[src]))
+			continue;
+
+		index = __ffs(*available);
+		nct6775_write_value(data, data->REG_TEMP_SOURCE[index], src);
+		*available &= ~(1 << index);
+		*mask |= 1 << src;
+	}
+}
+
 static int nct6775_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -3611,6 +3637,13 @@ static int nct6775_probe(struct platform_device *pdev)
 		mask |= 1 << src;
 	}
 
+	/*
+	 * Now find unmonitored temperature registers and enable monitoring
+	 * if additional monitoring registers are available.
+	 */
+	add_temp_sensors(data, data->REG_TEMP_SEL, &available, &mask);
+	add_temp_sensors(data, data->REG_WEIGHT_TEMP_SEL, &available, &mask);
+
 	mask = 0;
 	s = NUM_TEMP_FIXED;	/* First dynamic temperature attribute */
 	for (i = 0; i < num_reg_temp; i++) {
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
