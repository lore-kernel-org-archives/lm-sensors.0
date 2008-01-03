From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Jan 2008 21:54:13 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (w83627hf) Enable VBAT monitoring
Message-Id: <20080103225413.4e9d0729@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If VBAT monitoring is disabled, enable it. Bug reported on the
lm-sensors trac system:
http://lm-sensors.org/ticket/2282
This is the exact same patch that was applied to the w83627ehf driver
6 months ago.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Carlos, could you please test and/or review this patch?

 drivers/hwmon/w83627hf.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.24-rc6.orig/drivers/hwmon/w83627hf.c	2007-12-26 14:39:06.000000000 +0100
+++ linux-2.6.24-rc6/drivers/hwmon/w83627hf.c	2007-12-26 18:53:51.000000000 +0100
@@ -1515,6 +1515,11 @@ static void __devinit w83627hf_init_devi
 			    (w83627hf_read_value(data,
 						W83781D_REG_CONFIG) & 0xf7)
 			    | 0x01);
+
+	/* Enable VBAT monitoring if needed */
+	tmp = w83627hf_read_value(data, W83781D_REG_VBAT);
+	if (!(tmp & 0x01))
+		w83627hf_write_value(data, W83781D_REG_VBAT, tmp | 0x01);
 }
 
 static void w83627hf_update_fan_div(struct w83627hf_data *data)


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
