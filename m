From: Zac Storer <zac.3.14159@gmail.com>
Date: Fri, 18 Nov 2011 06:11:09 +0000
Subject: [lm-sensors] [PATCH 32/32] Drivers: hwmon: adm1031: fixed a brace
Message-Id: <1321596670-11365-1-git-send-email-zac.3.14159@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali@linux-fr.org
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Zac Storer <zac.3.14159@gmail.com>

Fixed a brace coding style issue.

Signed-off-by: Zac Storer <zac.3.14159@gmail.com>
---
 drivers/hwmon/adm1031.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/adm1031.c b/drivers/hwmon/adm1031.c
index 0683e6b..04e2adc 100644
--- a/drivers/hwmon/adm1031.c
+++ b/drivers/hwmon/adm1031.c
@@ -299,7 +299,7 @@ set_fan_auto_channel(struct device *dev, struct device_attribute *attr,
 	data->conf1 = FAN_CHAN_TO_REG(reg, data->conf1);
 	if ((data->conf1 & ADM1031_CONF1_AUTO_MODE) ^
 	    (old_fan_mode & ADM1031_CONF1_AUTO_MODE)) {
-		if (data->conf1 & ADM1031_CONF1_AUTO_MODE){
+		if (data->conf1 & ADM1031_CONF1_AUTO_MODE) {
 			/* Switch to Auto Fan Mode
 			 * Save PWM registers
 			 * Set PWM registers to 33% Both */
-- 
1.7.7.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
