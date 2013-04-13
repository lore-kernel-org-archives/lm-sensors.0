From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 13 Apr 2013 15:44:16 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct6775) Use ARRAY_SIZE for loops where possible
Message-Id: <1365867856-10353-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

This ensures that the loop iterations are correct even if/when
the number of elements in an array changes.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 8d0e4c4..04ccfff 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -854,7 +854,7 @@ static void nct6775_init_fan_div(struct nct6775_data *data)
 	 * reading from the fan count register, even if it is not optimal.
 	 * We'll compute a better divider later on.
 	 */
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < ARRAY_SIZE(data->fan_div); i++) {
 		if (!(data->has_fan & (1 << i)))
 			continue;
 		if (data->fan_div[i] = 0) {
@@ -877,7 +877,7 @@ static void nct6775_init_fan_common(struct device *dev,
 	 * If fan_min is not set (0), set it to 0xff to disable it. This
 	 * prevents the unnecessary warning when fanX_min is reported as 0.
 	 */
-	for (i = 0; i < 5; i++) {
+	for (i = 0; i < ARRAY_SIZE(data->fan_min); i++) {
 		if (data->has_fan_min & (1 << i)) {
 			reg = nct6775_read_value(data, data->REG_FAN_MIN[i]);
 			if (!reg)
@@ -994,7 +994,7 @@ static void nct6775_update_pwm(struct device *dev)
 			data->pwm_weight_temp_sel[i] = 0;
 
 		/* Weight temp data */
-		for (j = 0; j < 3; j++) {
+		for (j = 0; j < ARRAY_SIZE(data->weight_temp); j++) {
 			data->weight_temp[j][i]
 			  = nct6775_read_value(data,
 					       data->REG_WEIGHT_TEMP[j][i]);
@@ -1013,7 +1013,7 @@ static void nct6775_update_pwm_limits(struct device *dev)
 		if (!(data->has_pwm & (1 << i)))
 			continue;
 
-		for (j = 0; j < 3; j++) {
+		for (j = 0; j < ARRAY_SIZE(data->fan_time); j++) {
 			data->fan_time[j][i]  			  nct6775_read_value(data, data->REG_FAN_TIME[j][i]);
 		}
@@ -1095,7 +1095,7 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 		}
 
 		/* Measured fan speeds and limits */
-		for (i = 0; i < 5; i++) {
+		for (i = 0; i < ARRAY_SIZE(data->rpm); i++) {
 			u16 reg;
 
 			if (!(data->has_fan & (1 << i)))
@@ -1121,7 +1121,7 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 		for (i = 0; i < NUM_TEMP; i++) {
 			if (!(data->have_temp & (1 << i)))
 				continue;
-			for (j = 0; j < 4; j++) {
+			for (j = 0; j < ARRAY_SIZE(data->reg_temp); j++) {
 				if (data->reg_temp[j][i])
 					data->temp[j][i]
 					  = nct6775_read_temp(data,
@@ -3983,7 +3983,7 @@ static int nct6775_resume(struct device *dev)
 				    data->in[i][2]);
 	}
 
-	for (i = 0; i < 5; i++) {
+	for (i = 0; i < ARRAY_SIZE(data->fan_min); i++) {
 		if (!(data->has_fan_min & (1 << i)))
 			continue;
 
@@ -3995,7 +3995,7 @@ static int nct6775_resume(struct device *dev)
 		if (!(data->have_temp & (1 << i)))
 			continue;
 
-		for (j = 1; j < 4; j++)
+		for (j = 1; j < ARRAY_SIZE(data->reg_temp); j++)
 			if (data->reg_temp[j][i])
 				nct6775_write_temp(data, data->reg_temp[j][i],
 						   data->temp[j][i]);
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
