From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 14 Sep 2013 08:33:25 +0000
Subject: [lm-sensors] [PATCH 02/12] hwmon: (nct6775) Use return value from find_temp_source
Message-Id: <1379147615-7703-3-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

smatch complains that we don't use the return value from find_temp_source().
Valid point, only find_temp_source() doesn't return a valid error code.
Have it return a valid error code and use it.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/nct6775.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/nct6775.c b/drivers/hwmon/nct6775.c
index 6eb03ce..de57e0d 100644
--- a/drivers/hwmon/nct6775.c
+++ b/drivers/hwmon/nct6775.c
@@ -1545,7 +1545,7 @@ static int find_temp_source(struct nct6775_data *data, int index, int count)
 		if (src = source)
 			return nr;
 	}
-	return -1;
+	return -ENODEV;
 }
 
 static ssize_t
@@ -1644,7 +1644,7 @@ store_temp_beep(struct device *dev, struct device_attribute *attr,
 
 	nr = find_temp_source(data, sattr->index, data->num_temp_beeps);
 	if (nr < 0)
-		return -ENODEV;
+		return nr;
 
 	bit = data->BEEP_BITS[nr + TEMP_ALARM_BASE];
 	regindex = bit >> 3;
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
