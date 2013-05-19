From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 May 2013 14:57:30 +0000
Subject: [lm-sensors] [PATCH] hwmon: (tmp401) Drop redundant safety on cache lifetime
Message-Id: <20130519165730.2a7425d1@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

time_after (as opposed to time_after_equal) already ensures that the
cache lifetime is at least as much as requested. There is no point in
manually adding another jiffy to that value, and this can confuse the
reader into wrong interpretation.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Imre Deak <imre.deak@intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/tmp401.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-3.10-rc1.orig/drivers/hwmon/tmp401.c	2013-05-13 15:27:46.025131385 +0200
+++ linux-3.10-rc1/drivers/hwmon/tmp401.c	2013-05-19 16:33:09.964274086 +0200
@@ -240,7 +240,7 @@ static struct tmp401_data *tmp401_update
 	mutex_lock(&data->update_lock);
 
 	next_update = data->last_updated +
-		      msecs_to_jiffies(data->update_interval) + 1;
+		      msecs_to_jiffies(data->update_interval);
 	if (time_after(jiffies, next_update) || !data->valid) {
 		if (data->kind != tmp432) {
 			/*


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
