From: Axel Lin <axel.lin@ingics.com>
Date: Thu, 31 Jul 2014 07:31:54 +0000
Subject: [lm-sensors] [PATCH v2 2/2] hwmon: (lm92) Prevent overflow problem when writing large limits
Message-Id: <1406791914.7637.2.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On platforms with sizeof(int) < sizeof(long), writing a temperature
limit larger than MAXINT will result in unpredictable limit values
written to the chip. Avoid auto-conversion from long to int to fix
the problem.
For set_temp_hyst, clamp the input values to the supported limits first
to fix the problem.
Also uses clamp_val in TEMP_TO_REG to simplify the code a bit.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/hwmon/lm92.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/lm92.c b/drivers/hwmon/lm92.c
index d2060e2..481abe2 100644
--- a/drivers/hwmon/lm92.c
+++ b/drivers/hwmon/lm92.c
@@ -74,12 +74,9 @@ static inline int TEMP_FROM_REG(s16 reg)
 	return reg / 8 * 625 / 10;
 }
 
-static inline s16 TEMP_TO_REG(int val)
+static inline s16 TEMP_TO_REG(long val)
 {
-	if (val <= -60000)
-		return -60000 * 10 / 625 * 8;
-	if (val >= 160000)
-		return 160000 * 10 / 625 * 8;
+	val = clamp_val(val, -60000, 160000);
 	return val * 10 / 625 * 8;
 }
 
@@ -206,6 +203,7 @@ static ssize_t set_temp_hyst(struct device *dev,
 	if (err)
 		return err;
 
+	val = clamp_val(val, -60000, 160000);
 	mutex_lock(&data->update_lock);
 	data->temp[t_hyst] = TEMP_FROM_REG(data->temp[attr->index]) - val;
 	i2c_smbus_write_word_swapped(client, LM92_REG_TEMP_HYST,
-- 
1.9.1




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
