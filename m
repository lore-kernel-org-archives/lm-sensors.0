From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 19 May 2013 14:54:16 +0000
Subject: [lm-sensors] [PATCH] hwmon: (lm90) Drop redundant safety on cache lifetime
Message-Id: <20130519165416.3165eb43@endymion.delvare>
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
---
Tested OK on my ADM1032 evaluation board.

 drivers/hwmon/lm90.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-3.10-rc1.orig/drivers/hwmon/lm90.c	2013-04-29 02:36:01.000000000 +0200
+++ linux-3.10-rc1/drivers/hwmon/lm90.c	2013-05-19 16:34:07.915505072 +0200
@@ -470,8 +470,8 @@ static struct lm90_data *lm90_update_dev
 
 	mutex_lock(&data->update_lock);
 
-	next_update = data->last_updated
-	  + msecs_to_jiffies(data->update_interval) + 1;
+	next_update = data->last_updated +
+		      msecs_to_jiffies(data->update_interval);
 	if (time_after(jiffies, next_update) || !data->valid) {
 		u8 h, l;
 		u8 alarms;


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
