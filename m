From: Josef Gajdusek <atx@atx.name>
Date: Mon, 12 May 2014 11:48:26 +0000
Subject: [lm-sensors] [PATCH] drivers/hwmon/emc1403.c: add new revision numbers to emc1403_detect()
Message-Id: <20140512114826.GA16252@dashie>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.de
Cc: linux@roeck-us.net, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Adds new chip revision numbers to emc1403.c. Altough the datasheet (for emc1412) does not say so directly, it seems to suggest, that chips with revision ID 0x03 exist.

Signed-off-by: Josef Gajdusek <atx@atx.name>
---
diff --git a/drivers/hwmon/emc1403.c b/drivers/hwmon/emc1403.c
index 61d89d6..b2b6a52 100644
--- a/drivers/hwmon/emc1403.c
+++ b/drivers/hwmon/emc1403.c
@@ -330,7 +330,7 @@ static int emc1403_detect(struct i2c_client *client,
 	}
 
 	id = i2c_smbus_read_byte_data(client, THERMAL_REVISION_REG);
-	if (id != 0x01)
+	if (id < 0x01 || id > 0x04)
 		return -ENODEV;
 
 	return 0;


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
