From: Hans de Goede <hdegoede@redhat.com>
Date: Fri, 30 Jan 2009 10:29:47 +0000
Subject: [lm-sensors] PATCH:
Message-Id: <4982D69B.5090008@redhat.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000307030107020307050405"
List-Id: <lm-sensors.vger.kernel.org>
References: <46F3DD44.4070307@hhs.nl>
In-Reply-To: <46F3DD44.4070307@hhs.nl>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------000307030107020307050405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Jean,

<Trying to win the competition for the patch with the longest name :) >

This patch fixes a number of cases where things were not properly cleaned up
when acpi_check_resource_conflict() returned an error, causing oopses such as
the one reported here:
https://bugzilla.redhat.com/show_bug.cgi?id=483208

Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans

--------------000307030107020307050405
Content-Type: text/plain;
	name="hwmon-superio-fix-acpi-resource-check-error-handling.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="hwmon-superio-fix-acpi-resource-check-error-handling.patch"

This patch fixes a number of cases where things were not properly cleaned up
when acpi_check_resource_conflict() returned an error, causing oopses such as
the one reported here:
https://bugzilla.redhat.com/show_bug.cgi?id=483208

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
diff -up linux-2.6.28.x86_64/drivers/hwmon/f71882fg.c~ linux-2.6.28.x86_64/drivers/hwmon/f71882fg.c
--- linux-2.6.28.x86_64/drivers/hwmon/f71882fg.c~	2009-01-30 11:18:04.000000000 +0100
+++ linux-2.6.28.x86_64/drivers/hwmon/f71882fg.c	2009-01-30 11:18:04.000000000 +0100
@@ -1932,7 +1932,7 @@ static int __init f71882fg_device_add(un
 	res.name = f71882fg_pdev->name;
 	err = acpi_check_resource_conflict(&res);
 	if (err)
-		return err;
+		goto exit_device_put;
 
 	err = platform_device_add_resources(f71882fg_pdev, &res, 1);
 	if (err) {
diff -up linux-2.6.28.x86_64/drivers/hwmon/vt1211.c~ linux-2.6.28.x86_64/drivers/hwmon/vt1211.c
--- linux-2.6.28.x86_64/drivers/hwmon/vt1211.c~	2009-01-30 11:21:32.000000000 +0100
+++ linux-2.6.28.x86_64/drivers/hwmon/vt1211.c	2009-01-30 11:21:32.000000000 +0100
@@ -1262,7 +1262,7 @@ static int __init vt1211_device_add(unsi
 	res.name = pdev->name;
 	err = acpi_check_resource_conflict(&res);
 	if (err)
-		goto EXIT;
+		goto EXIT_DEV_PUT;
 
 	err = platform_device_add_resources(pdev, &res, 1);
 	if (err) {
diff -up linux-2.6.28.x86_64/drivers/hwmon/w83627ehf.c~ linux-2.6.28.x86_64/drivers/hwmon/w83627ehf.c
--- linux-2.6.28.x86_64/drivers/hwmon/w83627ehf.c~	2009-01-30 11:22:26.000000000 +0100
+++ linux-2.6.28.x86_64/drivers/hwmon/w83627ehf.c	2009-01-30 11:22:26.000000000 +0100
@@ -1548,7 +1548,7 @@ static int __init sensors_w83627ehf_init
 
 	err = acpi_check_resource_conflict(&res);
 	if (err)
-		goto exit;
+		goto exit_device_put;
 
 	err = platform_device_add_resources(pdev, &res, 1);
 	if (err) {

--------------000307030107020307050405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000307030107020307050405--
