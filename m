From: Rudolf Marek <r.marek@assembler.cz>
Date: Thu, 17 Jan 2008 23:42:54 +0000
Subject: [lm-sensors] [PATCH] coretemp: Add maximum cooling temperature
Message-Id: <478FE7FE.1060704@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030407060508010501060000"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030407060508010501060000
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

This patch updates my previous patch with Jeans valuable comments - yeah thanks!
Compile tested this time.

Following patch will add reporting of maximum temperature, at which all fans
should spin full speed. It may be non-physical temperature on Desktop/Server CPUs.

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

Thanks,
Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHj+f+3J9wPJqZRNURAsIuAKDBcEn8DaIIbUKzQfvXX7LW+sZo8gCaA3yI
QyaoVMnFMj81tb00vK7Va0E=
=WpB3
-----END PGP SIGNATURE-----

--------------030407060508010501060000
Content-Type: text/x-patch;
 name="add_temp_target.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_temp_target.patch"

Index: linux-2.6.24-rc7/drivers/hwmon/coretemp.c
===================================================================
--- linux-2.6.24-rc7.orig/drivers/hwmon/coretemp.c	2008-01-06 22:45:38.000000000 +0100
+++ linux-2.6.24-rc7/drivers/hwmon/coretemp.c	2008-01-18 00:19:34.899436907 +0100
@@ -38,7 +38,8 @@
 
 #define DRVNAME	"coretemp"
 
-typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_LABEL, SHOW_NAME } SHOW;
+typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL,
+		SHOW_NAME } SHOW;
 
 /*
  * Functions declaration
@@ -55,6 +56,7 @@
 	unsigned long last_updated;	/* in jiffies */
 	int temp;
 	int tjmax;
+	int ttarget;
 	u8 alarm;
 };
 
@@ -93,9 +95,10 @@
 
 	if (attr->index == SHOW_TEMP)
 		err = data->valid ? sprintf(buf, "%d\n", data->temp) : -EAGAIN;
-	else
+	else if (attr->index == SHOW_TJMAX)
 		err = sprintf(buf, "%d\n", data->tjmax);
-
+	else
+		err = sprintf(buf, "%d\n", data->ttarget);
 	return err;
 }
 
@@ -103,6 +106,8 @@
 			  SHOW_TEMP);
 static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL,
 			  SHOW_TJMAX);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL,
+			  SHOW_TTARGET);
 static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL);
 static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABEL);
 static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
@@ -223,8 +228,26 @@
 
 	platform_set_drvdata(pdev, data);
 
+	/* read the still undocumented IA32_TEMPERATURE_TARGET it exists
+	   on older CPUs but not in this register */
+
+	if (c->x86_model > 0xe) {
+		err = rdmsr_safe_on_cpu(data->id, 0x1a2, &eax, &edx);
+		if (err) {
+			dev_warn(&pdev->dev, "Unable to read"
+					" IA32_TEMPERATURE_TARGET MSR\n");
+		} else {
+			data->ttarget = data->tjmax -
+					(((eax >> 8) & 0xff) * 1000);
+			err = device_create_file(&pdev->dev,
+						 &sensor_dev_attr_temp1_max.dev_attr);
+			if (err)
+				goto exit_free;
+		}
+	}
+
 	if ((err = sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
-		goto exit_free;
+		goto exit_dev;
 
 	data->hwmon_dev = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(data->hwmon_dev)) {
@@ -238,6 +261,8 @@
 
 exit_class:
 	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
+exit_dev:
+	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
 exit_free:
 	kfree(data);
 exit:
@@ -250,6 +275,7 @@
 
 	hwmon_device_unregister(data->hwmon_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
+	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 	return 0;
Index: linux-2.6.24-rc7/Documentation/hwmon/coretemp
===================================================================
--- linux-2.6.24-rc7.orig/Documentation/hwmon/coretemp	2008-01-06 22:45:38.000000000 +0100
+++ linux-2.6.24-rc7/Documentation/hwmon/coretemp	2008-01-17 23:24:08.273863319 +0100
@@ -25,7 +25,8 @@
 the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
 
 temp1_input	 - Core temperature (in millidegrees Celsius).
-temp1_crit	 - Maximum junction temperature  (in millidegrees Celsius).
+temp1_max	 - All cooling devices should be turned on (on Core2).
+temp1_crit	 - Maximum junction temperature (in millidegrees Celsius).
 temp1_crit_alarm - Set when Out-of-spec bit is set, never clears.
 		   Correct CPU operation is no longer guaranteed.
 temp1_label	 - Contains string "Core X", where X is processor

--------------030407060508010501060000
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030407060508010501060000--
