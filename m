From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 27 Jul 2005 21:27:41 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: use time_after in 3 chip drivers
Message-Id: <20050727212726.5d8037e2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg, all,

A few i2c drivers were not updated to use time_after() yet.

Signed-off-by: Marcelo Feitoza Parisi <marcelo@feitoza.com.br>
Signed-off-by: Jean Delvare <khali@linux-fr.org>

 drivers/hwmon/atxp1.c   |    5 ++---
 drivers/hwmon/fscpos.c  |    4 ++--
 drivers/hwmon/gl520sm.c |    4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

--- linux-2.6.13-rc3.orig/drivers/hwmon/atxp1.c	2005-07-15 20:12:01.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/atxp1.c	2005-07-15 20:16:03.000000000 +0200
@@ -21,6 +21,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/module.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -83,9 +84,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > HZ) ||
-	    (jiffies < data->last_updated) ||
-	    !data->valid) {
+	if (time_after(jiffies, data->last_updated + HZ) || !data->valid) {
 
 		/* Update local register data */
 		data->reg.vid = i2c_smbus_read_byte_data(client, ATXP1_VID);
--- linux-2.6.13-rc3.orig/drivers/hwmon/fscpos.c	2005-07-13 23:34:59.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/fscpos.c	2005-07-15 20:18:37.000000000 +0200
@@ -32,6 +32,7 @@
 
 #include <linux/module.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/init.h>
@@ -586,8 +587,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > 2 * HZ) ||
-			(jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 		int i;
 
 		dev_dbg(&client->dev, "Starting fscpos update\n");
--- linux-2.6.13-rc3.orig/drivers/hwmon/gl520sm.c	2005-07-13 23:34:59.000000000 +0200
+++ linux-2.6.13-rc3/drivers/hwmon/gl520sm.c	2005-07-15 20:18:44.000000000 +0200
@@ -24,6 +24,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
+#include <linux/jiffies.h>
 #include <linux/i2c.h>
 #include <linux/i2c-sensor.h>
 #include <linux/i2c-vid.h>
@@ -692,8 +693,7 @@
 
 	down(&data->update_lock);
 
-	if ((jiffies - data->last_updated > 2 * HZ) ||
-	    (jiffies < data->last_updated) || !data->valid) {
+	if (time_after(jiffies, data->last_updated + 2 * HZ) || !data->valid) {
 
 		dev_dbg(&client->dev, "Starting gl520sm update\n");
 


-- 
Jean Delvare
