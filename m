From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:27 +0000
Subject: [lm-sensors] [PATCH 48/79] hwmon: (lm85) Fix vrm value range
Message-Id: <1327373398-997-49-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When updating vrm, the value range was not limited. This could result in more or
less random vrm values if the value provided by the user was larger than 255.
Fix by limiting the range to 0..255 using the SENSORS_LIMIT macro.

Cc: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/lm85.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm85.c b/drivers/hwmon/lm85.c
index 864c7d9..08cb535 100644
--- a/drivers/hwmon/lm85.c
+++ b/drivers/hwmon/lm85.c
@@ -463,7 +463,7 @@ static ssize_t store_vrm_reg(struct device *dev, struct device_attribute *attr,
 	if (err)
 		return err;
 
-	data->vrm = val;
+	data->vrm = SENSORS_LIMIT(val, 0, 255);
 	return count;
 }
 
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
