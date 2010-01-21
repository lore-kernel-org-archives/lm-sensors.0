From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Jan 2010 13:50:16 +0000
Subject: [lm-sensors] [PATCH 4/8] hwmon: (it87) Create vid attributes by
Message-Id: <20100121145016.2e82a99a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali@linux-fr.org>

Only VID-related attributes are left in it87_attributes_opt, so we
might as well rename it to it87_attributes_vid and use this group to
create all attributes at once.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/it87.c |   15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

--- linux-2.6.33-rc4.orig/drivers/hwmon/it87.c	2010-01-19 13:30:10.000000000 +0100
+++ linux-2.6.33-rc4/drivers/hwmon/it87.c	2010-01-19 13:40:14.000000000 +0100
@@ -1107,14 +1107,14 @@ static const struct attribute_group it87
 	{ .attrs = it87_attributes_pwm[2] },
 };
 
-static struct attribute *it87_attributes_opt[] = {
+static struct attribute *it87_attributes_vid[] = {
 	&dev_attr_vrm.attr,
 	&dev_attr_cpu0_vid.attr,
 	NULL
 };
 
-static const struct attribute_group it87_group_opt = {
-	.attrs = it87_attributes_opt,
+static const struct attribute_group it87_group_vid = {
+	.attrs = it87_attributes_vid,
 };
 
 /* SuperIO detection - will change isa_address if a chip is found */
@@ -1250,7 +1250,8 @@ static void it87_remove_files(struct dev
 			continue;
 		sysfs_remove_group(&dev->kobj, &it87_group_pwm[i]);
 	}
-	sysfs_remove_group(&dev->kobj, &it87_group_opt);
+	if (!sio_data->skip_vid)
+		sysfs_remove_group(&dev->kobj, &it87_group_vid);
 }
 
 static int __devinit it87_probe(struct platform_device *pdev)
@@ -1335,10 +1336,8 @@ static int __devinit it87_probe(struct p
 		data->vrm = vid_which_vrm();
 		/* VID reading from Super-I/O config space if available */
 		data->vid = sio_data->vid_value;
-		if ((err = device_create_file(dev,
-		     &dev_attr_vrm))
-		 || (err = device_create_file(dev,
-		     &dev_attr_cpu0_vid)))
+		err = sysfs_create_group(&dev->kobj, &it87_group_vid);
+		if (err)
 			goto ERROR4;
 	}
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
