From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Thu, 24 May 2012 15:58:02 +0000
Subject: [lm-sensors] [patch] watchdog: sch56xx-common: set correct bits in register()
Message-Id: <20120524155802.GB11037@elgon.mountain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: kernel-janitors@vger.kernel.org

WDOG_NO_WAY_OUT (3) and WDOG_ACTIVE (0) are the bit numbers, not a mask.
So "data->wddev.status |= WDOG_ACTIVE;" was intended to set bit zero but
it is a no-op.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/hwmon/sch56xx-common.c b/drivers/hwmon/sch56xx-common.c
index 839087c..4380f5d 100644
--- a/drivers/hwmon/sch56xx-common.c
+++ b/drivers/hwmon/sch56xx-common.c
@@ -464,9 +464,9 @@ struct sch56xx_watchdog_data *sch56xx_watchdog_register(struct device *parent,
 	data->wddev.min_timeout = 1;
 	data->wddev.max_timeout = 255 * 60;
 	if (nowayout)
-		data->wddev.status |= WDOG_NO_WAY_OUT;
+		set_bit(WDOG_NO_WAY_OUT, &data->wddev.status);
 	if (output_enable & SCH56XX_WDOG_OUTPUT_ENABLE)
-		data->wddev.status |= WDOG_ACTIVE;
+		set_bit(WDOG_ACTIVE, &data->wddev.status);
 
 	/* Since the watchdog uses a downcounter there is no register to read
 	   the BIOS set timeout from (if any was set at all) ->

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
