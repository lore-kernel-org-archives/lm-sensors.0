From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 05 Aug 2014 16:57:03 +0000
Subject: [lm-sensors] [PATCH] hwmon: (emc6w201) Fix temperature limit range
Message-Id: <1407257823-6845-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Temperature limit range is [-128, 127], not [-127, 128].
The wrong range caused a bad limit to be written into the chip
if the limit was set to a value of 128 degrees C or above.

Also use DIV_ROUND_CLOSEST instead of a plan divide operation
to reduce the rounding error when writing temperature limits.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc6w201.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/emc6w201.c b/drivers/hwmon/emc6w201.c
index e87da90..80c2f42 100644
--- a/drivers/hwmon/emc6w201.c
+++ b/drivers/hwmon/emc6w201.c
@@ -252,12 +252,12 @@ static ssize_t set_temp(struct device *dev, struct device_attribute *devattr,
 	if (err < 0)
 		return err;
 
-	val /= 1000;
+	val = DIV_ROUND_CLOSEST(val, 1000);
 	reg = (sf = min) ? EMC6W201_REG_TEMP_LOW(nr)
 			  : EMC6W201_REG_TEMP_HIGH(nr);
 
 	mutex_lock(&data->update_lock);
-	data->temp[sf][nr] = clamp_val(val, -127, 128);
+	data->temp[sf][nr] = clamp_val(val, -128, 127);
 	err = emc6w201_write8(client, reg, data->temp[sf][nr]);
 	mutex_unlock(&data->update_lock);
 
-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
