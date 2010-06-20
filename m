From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 20 Jun 2010 07:09:55 +0000
Subject: [lm-sensors] [PATCH] hwmon: (asc7621) Clean up and improve detect
Message-Id: <20100620090955.1a8fe6d9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* The dev variable is never used.
* Detect functions only need to set info->type, not client->name.
* Include the device address in the log message.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: George Joseph <george.joseph@fairview5.com>
Cc: Ken Milmore <ken.milmore@googlemail.com>
---
 drivers/hwmon/asc7621.c |    9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

--- linux-2.6.35-rc3.orig/drivers/hwmon/asc7621.c	2010-06-06 15:20:27.000000000 +0200
+++ linux-2.6.35-rc3/drivers/hwmon/asc7621.c	2010-06-20 08:59:57.000000000 +0200
@@ -1150,9 +1150,6 @@ static int asc7621_detect(struct i2c_cli
 {
 	struct i2c_adapter *adapter = client->adapter;
 	int company, verstep, chip_index;
-	struct device *dev;
-
-	dev = &client->dev;
 
 	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
 		return -ENODEV;
@@ -1169,13 +1166,11 @@ static int asc7621_detect(struct i2c_cli
 
 		if (company = asc7621_chips[chip_index].company_id &&
 		    verstep = asc7621_chips[chip_index].verstep_id) {
-			strlcpy(client->name, asc7621_chips[chip_index].name,
-				I2C_NAME_SIZE);
 			strlcpy(info->type, asc7621_chips[chip_index].name,
 				I2C_NAME_SIZE);
 
-			dev_info(&adapter->dev, "Matched %s\n",
-				 asc7621_chips[chip_index].name);
+			dev_info(&adapter->dev, "Matched %s at 0x%02x\n",
+				 asc7621_chips[chip_index].name, client->addr);
 			return 0;
 		}
 	}


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
