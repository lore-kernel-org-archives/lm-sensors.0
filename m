From: Axel Lin <axel.lin@gmail.com>
Date: Sun, 22 Aug 2010 14:25:26 +0000
Subject: [lm-sensors] [PATCH] hwmon: (ads7871) Fix ads7871_probe init path
Message-Id: <1282487126.23014.11.camel@phoenix>
List-Id: <lm-sensors.vger.kernel.org>
References: <1281922277.26991.3.camel@mola>
In-Reply-To: <1281922277.26991.3.camel@mola>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Paul Thomas <pthomas8589@gmail.com>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

From 81e895683eaecb9e196c57c36b774c0908069d83 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@gmail.com>
Date: Sun, 22 Aug 2010 22:10:01 +0800
Subject: [PATCH] hwmon: (ads7871) Fix ads7871_probe init path

This patch includes below fixes:

1. remove 'status' variable
2. remove unneeded initialization of 'err' variable
3. return missing error code if sysfs_create_group fail.
4. fix the init sequence as:
   - check hardware existence
   - kzalloc for ads7871_data
   - sysfs_create_group
   - hwmon_device_register

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---

hi Jean,
This patch is against linux-next ( on top of previous patch ).
Reviews are welcome.

I think it's ok to call sysfs_create_group() before hwmon_device_register().
If hwmon_device_register failed, the device is not working anyway.
We just need to make sure all the allocated resources are reclaimed in error path before return error.

Regards,
Axel

 drivers/hwmon/ads7871.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/hwmon/ads7871.c b/drivers/hwmon/ads7871.c
index 45f5829..5231934 100644
--- a/drivers/hwmon/ads7871.c
+++ b/drivers/hwmon/ads7871.c
@@ -160,24 +160,12 @@ static const struct attribute_group ads7871_group = {
 
 static int __devinit ads7871_probe(struct spi_device *spi)
 {
-	int status, ret, err = 0;
+	int ret, err;
 	uint8_t val;
 	struct ads7871_data *pdata;
 
 	dev_dbg(&spi->dev, "probe\n");
 
-	pdata = kzalloc(sizeof(struct ads7871_data), GFP_KERNEL);
-	if (!pdata) {
-		err = -ENOMEM;
-		goto exit;
-	}
-
-	status = sysfs_create_group(&spi->dev.kobj, &ads7871_group);
-	if (status < 0)
-		goto error_free;
-
-	spi_set_drvdata(spi, pdata);
-
 	/* Configure the SPI bus */
 	spi->mode = (SPI_MODE_0);
 	spi->bits_per_word = 8;
@@ -195,9 +183,21 @@ static int __devinit ads7871_probe(struct spi_device *spi)
 	we need to make sure we really have a chip*/
 	if (val != ret) {
 		err = -ENODEV;
-		goto error_remove;
+		goto exit;
 	}
 
+	pdata = kzalloc(sizeof(struct ads7871_data), GFP_KERNEL);
+	if (!pdata) {
+		err = -ENOMEM;
+		goto exit;
+	}
+
+	err = sysfs_create_group(&spi->dev.kobj, &ads7871_group);
+	if (err < 0)
+		goto error_free;
+
+	spi_set_drvdata(spi, pdata);
+
 	pdata->hwmon_dev = hwmon_device_register(&spi->dev);
 	if (IS_ERR(pdata->hwmon_dev)) {
 		err = PTR_ERR(pdata->hwmon_dev);
-- 
1.7.0.4




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
