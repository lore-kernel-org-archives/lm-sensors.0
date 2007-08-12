From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Aug 2007 11:58:50 +0000
Subject: [lm-sensors] [PATCH] hwmon/smsc47m1: Restore missing name attribute
Message-Id: <20070812135850.04c5089a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The smsc47m1 driver no longer creates the name attribute used by
libsensors to identify chip types. It was lost during the conversion
to a platform driver. I was fooled by the fact that we do have a
group with all attributes, but only to delete them all at once. The
group is not used to create the attributes, so we have to explicitly
create the name attribute.

This fixes lm-sensors ticket #2236:
http://lm-sensors.org/ticket/2236

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
Mark, this fixes a regression in 2.6.22. This means that this patch
must be sent to Linus for 2.6.23, but also to the stable team for
2.6.22.3.

 drivers/hwmon/smsc47m1.c |    2 ++
 1 file changed, 2 insertions(+)

--- linux-2.6.23-rc2.orig/drivers/hwmon/smsc47m1.c	2007-08-11 16:14:14.000000000 +0200
+++ linux-2.6.23-rc2/drivers/hwmon/smsc47m1.c	2007-08-11 17:25:29.000000000 +0200
@@ -585,6 +585,8 @@ static int __devinit smsc47m1_probe(stru
 
 	if ((err = device_create_file(dev, &dev_attr_alarms)))
 		goto error_remove_files;
+	if ((err = device_create_file(dev, &dev_attr_name)))
+		goto error_remove_files;
 
 	data->class_dev = hwmon_device_register(dev);
 	if (IS_ERR(data->class_dev)) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
