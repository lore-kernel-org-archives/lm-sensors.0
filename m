From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Dec 2009 13:16:13 +0000
Subject: [lm-sensors] [PATCH 1/3] hwmon: (smsc47m1) Only request I/O ports
Message-Id: <20091206141613.14442d77@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

The I/O area of the SMSC LPC47M1xx chips which we use, gives access to
a lot of registers, some of which are related to fan speed monitoring
and control, but many are not. At the moment, the smsc47m1 driver
requests the whole I/O port range. This could easily result in
resource conflicts with either ACPI or other drivers.

Request only the I/O ports we really use, to prevent such conflicts.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/smsc47m1.c |   99 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 89 insertions(+), 10 deletions(-)

--- linux-2.6.33-rc0.orig/drivers/hwmon/smsc47m1.c	2009-12-04 18:53:50.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/smsc47m1.c	2009-12-05 13:19:36.000000000 +0100
@@ -481,13 +481,94 @@ static int __init smsc47m1_find(unsigned
 	return 0;
 }
 
+#define CHECK		1
+#define REQUEST		2
+#define RELEASE		3
+
+/*
+ * This function can be used to:
+ *  - test for resource conflicts with ACPI
+ *  - request the resources
+ *  - release the resources
+ * We only allocate the I/O ports we really need, to minimize the risk of
+ * conflicts with ACPI or with other drivers.
+ */
+static int smsc47m1_handle_resources(unsigned short address, enum chips type,
+				     int action, struct device *dev)
+{
+	static const u8 ports_m1[] = {
+		/* register, region length */
+		0x04, 1,
+		0x33, 4,
+		0x56, 7,
+	};
+
+	static const u8 ports_m2[] = {
+		/* register, region length */
+		0x04, 1,
+		0x09, 1,
+		0x2c, 2,
+		0x35, 4,
+		0x56, 7,
+		0x69, 4,
+	};
+
+	int i, ports_size, err;
+	const u8 *ports;
+
+	switch (type) {
+	case smsc47m1:
+	default:
+		ports = ports_m1;
+		ports_size = ARRAY_SIZE(ports_m1);
+		break;
+	case smsc47m2:
+		ports = ports_m2;
+		ports_size = ARRAY_SIZE(ports_m2);
+		break;
+	}
+
+	for (i = 0; i + 1 < ports_size; i += 2) {
+		unsigned short start = address + ports[i];
+		unsigned short len = ports[i + 1];
+
+		switch (action) {
+		case CHECK:
+			/* Only check for conflicts */
+			err = acpi_check_region(start, len, DRVNAME);
+			if (err)
+				return err;
+			break;
+		case REQUEST:
+			/* Request the resources */
+			if (!request_region(start, len, DRVNAME)) {
+				dev_err(dev, "Region 0x%hx-0x%hx already in "
+					"use!\n", start, start + len);
+
+				/* Undo all requests */
+				for (i -= 2; i >= 0; i -= 2)
+					release_region(address + ports[i],
+						       ports[i + 1]);
+				return -EBUSY;
+			}
+			break;
+		case RELEASE:
+			/* Release the resources */
+			release_region(start, len);
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int __devinit smsc47m1_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct smsc47m1_sio_data *sio_data = dev->platform_data;
 	struct smsc47m1_data *data;
 	struct resource *res;
-	int err = 0;
+	int err;
 	int fan1, fan2, fan3, pwm1, pwm2, pwm3;
 
 	static const char *names[] = {
@@ -496,12 +577,10 @@ static int __devinit smsc47m1_probe(stru
 	};
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	if (!request_region(res->start, SMSC_EXTENT, DRVNAME)) {
-		dev_err(dev, "Region 0x%lx-0x%lx already in use!\n",
-			(unsigned long)res->start,
-			(unsigned long)res->end);
-		return -EBUSY;
-	}
+	err = smsc47m1_handle_resources(res->start, sio_data->type,
+					REQUEST, dev);
+	if (err < 0)
+		return err;
 
 	if (!(data = kzalloc(sizeof(struct smsc47m1_data), GFP_KERNEL))) {
 		err = -ENOMEM;
@@ -637,7 +716,7 @@ error_free:
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 error_release:
-	release_region(res->start, SMSC_EXTENT);
+	smsc47m1_handle_resources(res->start, sio_data->type, RELEASE, dev);
 	return err;
 }
 
@@ -650,7 +729,7 @@ static int __devexit smsc47m1_remove(str
 	sysfs_remove_group(&pdev->dev.kobj, &smsc47m1_group);
 
 	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	release_region(res->start, SMSC_EXTENT);
+	smsc47m1_handle_resources(res->start, data->type, RELEASE, &pdev->dev);
 	platform_set_drvdata(pdev, NULL);
 	kfree(data);
 
@@ -717,7 +796,7 @@ static int __init smsc47m1_device_add(un
 	};
 	int err;
 
-	err = acpi_check_resource_conflict(&res);
+	err = smsc47m1_handle_resources(address, sio_data->type, CHECK, NULL);
 	if (err)
 		goto exit;
 


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
