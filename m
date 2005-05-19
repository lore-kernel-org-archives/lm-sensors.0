From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: [PATCH 2.6] Bring w83l785ts in compliance with sysfs naming
Message-Id: <20040202210315.17a290ee.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here is a patch that brings the w83l785ts driver in compliance with
sysfs naming conventions. This is pretty much the same problem and
solution that occured very recently with the lm75 and lm78 drivers.

The patch was tested to work fine by James Bolt.

If it's too late for Linux 2.6.2, this is no big deal. I'd add a
workaround in libsensors before releasing lm_sensors 2.8.4, and remove
it right after.

Thanks.

--- linux-2.6.2-rc3-k1/drivers/i2c/chips/w83l785ts.c.orig	Sat Jan 31 19:16:29 2004
+++ linux-2.6.2-rc3-k1/drivers/i2c/chips/w83l785ts.c	Sun Feb  1 21:45:40 2004
@@ -137,8 +137,8 @@
 	return sprintf(buf, "%d\n", TEMP_FROM_REG(data->temp_over));
 }
 
-static DEVICE_ATTR(temp_input, S_IRUGO, show_temp, NULL)
-static DEVICE_ATTR(temp_max, S_IRUGO, show_temp_over, NULL)
+static DEVICE_ATTR(temp_input1, S_IRUGO, show_temp, NULL)
+static DEVICE_ATTR(temp_max1, S_IRUGO, show_temp_over, NULL)
 
 /*
  * Real code
@@ -249,8 +249,8 @@
 	 */
 
 	/* Register sysfs hooks */
-	device_create_file(&new_client->dev, &dev_attr_temp_input);
-	device_create_file(&new_client->dev, &dev_attr_temp_max);
+	device_create_file(&new_client->dev, &dev_attr_temp_input1);
+	device_create_file(&new_client->dev, &dev_attr_temp_max1);
 
 	return 0;
 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
