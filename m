From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH] I2C: fix for fscpos voltage values
Message-Id: <11099685943850@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <11099685944086@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com
Cc: stefan@desire.ch

ChangeSet 1.2089, 2005/03/02 11:59:41-08:00, stefan@desire.ch

[PATCH] I2C: fix for fscpos voltage values

Multiplied the voltage multipliers by 10 in order to comply with the sysfs
guidelines.

Signed-off-by: Stefan Ott <stefan@desire.ch>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/chips/fscpos.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/i2c/chips/fscpos.c b/drivers/i2c/chips/fscpos.c
--- a/drivers/i2c/chips/fscpos.c	2005-03-04 12:25:44 -08:00
+++ b/drivers/i2c/chips/fscpos.c	2005-03-04 12:25:44 -08:00
@@ -244,19 +244,19 @@
 static ssize_t show_volt_12(struct device *dev, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
-	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[0], 1420));
+	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[0], 14200));
 }
 
 static ssize_t show_volt_5(struct device *dev, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
-	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[1], 660));
+	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[1], 6600));
 }
 
 static ssize_t show_volt_batt(struct device *dev, char *buf)
 {
 	struct fscpos_data *data = fscpos_update_device(dev);
-	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[2], 330));
+	return sprintf(buf, "%u\n", VOLT_FROM_REG(data->volt[2], 3300));
 }
 
 /* Watchdog */

