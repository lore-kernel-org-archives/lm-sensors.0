From: greg@kroah.com (Greg KH)
Date: Thu, 28 Sep 2006 22:48:25 +0000
Subject: [lm-sensors] [PATCH 5/39] smsc47m1: dev_warn fix
Message-Id: <11594837531839-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

smsc47m1: dev_warn fix

We can't use dev_warn on an i2c client before it is attached.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 drivers/hwmon/smsc47m1.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index 6c81b84..9cd28f2 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -429,7 +429,8 @@ static int smsc47m1_detect(struct i2c_ad
 	pwm2 = (smsc47m1_read_value(new_client, SMSC47M1_REG_PPIN(1)) & 0x05)
 	       = 0x04;
 	if (!(fan1 || fan2 || pwm1 || pwm2)) {
-		dev_warn(&new_client->dev, "Device is not configured, will not use\n");
+		dev_warn(&adapter->dev, "Device at 0x%x is not configured, "
+			 "will not use\n", new_client->addr);
 		err = -ENODEV;
 		goto error_free;
 	}
-- 
1.4.2.1


