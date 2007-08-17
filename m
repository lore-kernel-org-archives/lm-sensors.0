From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Aug 2007 15:31:35 +0000
Subject: [lm-sensors] [PATCH] hwmon/lm70: Add a name attribute
Message-Id: <20070817173135.5eaffc0e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add a name attribute to the lm70 devices. This is required for
libsensors to recognize them.

Also drop the "+" before the temperature value, even though it did
not cause problems to libsensors, other hardware monitoring drivers
don't print it, so it's more consistent that way.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/lm70.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

--- linux-2.6.23-rc3.orig/drivers/hwmon/lm70.c	2007-07-23 16:44:35.000000000 +0200
+++ linux-2.6.23-rc3/drivers/hwmon/lm70.c	2007-08-17 16:16:40.000000000 +0200
@@ -81,7 +81,7 @@ static ssize_t lm70_sense_temp(struct de
 	 * So it's equivalent to multiplying by 0.25 * 1000 = 250.
 	 */
 	val = ((int)raw/32) * 250;
-	status = sprintf(buf, "%+d\n", val); /* millidegrees Celsius */
+	status = sprintf(buf, "%d\n", val); /* millidegrees Celsius */
 out:
 	up(&p_lm70->sem);
 	return status;
@@ -89,6 +89,14 @@ out:
 
 static DEVICE_ATTR(temp1_input, S_IRUGO, lm70_sense_temp, NULL);
 
+static ssize_t lm70_show_name(struct device *dev, struct device_attribute
+			      *devattr, char *buf)
+{
+	return sprintf(buf, "lm70\n");
+}
+
+static DEVICE_ATTR(name, S_IRUGO, lm70_show_name, NULL);
+
 /*----------------------------------------------------------------------*/
 
 static int __devinit lm70_probe(struct spi_device *spi)
@@ -115,7 +123,8 @@ static int __devinit lm70_probe(struct s
 	}
 	dev_set_drvdata(&spi->dev, p_lm70);
 
-	if ((status = device_create_file(&spi->dev, &dev_attr_temp1_input))) {
+	if ((status = device_create_file(&spi->dev, &dev_attr_temp1_input))
+	 || (status = device_create_file(&spi->dev, &dev_attr_name))) {
 		dev_dbg(&spi->dev, "device_create_file failure.\n");
 		goto out_dev_create_file_failed;
 	}
@@ -123,6 +132,7 @@ static int __devinit lm70_probe(struct s
 	return 0;
 
 out_dev_create_file_failed:
+	device_remove_file(&spi->dev, &dev_attr_temp1_input);
 	hwmon_device_unregister(p_lm70->cdev);
 out_dev_reg_failed:
 	dev_set_drvdata(&spi->dev, NULL);
@@ -135,6 +145,7 @@ static int __devexit lm70_remove(struct 
 	struct lm70 *p_lm70 = dev_get_drvdata(&spi->dev);
 
 	device_remove_file(&spi->dev, &dev_attr_temp1_input);
+	device_remove_file(&spi->dev, &dev_attr_name);
 	hwmon_device_unregister(p_lm70->cdev);
 	dev_set_drvdata(&spi->dev, NULL);
 	kfree(p_lm70);


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
