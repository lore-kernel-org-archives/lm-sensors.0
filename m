From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 22 May 2007 08:47:02 +0000
Subject: [lm-sensors] [PATCH] hwmon: Use platform_device_add_data()
Message-Id: <20070522104702.55c7e6a9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Use platform_device_add_data() in hardware monitoring drivers. This
makes the code nicer and smaller too. Reported by David Hubbard.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
Cc: David Hubbard <david.c.hubbard@gmail.com>
---
 drivers/hwmon/f71805f.c  |    9 +++------
 drivers/hwmon/smsc47m1.c |    9 +++------
 drivers/hwmon/w83627hf.c |    9 +++------
 3 files changed, 9 insertions(+), 18 deletions(-)

--- linux-2.6.22-rc2.orig/drivers/hwmon/w83627hf.c	2007-05-20 21:37:42.000000000 +0200
+++ linux-2.6.22-rc2/drivers/hwmon/w83627hf.c	2007-05-22 08:53:32.000000000 +0200
@@ -1548,15 +1548,12 @@ static int __init w83627hf_device_add(un
 		goto exit_device_put;
 	}
 
-	pdev->dev.platform_data = kmalloc(sizeof(struct w83627hf_sio_data),
-					  GFP_KERNEL);
-	if (!pdev->dev.platform_data) {
-		err = -ENOMEM;
+	err = platform_device_add_data(pdev, sio_data,
+				       sizeof(struct w83627hf_sio_data));
+	if (err) {
 		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
 		goto exit_device_put;
 	}
-	memcpy(pdev->dev.platform_data, sio_data,
-	       sizeof(struct w83627hf_sio_data));
 
 	err = platform_device_add(pdev);
 	if (err) {
--- linux-2.6.22-rc2.orig/drivers/hwmon/f71805f.c	2007-05-13 10:01:15.000000000 +0200
+++ linux-2.6.22-rc2/drivers/hwmon/f71805f.c	2007-05-22 08:55:08.000000000 +0200
@@ -1290,15 +1290,12 @@ static int __init f71805f_device_add(uns
 		goto exit_device_put;
 	}
 
-	pdev->dev.platform_data = kmalloc(sizeof(struct f71805f_sio_data),
-					  GFP_KERNEL);
-	if (!pdev->dev.platform_data) {
-		err = -ENOMEM;
+	err = platform_device_add_data(pdev, sio_data,
+				       sizeof(struct f71805f_sio_data));
+	if (err) {
 		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
 		goto exit_device_put;
 	}
-	memcpy(pdev->dev.platform_data, sio_data,
-	       sizeof(struct f71805f_sio_data));
 
 	err = platform_device_add(pdev);
 	if (err) {
--- linux-2.6.22-rc2.orig/drivers/hwmon/smsc47m1.c	2007-05-13 10:01:15.000000000 +0200
+++ linux-2.6.22-rc2/drivers/hwmon/smsc47m1.c	2007-05-22 08:54:41.000000000 +0200
@@ -693,15 +693,12 @@ static int __init smsc47m1_device_add(un
 		goto exit_device_put;
 	}
 
-	pdev->dev.platform_data = kmalloc(sizeof(struct smsc47m1_sio_data),
-					  GFP_KERNEL);
-	if (!pdev->dev.platform_data) {
-		err = -ENOMEM;
+	err = platform_device_add_data(pdev, sio_data,
+				       sizeof(struct smsc47m1_sio_data));
+	if (err) {
 		printk(KERN_ERR DRVNAME ": Platform data allocation failed\n");
 		goto exit_device_put;
 	}
-	memcpy(pdev->dev.platform_data, sio_data,
-	       sizeof(struct smsc47m1_sio_data));
 
 	err = platform_device_add(pdev);
 	if (err) {


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
