From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Jun 2012 15:24:13 +0000
Subject: [lm-sensors] [PATCH 92/95] hwmon: (smsc47m1) Convert to use devm_ functions
Message-Id: <1339773856-3443-93-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Convert to use devm_ functions to reduce code size and simplify the code.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/smsc47m1.c |   40 ++++++++--------------------------------
 1 file changed, 8 insertions(+), 32 deletions(-)

diff --git a/drivers/hwmon/smsc47m1.c b/drivers/hwmon/smsc47m1.c
index b5aa38d..b3a38af 100644
--- a/drivers/hwmon/smsc47m1.c
+++ b/drivers/hwmon/smsc47m1.c
@@ -584,13 +584,11 @@ static void smsc47m1_restore(const struct smsc47m1_sio_data *sio_data)
 
 #define CHECK		1
 #define REQUEST		2
-#define RELEASE		3
 
 /*
  * This function can be used to:
  *  - test for resource conflicts with ACPI
  *  - request the resources
- *  - release the resources
  * We only allocate the I/O ports we really need, to minimize the risk of
  * conflicts with ACPI or with other drivers.
  */
@@ -642,21 +640,13 @@ static int smsc47m1_handle_resources(unsigned short address, enum chips type,
 			break;
 		case REQUEST:
 			/* Request the resources */
-			if (!request_region(start, len, DRVNAME)) {
-				dev_err(dev, "Region 0x%hx-0x%hx already in "
-					"use!\n", start, start + len);
-
-				/* Undo all requests */
-				for (i -= 2; i >= 0; i -= 2)
-					release_region(address + ports[i],
-						       ports[i + 1]);
+			if (!devm_request_region(dev, start, len, DRVNAME)) {
+				dev_err(dev,
+					"Region 0x%hx-0x%hx already in use!\n",
+					start, start + len);
 				return -EBUSY;
 			}
 			break;
-		case RELEASE:
-			/* Release the resources */
-			release_region(start, len);
-			break;
 		}
 	}
 
@@ -694,11 +684,9 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
 	if (err < 0)
 		return err;
 
-	data = kzalloc(sizeof(struct smsc47m1_data), GFP_KERNEL);
-	if (!data) {
-		err = -ENOMEM;
-		goto error_release;
-	}
+	data = devm_kzalloc(dev, sizeof(struct smsc47m1_data), GFP_KERNEL);
+	if (!data)
+		return -ENOMEM;
 
 	data->addr = res->start;
 	data->type = sio_data->type;
@@ -733,8 +721,7 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
 	}
 	if (!(fan1 || fan2 || fan3 || pwm1 || pwm2 || pwm3)) {
 		dev_warn(dev, "Device not configured, will not use\n");
-		err = -ENODEV;
-		goto error_free;
+		return -ENODEV;
 	}
 
 	/*
@@ -810,27 +797,16 @@ static int __init smsc47m1_probe(struct platform_device *pdev)
 
 error_remove_files:
 	smsc47m1_remove_files(dev);
-error_free:
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-error_release:
-	smsc47m1_handle_resources(res->start, sio_data->type, RELEASE, dev);
 	return err;
 }
 
 static int __exit smsc47m1_remove(struct platform_device *pdev)
 {
 	struct smsc47m1_data *data = platform_get_drvdata(pdev);
-	struct resource *res;
 
 	hwmon_device_unregister(data->hwmon_dev);
 	smsc47m1_remove_files(&pdev->dev);
 
-	res = platform_get_resource(pdev, IORESOURCE_IO, 0);
-	smsc47m1_handle_resources(res->start, data->type, RELEASE, &pdev->dev);
-	platform_set_drvdata(pdev, NULL);
-	kfree(data);
-
 	return 0;
 }
 
-- 
1.7.9.7


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
