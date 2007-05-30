From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 30 May 2007 18:47:36 +0000
Subject: [lm-sensors] [PATCH] hwmon/via686a: Temperature interrupt
Message-Id: <20070530204736.4d6dd101@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Fix the writing of the temperature interrupt configuration.
The old code was working only by accident.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/via686a.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- linux-2.6.22-rc3.orig/drivers/hwmon/via686a.c	2007-05-30 17:28:39.000000000 +0200
+++ linux-2.6.22-rc3/drivers/hwmon/via686a.c	2007-05-30 17:30:09.000000000 +0200
@@ -740,9 +740,10 @@ static void via686a_init_client(struct i
 	via686a_write_value(client, VIA686A_REG_CONFIG, (reg|0x01)&0x7F);
 
 	/* Configure temp interrupt mode for continuous-interrupt operation */
+	reg = via686a_read_value(client, VIA686A_REG_TEMP_MODE);
 	via686a_write_value(client, VIA686A_REG_TEMP_MODE,
-			    via686a_read_value(client, VIA686A_REG_TEMP_MODE) &
-			    !(VIA686A_TEMP_MODE_MASK | VIA686A_TEMP_MODE_CONTINUOUS));
+			    (reg & ~VIA686A_TEMP_MODE_MASK)
+			    | VIA686A_TEMP_MODE_CONTINUOUS);
 }
 
 static struct via686a_data *via686a_update_device(struct device *dev)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
