From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 07 Jul 2011 20:42:43 +0000
Subject: [lm-sensors] [PATCH v3 1/3] hwmon: (lm95241) Fix chip detection code
Message-Id: <1310071365-2475-2-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The LM95241 driver accepts every chip ID equal to or larger than 0xA4 as its
own, and other chips such as LM95245 use chip IDs in the accepted ID range.
This results in false chip detection.

Fix problem by accepting only the known LM95241 chip ID.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
Acked-by: Jean Delvare <khali@linux-fr.org>
---
Candidate for -stable.

 drivers/hwmon/lm95241.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm95241.c b/drivers/hwmon/lm95241.c
index 1a6dfb6..01c638e 100644
--- a/drivers/hwmon/lm95241.c
+++ b/drivers/hwmon/lm95241.c
@@ -339,7 +339,7 @@ static int lm95241_detect(struct i2c_client *new_client,
 	if ((i2c_smbus_read_byte_data(new_client, LM95241_REG_R_MAN_ID)
 	     = MANUFACTURER_ID)
 	    && (i2c_smbus_read_byte_data(new_client, LM95241_REG_R_CHIP_ID)
-		>= DEFAULT_REVISION)) {
+		= DEFAULT_REVISION)) {
 		name = DEVNAME;
 	} else {
 		dev_dbg(&adapter->dev, "LM95241 detection failed at 0x%02x\n",
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
