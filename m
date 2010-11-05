From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 05 Nov 2010 14:59:29 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ltc4261) Fix error message format
Message-Id: <20101105155929.39a5412f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

adapter->id is deprecated and not set by any adapter driver, so this
was certainly not what the author wanted to use. adapter->nr maybe,
but as dev_err() already includes this value, as well as the client's
address, there's no point repeating them. Better print a simple error
message in plain English words.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <guenter.roeck@ericsson.com>
---
 drivers/hwmon/ltc4261.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- linux-2.6.37-rc1.orig/drivers/hwmon/ltc4261.c	2010-11-02 09:19:35.000000000 +0100
+++ linux-2.6.37-rc1/drivers/hwmon/ltc4261.c	2010-11-05 15:56:49.000000000 +0100
@@ -230,8 +230,7 @@ static int ltc4261_probe(struct i2c_clie
 		return -ENODEV;
 
 	if (i2c_smbus_read_byte_data(client, LTC4261_STATUS) < 0) {
-		dev_err(&client->dev, "Failed to read register %d:%02x:%02x\n",
-			adapter->id, client->addr, LTC4261_STATUS);
+		dev_err(&client->dev, "Failed to read status register\n");
 		return -ENODEV;
 	}
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
