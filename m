From: Axel Lin <axel.lin@gmail.com>
Date: Tue, 17 Aug 2010 12:41:24 +0000
Subject: [lm-sensors] [PATCH v2] hwmon: (ads7871) Fix ads7871_probe error
Message-Id: <1282048884.2626.2.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jean Delvare <khali@linux-fr.org>, Paul Thomas <pthomas8589@gmail.com>, lm-sensors@lm-sensors.org

This patch moves hwmon_device_register() to the end of ads7871_probe().
So we can make sure the device exists and is properly initialized
before the device is exposed to user-space.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 drivers/hwmon/ads7871.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
index b300a20..45f5829 100644
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -176,12 +176,6 @@ static int __devinit ads7871_probe(struct spi_device *spi)
 	if (status < 0)
 		goto error_free;
 
-	pdata->hwmon_dev = hwmon_device_register(&spi->dev);
-	if (IS_ERR(pdata->hwmon_dev)) {
-		err = PTR_ERR(pdata->hwmon_dev);
-		goto error_remove;
-	}
-
 	spi_set_drvdata(spi, pdata);
 
 	/* Configure the SPI bus */
@@ -204,6 +198,12 @@ static int __devinit ads7871_probe(struct spi_device *spi)
 		goto error_remove;
 	}
 
+	pdata->hwmon_dev = hwmon_device_register(&spi->dev);
+	if (IS_ERR(pdata->hwmon_dev)) {
+		err = PTR_ERR(pdata->hwmon_dev);
+		goto error_remove;
+	}
+
 	return 0;
 
 error_remove:
-- 
1.7.0.4




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
