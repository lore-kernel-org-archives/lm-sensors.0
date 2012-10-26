From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 26 Oct 2012 07:37:38 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83627ehf) Force initial bank selection
Message-Id: <20121026093738.2fd9131d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Don't assume bank 0 is selected at device probe time. This may not be
the case. Force bank selection at first register access to guarantee
that we read the right registers upon driver loading.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: stable@vger.kernel.org
---
 drivers/hwmon/w83627ehf.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-3.7-rc2.orig/drivers/hwmon/w83627ehf.c	2012-10-26 09:28:16.000000000 +0200
+++ linux-3.7-rc2/drivers/hwmon/w83627ehf.c	2012-10-26 09:34:04.028295469 +0200
@@ -2083,6 +2083,7 @@ static int __devinit w83627ehf_probe(str
 	mutex_init(&data->lock);
 	mutex_init(&data->update_lock);
 	data->name = w83627ehf_device_names[sio_data->kind];
+	data->bank = 0xff;		/* Force initial bank selection */
 	platform_set_drvdata(pdev, data);
 
 	/* 627EHG and 627EHF have 10 voltage inputs; 627DHG and 667HG have 9 */


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
