From: Jean Delvare <jdelvare@suse.de>
Date: Wed, 12 Feb 2014 09:04:46 +0000
Subject: [lm-sensors] (PATCH] hwmon: (lm95241) Avoid initializing the same field twice
Message-Id: <20140212100446.2cac0b90@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

data is kzalloc'd, so data->valid and data->model are already 0.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
---
 drivers/hwmon/lm95241.c |    2 --
 1 file changed, 2 deletions(-)

--- linux-3.14-rc1.orig/drivers/hwmon/lm95241.c	2014-02-12 08:54:28.449216964 +0100
+++ linux-3.14-rc1/drivers/hwmon/lm95241.c	2014-02-12 09:28:06.361822779 +0100
@@ -363,9 +363,7 @@ static void lm95241_init_client(struct i
 				struct lm95241_data *data)
 {
 	data->interval = HZ;	/* 1 sec default */
-	data->valid = 0;
 	data->config = CFG_CR0076;
-	data->model = 0;
 	data->trutherm = (TT_OFF << TT1_SHIFT) | (TT_OFF << TT2_SHIFT);
 
 	i2c_smbus_write_byte_data(client, LM95241_REG_RW_CONFIG, data->config);


-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
