From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:48:51 +0000
Subject: [lm-sensors] [PATCH 12/79] hwmon: (smsc47m192) Fix vrm value range
Message-Id: <1327373398-997-13-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When updating vrm, the value range was not limited. This could result in more or
less random vrm values if the value provided by the user was larger than 255.
Fix by limiting the range to 0..255 using the SENSORS_LIMIT macro.

Cc: Hartmut Rick <linux@rick.claranet.de>
Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/smsc47m192.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/smsc47m192.c b/drivers/hwmon/smsc47m192.c
index 4705a8b..1e53028 100644
--- a/drivers/hwmon/smsc47m192.c
+++ b/drivers/hwmon/smsc47m192.c
@@ -385,7 +385,7 @@ static ssize_t set_vrm(struct device *dev, struct device_attribute *attr,
 	if (err)
 		return err;
 
-	data->vrm = val;
+	data->vrm = SENSORS_LIMIT(val, 0, 255);
 	return count;
 }
 static DEVICE_ATTR(vrm, S_IRUGO | S_IWUSR, show_vrm, set_vrm);
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
