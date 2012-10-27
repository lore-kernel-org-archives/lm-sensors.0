From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 27 Oct 2012 16:41:01 +0000
Subject: [lm-sensors] [PATCH 3/3] hwmon: (w83627ehf) Add support for SmartFanIV mode on W83667HG-B
Message-Id: <1351356061-30514-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111031152342.15f99729@endymion.delvare>
In-Reply-To: <20111031152342.15f99729@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

SmartFan IV mode is supported on W83667HG-B, but configured differently than
on other chips and not detected. As a result, changing the fan control mode
was impossible if SmartFan IV mode is selected.

Detect SmartFan IV mode and make it configurable if was configured at system
startup.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Candidate for stable or too complex ?

 drivers/hwmon/w83627ehf.c |   34 ++++++++++++++++++++++++++++++----
 1 file changed, 30 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/w83627ehf.c b/drivers/hwmon/w83627ehf.c
index a30eb52..ab0ec3b 100644
--- a/drivers/hwmon/w83627ehf.c
+++ b/drivers/hwmon/w83627ehf.c
@@ -243,6 +243,8 @@ static const u16 W83627EHF_REG_FAN_STEP_OUTPUT_W83667_B[]
 
 static const u16 W83627EHF_REG_TEMP_OFFSET[] = { 0x454, 0x455, 0x456 };
 
+static const u16 W83627HCB_REG_FAN_MODE[] = { 0x950, 0xa50, 0xb50 };
+
 static const u16 NCT6775_REG_TARGET[] = { 0x101, 0x201, 0x301 };
 static const u16 NCT6775_REG_FAN_MODE[] = { 0x102, 0x202, 0x302 };
 static const u16 NCT6775_REG_FAN_STOP_OUTPUT[] = { 0x105, 0x205, 0x305 };
@@ -754,7 +756,8 @@ static void nct6775_update_pwm(struct w83627ehf_data *data)
 	}
 }
 
-static void w83627ehf_update_pwm(struct w83627ehf_data *data)
+static void w83627ehf_update_pwm(struct w83627ehf_sio_data *sio_data,
+				 struct w83627ehf_data *data)
 {
 	int i;
 	int pwmcfg = 0, tolerance = 0; /* shut up the compiler */
@@ -772,8 +775,19 @@ static void w83627ehf_update_pwm(struct w83627ehf_data *data)
 		}
 		data->pwm_mode[i]  			((pwmcfg >> W83627EHF_PWM_MODE_SHIFT[i]) & 1) ? 0 : 1;
-		data->pwm_enable[i] = ((pwmcfg >> W83627EHF_PWM_ENABLE_SHIFT[i])
-				       & 3) + 1;
+		if (sio_data->kind = w83667hg_b) {
+			u8 mode = w83627ehf_read_value(data,
+						W83627HCB_REG_FAN_MODE[i]);
+			if (mode & 1)
+				data->pwm_enable[i] = 5;
+			else
+				data->pwm_enable[i] +				  ((pwmcfg >> W83627EHF_PWM_ENABLE_SHIFT[i])
+				   & 3) + 1;
+		} else {
+			data->pwm_enable[i] +			  ((pwmcfg >> W83627EHF_PWM_ENABLE_SHIFT[i]) & 3) + 1;
+		}
 		data->pwm[i] = w83627ehf_read_value(data, data->REG_PWM[i]);
 
 		data->tolerance[i] = (tolerance >> (i = 1 ? 4 : 0)) & 0x0f;
@@ -788,7 +802,7 @@ static void w83627ehf_update_pwm_common(struct device *dev,
 	if (sio_data->kind = nct6775 || sio_data->kind = nct6776)
 		nct6775_update_pwm(data);
 	else
-		w83627ehf_update_pwm(data);
+		w83627ehf_update_pwm(sio_data, data);
 }
 
 static struct w83627ehf_data *w83627ehf_update_device(struct device *dev)
@@ -1474,6 +1488,18 @@ store_pwm_enable(struct device *dev, struct device_attribute *attr,
 		reg |= (val - 1) << 4;
 		w83627ehf_write_value(data,
 				      NCT6775_REG_FAN_MODE[nr], reg);
+	} else if (sio_data->kind = w83667hg_b) {
+		w83627ehf_write_value(data, W83627HCB_REG_FAN_MODE[nr],
+				      val = 5 ? 1 : 0);
+		if (val != 5) {
+			reg = w83627ehf_read_value(data,
+					W83627EHF_REG_PWM_ENABLE[nr]);
+			reg &= ~(0x03 << W83627EHF_PWM_ENABLE_SHIFT[nr]);
+			reg |= (val - 1) << W83627EHF_PWM_ENABLE_SHIFT[nr];
+			w83627ehf_write_value(data,
+					      W83627EHF_REG_PWM_ENABLE[nr],
+					      reg);
+		}
 	} else {
 		reg = w83627ehf_read_value(data, W83627EHF_REG_PWM_ENABLE[nr]);
 		reg &= ~(0x03 << W83627EHF_PWM_ENABLE_SHIFT[nr]);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
