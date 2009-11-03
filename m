From: Ben Dooks <ben@simtec.co.uk>
Date: Tue, 03 Nov 2009 11:11:16 +0000
Subject: [lm-sensors] s3c-hwmon: Ignore invalid divider settings
Message-Id: <20091103111116.391080041@fluff.org.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Avoid registering channels that have zero divider settings in them, as this
will only lead to kernel OOPS from divide-by-zero when the sysfs entry is
read.

Signed-off-by: Ben Dooks <ben@simtec.co.uk>
Signed-off-by: Simtec Linux Kernel Team <linux@simtec.co.uk>

---
 drivers/hwmon/s3c-hwmon.c |   13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)


 
Index: b/drivers/hwmon/s3c-hwmon.c
=================================--- a/drivers/hwmon/s3c-hwmon.c	2009-10-07 15:22:03.000000000 +0100
+++ b/drivers/hwmon/s3c-hwmon.c	2009-10-07 15:42:03.000000000 +0100
@@ -323,14 +323,21 @@ static int __devinit s3c_hwmon_probe(str
 	}
 
 	for (i = 0; i < ARRAY_SIZE(pdata->in); i++) {
-		if (!pdata->in[i])
-			continue;
+		struct s3c24xx_adc_hwmon_incfg *cfg = pdata->in[i];
 
-		if (pdata->in[i]->mult >= 0x10000)
+		if (!cfg)
+			continue;
+		
+		if (cfg->mult >= 0x10000)
 			dev_warn(&dev->dev,
 				 "channel %d multiplier too large\n",
 				 i);
 
+		if (cfg->divider = 0) {
+			dev_err(&dev->dev, "channel %d divider zero\n", i);
+			continue;
+		}
+
 		ret = s3c_hwmon_create_attr(&dev->dev, pdata->in[i],
 					    &hwmon->attrs[i], i);
 		if (ret) {

-- 
Ben (ben@fluff.org, http://www.fluff.org/)

  'a smiley only costs 4 bytes'

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
