From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 25 Oct 2007 11:11:01 +0000
Subject: [lm-sensors] [PATCH] hwmon: (w83781d) Add missing curly braces
Message-Id: <20071025131101.364e7c58@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Missing curly braces cause an if statement to be evaluated when it
shouldn't. It happens to be harmless, but that's still worth fixing.
Thanks to Riku Voipio for reporting.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83781d.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-2.6.24-rc1.orig/drivers/hwmon/w83781d.c	2007-10-25 12:58:24.000000000 +0200
+++ linux-2.6.24-rc1/drivers/hwmon/w83781d.c	2007-10-25 13:06:00.000000000 +0200
@@ -1121,12 +1121,13 @@ w83781d_create_files(struct device *dev,
 				&sensor_dev_attr_temp3_beep.dev_attr)))
 			return err;
 
-		if (kind != w83781d)
+		if (kind != w83781d) {
 			err = sysfs_chmod_file(&dev->kobj,
 				&sensor_dev_attr_temp3_alarm.dev_attr.attr,
 				S_IRUGO | S_IWUSR);
 			if (err)
 				return err;
+		}
 	}
 
 	if (kind != w83781d && kind != as99127f) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
