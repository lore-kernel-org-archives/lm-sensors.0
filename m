From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 27 Feb 2015 16:36:19 +0000
Subject: [lm-sensors] [PATCH] hwmon: (nct7904) Strenghten detect function
Message-Id: <1425054979-27598-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The bank register has five unused bits. Verify that those bits are zero
to strenghten the detect function.

Cc: Vadim V. Vlasov <vvlasov@dev.rtsoft.ru>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Vadim, it would be great if you can confirm that/if this works.
If yes, I'll use the same code in sensors-detect.

Thanks,
Guenter

 drivers/hwmon/nct7904.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/nct7904.c b/drivers/hwmon/nct7904.c
index eaa8234..b77b82f 100644
--- a/drivers/hwmon/nct7904.c
+++ b/drivers/hwmon/nct7904.c
@@ -502,7 +502,8 @@ static int nct7904_detect(struct i2c_client *client,
 	/* Determine the chip type. */
 	if (i2c_smbus_read_byte_data(client, VENDOR_ID_REG) != NUVOTON_ID ||
 	    i2c_smbus_read_byte_data(client, CHIP_ID_REG) != NCT7904_ID ||
-	    (i2c_smbus_read_byte_data(client, DEVICE_ID_REG) & 0xf0) != 0x50)
+	    (i2c_smbus_read_byte_data(client, DEVICE_ID_REG) & 0xf0) != 0x50 ||
+	    (i2c_smbus_read_byte_data(client, BANK_SEL_REG) & 0xf8) != 0x00)
 		return -ENODEV;
 
 	strlcpy(info->type, "nct7904", I2C_NAME_SIZE);
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
