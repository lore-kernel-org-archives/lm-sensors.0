From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: [PATCH] More i2c driver changes for 2.5.70
Message-Id: <10553638061285@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <10553638061293@kroah.com>
References: <1048295086481@kroah.com>
In-Reply-To: <1048295086481@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1419.1.6, 2003/06/11 12:29:21-07:00, greg@kroah.com

[PATCH] I2C: fix some errors found by sparse in include/linux/i2c.h


 include/linux/i2c.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/include/linux/i2c.h b/include/linux/i2c.h
--- a/include/linux/i2c.h	Wed Jun 11 13:25:03 2003
+++ b/include/linux/i2c.h	Wed Jun 11 13:25:03 2003
@@ -176,7 +176,7 @@
 
 static inline void i2c_set_clientdata (struct i2c_client *dev, void *data)
 {
-	return dev_set_drvdata (&dev->dev, data);
+	dev_set_drvdata (&dev->dev, data);
 }
 
 #define I2C_DEVNAME(str)   .dev = { .name = str }
@@ -261,7 +261,7 @@
 
 static inline void i2c_set_adapdata (struct i2c_adapter *dev, void *data)
 {
-	return dev_set_drvdata (&dev->dev, data);
+	dev_set_drvdata (&dev->dev, data);
 }
 
 /*flags for the driver struct: */

