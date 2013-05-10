From: Imre Deak <imre.deak@intel.com>
Date: Fri, 10 May 2013 12:13:22 +0000
Subject: [lm-sensors] [PATCH 04/11] hwmon/lm63, lm90: take msecs_to_jiffies_min into use
Message-Id: <1368188011-23661-4-git-send-email-imre.deak@intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1368188011-23661-1-git-send-email-imre.deak@intel.com>
In-Reply-To: <1368188011-23661-1-git-send-email-imre.deak@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, lm-sensors@lm-sensors.org

Use msecs_to_jiffies_min instead of open-coding the same.

Signed-off-by: Imre Deak <imre.deak@intel.com>
---
 drivers/hwmon/lm63.c |    2 +-
 drivers/hwmon/lm90.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/lm63.c b/drivers/hwmon/lm63.c
index f644a2e..db44bcb 100644
--- a/drivers/hwmon/lm63.c
+++ b/drivers/hwmon/lm63.c
@@ -248,7 +248,7 @@ static struct lm63_data *lm63_update_device(struct device *dev)
 	mutex_lock(&data->update_lock);
 
 	next_update = data->last_updated
-	  + msecs_to_jiffies(data->update_interval) + 1;
+	  + msecs_to_jiffies_min(data->update_interval);
 
 	if (time_after(jiffies, next_update) || !data->valid) {
 		if (data->config & 0x04) { /* tachometer enabled  */
diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 8eeb141..314f9d3 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -471,7 +471,7 @@ static struct lm90_data *lm90_update_device(struct device *dev)
 	mutex_lock(&data->update_lock);
 
 	next_update = data->last_updated
-	  + msecs_to_jiffies(data->update_interval) + 1;
+	  + msecs_to_jiffies_min(data->update_interval);
 	if (time_after(jiffies, next_update) || !data->valid) {
 		u8 h, l;
 		u8 alarms;
-- 
1.7.10.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
