From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 08 Dec 2011 19:02:37 +0000
Subject: [lm-sensors] [PATCH] hwmon: (f75375s) Disable setting DC fan
Message-Id: <1323370957-27317-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

F75373 does not support DC (linear voltage) fan control mode, so don't let
the user set it.

Cc: Riku Voipio <riku.voipio@iki.fi>
Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/f75375s.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/hwmon/f75375s.c b/drivers/hwmon/f75375s.c
index 9c3f078..35b570e 100644
--- a/drivers/hwmon/f75375s.c
+++ b/drivers/hwmon/f75375s.c
@@ -372,6 +372,10 @@ static ssize_t set_pwm_mode(struct device *dev, struct device_attribute *attr,
 	if (!(val = 0 || val = 1))
 		return -EINVAL;
 
+	/* F75373 does not support DC (linear voltage) fan control mode */
+	if (data->kind = f75373 && val = 0)
+		return -EINVAL;
+
 	mutex_lock(&data->update_lock);
 	conf = f75375_read8(client, F75375_REG_CONFIG1);
 	conf &= ~(1 << FAN_CTRL_LINEAR(nr));
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
