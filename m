From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:53 +0000
Subject: [lm-sensors] [PATCH 74/79] hwmon: (w83l785ts) Fix multi-line comments
Message-Id: <1327373398-997-75-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/w83l785ts.c |   15 +++++++++------
 1 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/w83l785ts.c b/drivers/hwmon/w83l785ts.c
index bc07144..5f14e38 100644
--- a/drivers/hwmon/w83l785ts.c
+++ b/drivers/hwmon/w83l785ts.c
@@ -116,8 +116,7 @@ struct w83l785ts_data {
 	unsigned long last_updated; /* in jiffies */
 
 	/* registers values */
-	s8 temp[2]; /* 0: input
-		       1: critical limit */
+	s8 temp[2]; /* 0: input, 1: critical limit */
 };
 
 /*
@@ -250,8 +249,10 @@ static u8 w83l785ts_read_value(struct i2c_client *client, u8 reg, u8 defval)
 	struct device *dev;
 	const char *prefix;
 
-	/* We might be called during detection, at which point the client
-	   isn't yet fully initialized, so we can't use dev_dbg on it */
+	/*
+	 * We might be called during detection, at which point the client
+	 * isn't yet fully initialized, so we can't use dev_dbg on it
+	 */
 	if (i2c_get_clientdata(client)) {
 		dev = &client->dev;
 		prefix = "";
@@ -260,9 +261,11 @@ static u8 w83l785ts_read_value(struct i2c_client *client, u8 reg, u8 defval)
 		prefix = "w83l785ts: ";
 	}
 
-	/* Frequent read errors have been reported on Asus boards, so we
+	/*
+	 * Frequent read errors have been reported on Asus boards, so we
 	 * retry on read errors. If it still fails (unlikely), return the
-	 * default value requested by the caller. */
+	 * default value requested by the caller.
+	 */
 	for (i = 1; i <= MAX_RETRIES; i++) {
 		value = i2c_smbus_read_byte_data(client, reg);
 		if (value >= 0) {
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
