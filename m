From: Luca Tettamanti <kronos.it@gmail.com>
Date: Mon, 07 Dec 2009 16:07:25 +0000
Subject: [lm-sensors] [PATCH] hwmon: (asus_atk0110): Refactor interface
Message-Id: <20091207160725.GA24212@nb-core2.darkstar.lan>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The behaviour is unmodified, this makes easier to override the heuristic (which
is probably needed for some boards).

Signed-off-by: Luca Tettamanti <kronos.it@gmail.com>
---
Will follow up with another patch that depends on this one.

 drivers/hwmon/asus_atk0110.c |   98 +++++++++++++++++++------------------------
 1 file changed, 44 insertions(+), 54 deletions(-)

Index: linux-2.6.git/drivers/hwmon/asus_atk0110.c
=================================--- linux-2.6.git.orig/drivers/hwmon/asus_atk0110.c	2009-12-03 18:01:51.000000000 +0100
+++ linux-2.6.git/drivers/hwmon/asus_atk0110.c	2009-12-07 14:49:49.000000000 +0100
@@ -1047,76 +1047,75 @@
 	return err;
 }
 
-static int atk_check_old_if(struct atk_data *data)
+static int atk_probe_if(struct atk_data *data)
 {
 	struct device *dev = &data->acpi_dev->dev;
 	acpi_handle ret;
 	acpi_status status;
+	int err = 0;
 
 	/* RTMP: read temperature */
 	status = acpi_get_handle(data->atk_handle, METHOD_OLD_READ_TMP, &ret);
-	if (status != AE_OK) {
+	if (ACPI_SUCCESS(status))
+		data->rtmp_handle = ret;
+	else
 		dev_dbg(dev, "method " METHOD_OLD_READ_TMP " not found: %s\n",
 				acpi_format_exception(status));
-		return -ENODEV;
-	}
-	data->rtmp_handle = ret;
 
 	/* RVLT: read voltage */
 	status = acpi_get_handle(data->atk_handle, METHOD_OLD_READ_VLT, &ret);
-	if (status != AE_OK) {
+	if (ACPI_SUCCESS(status))
+		data->rvlt_handle = ret;
+	else
 		dev_dbg(dev, "method " METHOD_OLD_READ_VLT " not found: %s\n",
 				acpi_format_exception(status));
-		return -ENODEV;
-	}
-	data->rvlt_handle = ret;
 
 	/* RFAN: read fan status */
 	status = acpi_get_handle(data->atk_handle, METHOD_OLD_READ_FAN, &ret);
-	if (status != AE_OK) {
+	if (ACPI_SUCCESS(status))
+		data->rfan_handle = ret;
+	else
 		dev_dbg(dev, "method " METHOD_OLD_READ_FAN " not found: %s\n",
 				acpi_format_exception(status));
-		return -ENODEV;
-	}
-	data->rfan_handle = ret;
-
-	return 0;
-}
-
-static int atk_check_new_if(struct atk_data *data)
-{
-	struct device *dev = &data->acpi_dev->dev;
-	acpi_handle ret;
-	acpi_status status;
 
 	/* Enumeration */
 	status = acpi_get_handle(data->atk_handle, METHOD_ENUMERATE, &ret);
-	if (status != AE_OK) {
+	if (ACPI_SUCCESS(status))
+		data->enumerate_handle = ret;
+	else
 		dev_dbg(dev, "method " METHOD_ENUMERATE " not found: %s\n",
 				acpi_format_exception(status));
-		return -ENODEV;
-	}
-	data->enumerate_handle = ret;
 
 	/* De-multiplexer (read) */
 	status = acpi_get_handle(data->atk_handle, METHOD_READ, &ret);
-	if (status != AE_OK) {
+	if (ACPI_SUCCESS(status))
+		data->read_handle = ret;
+	else
 		dev_dbg(dev, "method " METHOD_READ " not found: %s\n",
 				acpi_format_exception(status));
-		return -ENODEV;
-	}
-	data->read_handle = ret;
 
 	/* De-multiplexer (write) */
 	status = acpi_get_handle(data->atk_handle, METHOD_WRITE, &ret);
-	if (status != AE_OK) {
-		dev_dbg(dev, "method " METHOD_READ " not found: %s\n",
+	if (ACPI_SUCCESS(status))
+		data->write_handle = ret;
+	else
+		dev_dbg(dev, "method " METHOD_WRITE " not found: %s\n",
 				 acpi_format_exception(status));
-		return -ENODEV;
-	}
-	data->write_handle = ret;
 
-	return 0;
+	/* Check for hwmon methods: first check "old" style methods; note that
+	 * both may be present: in this case we stick to the old interface;
+	 * analysis of multiple DSDTs indicates that when both interfaces
+	 * are present the new one (GGRP/GITM) is not functional.
+	 */
+	if (data->rtmp_handle && data->rvlt_handle && data->rfan_handle)
+		data->old_interface = true;
+	else if (data->enumerate_handle && data->read_handle &&
+			data->write_handle)
+		data->old_interface = false;
+	else
+		err = -ENODEV;
+
+	return err;
 }
 
 static int atk_add(struct acpi_device *device)
@@ -1155,28 +1154,19 @@
 	}
 	ACPI_FREE(buf.pointer);
 
-	/* Check for hwmon methods: first check "old" style methods; note that
-	 * both may be present: in this case we stick to the old interface;
-	 * analysis of multiple DSDTs indicates that when both interfaces
-	 * are present the new one (GGRP/GITM) is not functional.
-	 */
-	err = atk_check_old_if(data);
-	if (!err) {
-		dev_dbg(&device->dev, "Using old hwmon interface\n");
-		data->old_interface = true;
-	} else {
-		err = atk_check_new_if(data);
-		if (err)
-			goto out;
-
-		dev_dbg(&device->dev, "Using new hwmon interface\n");
-		data->old_interface = false;
+	err = atk_probe_if(data);
+	if (err) {
+		dev_err(&device->dev, "No usable hwmon interface detected\n");
+		goto out;
 	}
 
-	if (data->old_interface)
+	if (data->old_interface) {
+		dev_dbg(&device->dev, "Using old hwmon interface\n");
 		err = atk_enumerate_old_hwmon(data);
-	else
+	} else {
+		dev_dbg(&device->dev, "Using new hwmon interface\n");
 		err = atk_enumerate_new_hwmon(data);
+	}
 	if (err < 0)
 		goto out;
 	if (err = 0) {

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
