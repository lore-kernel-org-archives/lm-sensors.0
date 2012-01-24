From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 24 Jan 2012 02:49:56 +0000
Subject: [lm-sensors] [PATCH 77/79] hwmon: (lm70) Fix: do not use assignment in if condition
Message-Id: <1327373398-997-78-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Fix checkpatch issue:
ERROR: do not use assignment in if condition

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/lm70.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 61c2ffb..472f795 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -158,11 +158,12 @@ static int __devinit lm70_probe(struct spi_device *spi)
 
 	spi_set_drvdata(spi, p_lm70);
 
-	if ((status = device_create_file(&spi->dev, &dev_attr_temp1_input))
-	 || (status = device_create_file(&spi->dev, &dev_attr_name))) {
-		dev_dbg(&spi->dev, "device_create_file failure.\n");
+	status = device_create_file(&spi->dev, &dev_attr_temp1_input);
+	if (status)
+		goto out_dev_create_temp_file_failed;
+	status = device_create_file(&spi->dev, &dev_attr_name);
+	if (status)
 		goto out_dev_create_file_failed;
-	}
 
 	/* sysfs hook */
 	p_lm70->hwmon_dev = hwmon_device_register(&spi->dev);
@@ -178,6 +179,7 @@ out_dev_reg_failed:
 	device_remove_file(&spi->dev, &dev_attr_name);
 out_dev_create_file_failed:
 	device_remove_file(&spi->dev, &dev_attr_temp1_input);
+out_dev_create_temp_file_failed:
 	spi_set_drvdata(spi, NULL);
 	kfree(p_lm70);
 	return status;
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
