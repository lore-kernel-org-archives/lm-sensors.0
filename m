From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 14 Oct 2010 08:00:02 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (lm85) Add support for ADT7468
Message-Id: <20101014100002.66ab5504@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The ADT7468 supports a high-frequency PWM output mode where all PWM
outputs are driven by a 22.5 kHz clock. Add support for this mode, and
document it, as it may surprise the user that setting one PWM output
frequency also affects the other PWM outputs.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Darrick J. Wong <djwong@us.ibm.com>
---
 Documentation/hwmon/lm85 |    7 +++++++
 drivers/hwmon/lm85.c     |   35 ++++++++++++++++++++++++++++-------
 2 files changed, 35 insertions(+), 7 deletions(-)

--- linux-2.6.36-rc7.orig/drivers/hwmon/lm85.c	2010-10-14 09:30:12.000000000 +0200
+++ linux-2.6.36-rc7/drivers/hwmon/lm85.c	2010-10-14 09:49:07.000000000 +0200
@@ -64,9 +64,12 @@ enum chips {
 #define	LM85_REG_VERSTEP		0x3f
 
 #define	ADT7468_REG_CFG5		0x7c
-#define		ADT7468_OFF64		0x01
+#define		ADT7468_OFF64		(1 << 0)
+#define		ADT7468_HFPWM		(1 << 1)
 #define	IS_ADT7468_OFF64(data)		\
 	((data)->type = adt7468 && !((data)->cfg5 & ADT7468_OFF64))
+#define	IS_ADT7468_HFPWM(data)		\
+	((data)->type = adt7468 && !((data)->cfg5 & ADT7468_HFPWM))
 
 /* These are the recognized values for the above regs */
 #define	LM85_COMPANY_NATIONAL		0x01
@@ -567,8 +570,14 @@ static ssize_t show_pwm_freq(struct devi
 {
 	int nr = to_sensor_dev_attr(attr)->index;
 	struct lm85_data *data = lm85_update_device(dev);
-	return sprintf(buf, "%d\n", FREQ_FROM_REG(data->freq_map,
-						  data->pwm_freq[nr]));
+	int freq;
+
+	if (IS_ADT7468_HFPWM(data))
+		freq = 22500;
+	else
+		freq = FREQ_FROM_REG(data->freq_map, data->pwm_freq[nr]);
+
+	return sprintf(buf, "%d\n", freq);
 }
 
 static ssize_t set_pwm_freq(struct device *dev,
@@ -580,10 +589,22 @@ static ssize_t set_pwm_freq(struct devic
 	long val = simple_strtol(buf, NULL, 10);
 
 	mutex_lock(&data->update_lock);
-	data->pwm_freq[nr] = FREQ_TO_REG(data->freq_map, val);
-	lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
-		(data->zone[nr].range << 4)
-		| data->pwm_freq[nr]);
+	/* The ADT7468 has a special high-frequency PWM output mode,
+	 * where all PWM outputs are driven by a 22.5 kHz clock.
+	 * This might confuse the user, but there's not much we can do. */
+	if (data->type = adt7468 && val >= 11300) {	/* High freq. mode */
+		data->cfg5 &= ~ADT7468_HFPWM;
+		lm85_write_value(client, ADT7468_REG_CFG5, data->cfg5);
+	} else {					/* Low freq. mode */
+		data->pwm_freq[nr] = FREQ_TO_REG(data->freq_map, val);
+		lm85_write_value(client, LM85_REG_AFAN_RANGE(nr),
+				 (data->zone[nr].range << 4)
+				 | data->pwm_freq[nr]);
+		if (data->type = adt7468) {
+			data->cfg5 |= ADT7468_HFPWM;
+			lm85_write_value(client, ADT7468_REG_CFG5, data->cfg5);
+		}
+	}
 	mutex_unlock(&data->update_lock);
 	return count;
 }
--- linux-2.6.36-rc7.orig/Documentation/hwmon/lm85	2010-10-14 09:32:33.000000000 +0200
+++ linux-2.6.36-rc7/Documentation/hwmon/lm85	2010-10-14 09:34:35.000000000 +0200
@@ -101,6 +101,13 @@ Devices has confirmed this "bug". The AD
 described in the documentation. The current lm85 driver does not show the
 offset register.
 
+The ADT7468 has a high-frequency PWM mode, where all PWM outputs are
+driven by a 22.5 kHz clock. This is a global mode, not per-PWM output,
+which means that setting any PWM frequency above 11.3 kHz will switch
+all 3 PWM outputs to a 22.5 kHz frequency. Conversely, setting any PWM
+frequency below 11.3 kHz will switch all 3 PWM outputs to a frequency
+between 10 and 100 Hz, which can then be tuned separately.
+
 See the vendor datasheets for more information. There is application note
 from National (AN-1260) with some additional information about the LM85.
 The Analog Devices datasheet is very detailed and describes a procedure for


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
