From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 21 Apr 2013 16:42:23 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (nct6775) Fix coding style problems
Message-Id: <1366562543-29314-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add space around binary operators (CodingStyle, chapter 3.1).

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 14da90e..f43f5e5 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -833,7 +833,7 @@ static void nct6775_update_fan_div(struct nct6775_data *data)
 	data->fan_div[1] = (i & 0x70) >> 4;
 	i = nct6775_read_value(data, NCT6775_REG_FANDIV2);
 	data->fan_div[2] = i & 0x7;
-	if (data->has_fan & (1<<3))
+	if (data->has_fan & (1 << 3))
 		data->fan_div[3] = (i & 0x70) >> 4;
 }
 
@@ -1076,7 +1076,7 @@ static struct nct6775_data *nct6775_update_device(struct device *dev)
 
 	mutex_lock(&data->update_lock);
 
-	if (time_after(jiffies, data->last_updated + HZ + HZ/2)
+	if (time_after(jiffies, data->last_updated + HZ + HZ / 2)
 	    || !data->valid) {
 		/* Fan clock dividers */
 		nct6775_update_fan_div_common(data);
@@ -1177,7 +1177,7 @@ store_in_reg(struct device *dev, struct device_attribute *attr, const char *buf,
 		return err;
 	mutex_lock(&data->update_lock);
 	data->in[nr][index] = in_to_reg(val, nr);
-	nct6775_write_value(data, data->REG_IN_MINMAX[index-1][nr],
+	nct6775_write_value(data, data->REG_IN_MINMAX[index - 1][nr],
 			    data->in[nr][index]);
 	mutex_unlock(&data->update_lock);
 	return count;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
