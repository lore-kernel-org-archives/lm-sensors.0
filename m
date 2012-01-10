From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Tue, 10 Jan 2012 14:49:36 +0000
Subject: [lm-sensors] [PATCH 2/2] lm80.c: reset device if error occurred
Message-Id: <1326206976-7846-2-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

if an error occurs while updating (e.g. because the chip was
disconnected) the device needs to be reinitialized in order
to get back to 11 bit temperature and set the fan divider

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/lm80.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/lm80.c b/drivers/hwmon/lm80.c
index 18e5ea4..f568df6 100644
--- a/drivers/hwmon/lm80.c
+++ b/drivers/hwmon/lm80.c
@@ -108,6 +108,7 @@ static inline long TEMP_FROM_REG(u16 temp)
 struct lm80_data {
 	struct device *hwmon_dev;
 	struct mutex update_lock;
+	char error;		/* !=0 if an error occurred during the last update */
 	char valid;		/* !=0 if following fields are valid */
 	unsigned long last_updated;	/* In jiffies */
 
@@ -595,6 +596,9 @@ static struct lm80_data *lm80_update_device(struct device *dev)
 
 	mutex_lock(&data->update_lock);
 
+	if (data->error)
+		lm80_init_client(client);
+
 	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 		dev_dbg(&client->dev, "Starting lm80 update\n");
 		for (i = 0; i <= 6; i++) {
@@ -678,12 +682,14 @@ static struct lm80_data *lm80_update_device(struct device *dev)
 
 		data->last_updated = jiffies;
 		data->valid = 1;
+		data->error = 0;
 	}
 	goto done;
 
 abort:
 	ret = ERR_PTR(rv);
 	data->valid = 0;
+	data->error = 1;
 
 done:
 	mutex_unlock(&data->update_lock);
-- 
1.7.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
