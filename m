From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jun 2007 09:20:13 +0000
Subject: [lm-sensors] [PATCH 07/10] hwmon/w83627ehf: Enable VBAT monitoring
Message-Id: <20070624112013.6fb1622e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If VBAT monitoring is disabled, enable it. Original patch from
an anonymous contributor on the lm-sensors trac system:
http://lm-sensors.org/ticket/2218

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83627ehf.c |    5 +++++
 1 file changed, 5 insertions(+)

--- linux-2.6.22-rc5.orig/drivers/hwmon/w83627ehf.c	2007-06-23 21:47:54.000000000 +0200
+++ linux-2.6.22-rc5/drivers/hwmon/w83627ehf.c	2007-06-23 22:02:04.000000000 +0200
@@ -1205,6 +1205,11 @@ static inline void __devinit w83627ehf_i
 					      W83627EHF_REG_TEMP_CONFIG[i],
 					      tmp & 0xfe);
 	}
+
+	/* Enable VBAT monitoring if needed */
+	tmp = w83627ehf_read_value(data, W83627EHF_REG_VBAT);
+	if (!(tmp & 0x01))
+		w83627ehf_write_value(data, W83627EHF_REG_VBAT, tmp | 0x01);
 }
 
 static int __devinit w83627ehf_probe(struct platform_device *pdev)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
