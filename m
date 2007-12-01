From: Rudolf Marek <r.marek@assembler.cz>
Date: Sat, 01 Dec 2007 20:37:39 +0000
Subject: [lm-sensors] [PATCH] coretemp: Add TEMP_TARGET support
Message-Id: <4751C613.8040502@assembler.cz>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050003040209050503050706"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050003040209050503050706
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello,

Attached patch enables driver to export the target temperature. This temper=
ature
is calibrated into each CPU, and serves as some indicator to cooling platfo=
rm.
All fans should spin at full speed if the temperature is reached.

Signed-off-by: Rudolf Marek <r.marek@assembler.cz>

I managed to get answer from Intel at:

http://softwarecommunity.intel.com/isn/Community/en-US/forums/permalink/302=
28436/30230975/ShowThread.aspx#30230975

Can someone test if it works please? The lines in the patch are longer than=
 80
chars, imho it is allowed now?

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +36.0=B0C  (high =3D +65.0=B0C, crit =3D +85.0=B0C)

I have in plan to add Penryn CPUs to driver once I know the details.

Thanks,
Rudolf
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFHUcYT3J9wPJqZRNURAmVIAJ9nAzEvV5ga4aJOoQvoQ4+Z0KfKdACgsPzn
zm379OPOCKjYP5TupXZXeqU=3D
=3DPMIb
-----END PGP SIGNATURE-----

--------------050003040209050503050706
Content-Type: text/x-patch;
 name="add_temp_target.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="add_temp_target.patch"

Index: linux-2.6.23.9/drivers/hwmon/coretemp.c
===================================================================
--- linux-2.6.23.9.orig/drivers/hwmon/coretemp.c	2007-12-01 12:28:08.000000000 +0100
+++ linux-2.6.23.9/drivers/hwmon/coretemp.c	2007-12-01 21:29:10.000000000 +0100
@@ -38,7 +38,7 @@
 
 #define DRVNAME	"coretemp"
 
-typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_LABEL, SHOW_NAME } SHOW;
+typedef enum { SHOW_TEMP, SHOW_TJMAX, SHOW_TTARGET, SHOW_LABEL, SHOW_NAME } SHOW;
 
 /*
  * Functions declaration
@@ -55,6 +55,7 @@
 	unsigned long last_updated;	/* in jiffies */
 	int temp;
 	int tjmax;
+	int ttarget;
 	u8 alarm;
 };
 
@@ -95,9 +96,10 @@
 
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
 
@@ -105,6 +107,8 @@
 			  SHOW_TEMP);
 static SENSOR_DEVICE_ATTR(temp1_crit, S_IRUGO, show_temp, NULL,
 			  SHOW_TJMAX);
+static SENSOR_DEVICE_ATTR(temp1_max, S_IRUGO, show_temp, NULL,
+			  SHOW_TTARGET);
 static DEVICE_ATTR(temp1_crit_alarm, S_IRUGO, show_alarm, NULL);
 static SENSOR_DEVICE_ATTR(temp1_label, S_IRUGO, show_name, NULL, SHOW_LABEL);
 static SENSOR_DEVICE_ATTR(name, S_IRUGO, show_name, NULL, SHOW_NAME);
@@ -223,10 +227,27 @@
 			 "temperature might be wrong!\n");
 	}
 
+	data->ttarget = data->tjmax;
+
+	/* read the still undocumented IA32_TEMPERATURE_TARGET it exists
+	   on older CPUs but not here */
+	if (c->x86_model > 0xe) {
+		err = rdmsr_safe_on_cpu(data->id, 0x1a2, &eax, &edx);
+		if (err) {
+			dev_warn(&pdev->dev, "Unable to read IA32_TEMPERATURE_TARGET MSR\n");
+		} else {
+			data->ttarget = data->tjmax - (((eax >> 8) & 0xff) * 1000);
+			err = device_create_file(&pdev->dev,
+							&sensor_dev_attr_temp1_max.dev_attr);
+			if (err)
+				goto exit_free;
+		}
+	}
+
 	platform_set_drvdata(pdev, data);
 
 	if ((err = sysfs_create_group(&pdev->dev.kobj, &coretemp_group)))
-		goto exit_free;
+		goto exit_dev;
 
 	data->class_dev = hwmon_device_register(&pdev->dev);
 	if (IS_ERR(data->class_dev)) {
@@ -240,6 +261,8 @@
 
 exit_class:
 	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
+exit_dev:
+	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
 exit_free:
 	kfree(data);
 exit:
@@ -252,6 +275,7 @@
 
 	hwmon_device_unregister(data->class_dev);
 	sysfs_remove_group(&pdev->dev.kobj, &coretemp_group);
+	device_remove_file(&pdev->dev, &sensor_dev_attr_temp1_max.dev_attr);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 	return 0;
Index: linux-2.6.23.9/Documentation/hwmon/coretemp
===================================================================
--- linux-2.6.23.9.orig/Documentation/hwmon/coretemp	2007-12-01 21:25:17.000000000 +0100
+++ linux-2.6.23.9/Documentation/hwmon/coretemp	2007-12-01 21:28:35.000000000 +0100
@@ -25,7 +25,8 @@
 the Out-Of-Spec bit. Following table summarizes the exported sysfs files:
 
 temp1_input	 - Core temperature (in millidegrees Celsius).
-temp1_crit	 - Maximum junction temperature  (in millidegrees Celsius).
+temp1_max	 - All cooling devices should be turned on (on Core2).
+temp1_crit	 - Maximum junction temperature (in millidegrees Celsius).
 temp1_crit_alarm - Set when Out-of-spec bit is set, never clears.
 		   Correct CPU operation is no longer guaranteed.
 temp1_label	 - Contains string "Core X", where X is processor

--------------050003040209050503050706
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050003040209050503050706--
