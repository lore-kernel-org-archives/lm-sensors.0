From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 28 Aug 2006 12:22:34 +0000
Subject: [lm-sensors] [PATCH 03/14] smsc47m1: dev_warn fix
Message-Id: <20060828142234.3acd8103.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-smsc47m1-fix-dev-message.patch

smsc47m1: dev_warn fix

We can't use dev_warn on an i2c client before it is attached.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/smsc47m1.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.18-rc4.orig/drivers/hwmon/smsc47m1.c	2006-08-27 22:32:01.000000000 +0200
+++ linux-2.6.18-rc4/drivers/hwmon/smsc47m1.c	2006-08-27 22:40:51.000000000 +0200
@@ -428,7 +428,8 @@
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
Jean Delvare

