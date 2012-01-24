From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:03 +0000
Subject: [lm-sensors] [PATCH 24/79] hwmon: (emc1403) Fix multi-line comments
Message-Id: <1327373398-997-25-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Cc: Kalhan Trisal <kalhan.trisal@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/emc1403.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 99ac141..149dcb0 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -41,8 +41,10 @@
 struct thermal_data {
 	struct device *hwmon_dev;
 	struct mutex mutex;
-	/* Cache the hyst value so we don't keep re-reading it. In theory
-	   we could cache it forever as nobody else should be writing it. */
+	/*
+	 * Cache the hyst value so we don't keep re-reading it. In theory
+	 * we could cache it forever as nobody else should be writing it.
+	 */
 	u8 cached_hyst;
 	unsigned long hyst_valid;
 };
@@ -283,8 +285,10 @@ static int emc1403_detect(struct i2c_client *client,
 	case 0x23:
 		strlcpy(info->type, "emc1423", I2C_NAME_SIZE);
 		break;
-	/* Note: 0x25 is the 1404 which is very similar and this
-	   driver could be extended */
+	/*
+	 * Note: 0x25 is the 1404 which is very similar and this
+	 * driver could be extended
+	 */
 	default:
 		return -ENODEV;
 	}
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
