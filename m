From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: [PATCH] i2c driver fixes for 2.6.3-rc1
Message-Id: <10763687754014@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10763687741075@kroah.com>
References: <10763687741938@kroah.com>
In-Reply-To: <10763687741938@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1500.11.3, 2004/02/02 14:51:45-08:00, khali@linux-fr.org

[PATCH] I2C: Bring w83l785ts in compliance with sysfs naming conventions

Here is a patch that brings the w83l785ts driver in compliance with
sysfs naming conventions. This is pretty much the same problem and
solution that occured very recently with the lm75 and lm78 drivers.

The patch was tested to work fine by James Bolt.


 drivers/i2c/chips/w83l785ts.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/i2c/chips/w83l785ts.c b/drivers/i2c/chips/w83l785ts.c
--- a/drivers/i2c/chips/w83l785ts.c	Mon Feb  9 15:05:59 2004
+++ b/drivers/i2c/chips/w83l785ts.c	Mon Feb  9 15:05:59 2004
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
 

