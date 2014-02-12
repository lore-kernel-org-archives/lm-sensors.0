From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Feb 2014 05:46:49 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (smm665): Return error from i2c_smbus_read_word_swapped
Message-Id: <1392184009-5683-2-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

There is no reason to replace one error code with another,
and returning -1 as error code is wrong anyway.

Smatch log:
drivers/hwmon/smm665.c:225 smm665_read_adc() info: why not propagate 'rv'
from i2c_smbus_read_word_swapped() instead of (-1)?

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smm665.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/smm665.c b/drivers/hwmon/smm665.c
index d9e1b7d..4ef5802 100644
--- a/drivers/hwmon/smm665.c
+++ b/drivers/hwmon/smm665.c
@@ -222,7 +222,7 @@ static int smm665_read_adc(struct smm665_data *data, int adc)
 	rv = i2c_smbus_read_word_swapped(client, 0);
 	if (rv < 0) {
 		dev_dbg(&client->dev, "Failed to read ADC value: error %d", rv);
-		return -1;
+		return rv;
 	}
 	/*
 	 * Validate/verify readback adc channel (in bit 11..14).
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
