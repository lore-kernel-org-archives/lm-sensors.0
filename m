From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Dec 2009 13:16:44 +0000
Subject: [lm-sensors] [PATCH 2/3] hwmon: (smsc47m1) Fail module loading on
Message-Id: <20091206141644.2aaa292b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

If an error occurs during probing, there's no point in keeping the
module in memory. Better fail the module loading early to make the
problem more visible.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/smsc47m1.c |   24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

--- linux-2.6.33-rc0.orig/drivers/hwmon/smsc47m1.c	2009-12-06 13:01:56.000000000 +0100
+++ linux-2.6.33-rc0/drivers/hwmon/smsc47m1.c	2009-12-06 14:02:03.000000000 +0100
@@ -139,8 +139,7 @@ struct smsc47m1_sio_data {
 };
 
 
-static int smsc47m1_probe(struct platform_device *pdev);
-static int __devexit smsc47m1_remove(struct platform_device *pdev);
+static int __exit smsc47m1_remove(struct platform_device *pdev);
 static struct smsc47m1_data *smsc47m1_update_device(struct device *dev,
 		int init);
 
@@ -160,8 +159,7 @@ static struct platform_driver smsc47m1_d
 		.owner	= THIS_MODULE,
 		.name	= DRVNAME,
 	},
-	.probe		= smsc47m1_probe,
-	.remove		= __devexit_p(smsc47m1_remove),
+	.remove		= __exit_p(smsc47m1_remove),
 };
 
 static ssize_t get_fan(struct device *dev, struct device_attribute
@@ -562,7 +560,7 @@ static int smsc47m1_handle_resources(uns
 	return 0;
 }
 
-static int __devinit smsc47m1_probe(struct platform_device *pdev)
+static int __init smsc47m1_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct smsc47m1_sio_data *sio_data = dev->platform_data;
@@ -720,7 +718,7 @@ error_release:
 	return err;
 }
 
-static int __devexit smsc47m1_remove(struct platform_device *pdev)
+static int __exit smsc47m1_remove(struct platform_device *pdev)
 {
 	struct smsc47m1_data *data = platform_get_drvdata(pdev);
 	struct resource *res;
@@ -845,27 +843,27 @@ static int __init sm_smsc47m1_init(void)
 	if (smsc47m1_find(&address, &sio_data))
 		return -ENODEV;
 
-	err = platform_driver_register(&smsc47m1_driver);
+	/* Sets global pdev as a side effect */
+	err = smsc47m1_device_add(address, &sio_data);
 	if (err)
 		goto exit;
 
-	/* Sets global pdev as a side effect */
-	err = smsc47m1_device_add(address, &sio_data);
+	err = platform_driver_probe(&smsc47m1_driver, smsc47m1_probe);
 	if (err)
-		goto exit_driver;
+		goto exit_device;
 
 	return 0;
 
-exit_driver:
-	platform_driver_unregister(&smsc47m1_driver);
+exit_device:
+	platform_device_unregister(pdev);
 exit:
 	return err;
 }
 
 static void __exit sm_smsc47m1_exit(void)
 {
-	platform_device_unregister(pdev);
 	platform_driver_unregister(&smsc47m1_driver);
+	platform_device_unregister(pdev);
 }
 
 MODULE_AUTHOR("Mark D. Studebaker <mdsxyz123@yahoo.com>");


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
