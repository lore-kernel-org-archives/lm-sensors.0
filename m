From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 09 Feb 2011 20:16:59 +0000
Subject: [lm-sensors] [PATCH] hwmon: (emc1403) Fix I2C address range
Message-Id: <1297284858-27842-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I2C address range included 0x2a, which the chips do not support.
Replace with 0x29 which is supported but was missing.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/emc1403.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 5dea9fa..cd2a6e4 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -344,7 +344,7 @@ static int emc1403_remove(struct i2c_client *client)
 }
 
 static const unsigned short emc1403_address_list[] = {
-	0x18, 0x2a, 0x4c, 0x4d, I2C_CLIENT_END
+	0x18, 0x29, 0x4c, 0x4d, I2C_CLIENT_END
 };
 
 static const struct i2c_device_id emc1403_idtable[] = {
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
