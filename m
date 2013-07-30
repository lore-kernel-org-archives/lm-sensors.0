From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Tue, 30 Jul 2013 21:14:34 +0000
Subject: [lm-sensors] [PATCH] hwmon: (max6697) fix MAX6581 ideality
Message-Id: <1375218874-10882-1-git-send-email-vivien.didelot@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com

Without this patch, the values for ideality (register 0x4b) and ideality
selection mask (register 0x4c) are inverted.

Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
---
 drivers/hwmon/max6697.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/max6697.c b/drivers/hwmon/max6697.c
index 328fb03..a41b5f3 100644
--- a/drivers/hwmon/max6697.c
+++ b/drivers/hwmon/max6697.c
@@ -605,12 +605,12 @@ static int max6697_init_chip(struct i2c_client *client)
 		if (ret < 0)
 			return ret;
 		ret = i2c_smbus_write_byte_data(client, MAX6581_REG_IDEALITY,
-						pdata->ideality_mask >> 1);
+						pdata->ideality_value);
 		if (ret < 0)
 			return ret;
 		ret = i2c_smbus_write_byte_data(client,
 						MAX6581_REG_IDEALITY_SELECT,
-						pdata->ideality_value);
+						pdata->ideality_mask >> 1);
 		if (ret < 0)
 			return ret;
 	}
-- 
1.8.3.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
