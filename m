From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 29 Jun 2008 08:18:04 +0000
Subject: [lm-sensors] [PATCH 1/2] hwmon: (asb100) Fix error message on
Message-Id: <20080629101804.0ad8bfd4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On subclient registration failure, the asb100 driver currently claims
that subclient 2 registration failed, regardless of which subclient
registration actually failed. Fix it to report the number of the
subclient those registration actually failed.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/asb100.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-2.6.26-rc8.orig/drivers/hwmon/asb100.c	2008-06-29 08:45:32.000000000 +0200
+++ linux-2.6.26-rc8/drivers/hwmon/asb100.c	2008-06-29 08:54:23.000000000 +0200
@@ -689,13 +689,13 @@ static int asb100_detect_subclients(stru
 
 	if ((err = i2c_attach_client(data->lm75[0]))) {
 		dev_err(&client->dev, "subclient %d registration "
-			"at address 0x%x failed.\n", i, data->lm75[0]->addr);
+			"at address 0x%x failed.\n", 1, data->lm75[0]->addr);
 		goto ERROR_SC_2;
 	}
 
 	if ((err = i2c_attach_client(data->lm75[1]))) {
 		dev_err(&client->dev, "subclient %d registration "
-			"at address 0x%x failed.\n", i, data->lm75[1]->addr);
+			"at address 0x%x failed.\n", 2, data->lm75[1]->addr);
 		goto ERROR_SC_3;
 	}
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
