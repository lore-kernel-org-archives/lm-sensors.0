From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jun 2007 09:21:43 +0000
Subject: [lm-sensors] [PATCH 09/10] hwmon/w83627ehf: No need to initialize
Message-Id: <20070624112143.4e3aef58@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

We don't need to initialize fan_min in this driver, as the fan_div
attributes are read-only.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627ehf.c |    5 -----
 1 file changed, 5 deletions(-)

--- linux-2.6.22-rc5.orig/drivers/hwmon/w83627ehf.c	2007-06-24 10:42:39.000000000 +0200
+++ linux-2.6.22-rc5/drivers/hwmon/w83627ehf.c	2007-06-24 10:46:24.000000000 +0200
@@ -1269,11 +1269,6 @@ static int __devinit w83627ehf_probe(str
 	/* Initialize the chip */
 	w83627ehf_init_device(data);
 
-	/* A few vars need to be filled upon startup */
-	for (i = 0; i < 5; i++)
-		data->fan_min[i] = w83627ehf_read_value(data,
-				   W83627EHF_REG_FAN_MIN[i]);
-
 	data->vrm = vid_which_vrm();
 	superio_enter(sio_data->sioreg);
 	/* Set VID input sensibility if needed. In theory the BIOS should

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
