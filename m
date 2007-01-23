From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 23 Jan 2007 16:34:25 +0000
Subject: [lm-sensors] [PATCH RFC] hwmon/f71805f: Fix a race condition
Message-Id: <20070123173425.dc47637e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LM Sensors <lm-sensors@lm-sensors.org>
Cc: LKML <linux-kernel@vger.kernel.org>

Hi all,

I think I introduced a potential race condition bug with commit
51c997d80e1f625aea3426a8a9087f5830ac6db3. I didn't realize it
back then, but platform_device_put and platform_device_release
both appear to free the platform data associated with the device.
This makes an explicit kfree redundant at best, and maybe even
racy, as it might occur while someone still holds a reference
to the platform device.

Can somebody with more experience with platform drivers than I have
myself confirm that the current code is broken and that the fix below
is correct?

Thanks.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 drivers/hwmon/f71805f.c |    8 +-------
 1 files changed, 1 insertion(+), 7 deletions(-)

--- linux-2.6.20-rc5.orig/drivers/hwmon/f71805f.c	2007-01-23 16:54:21.000000000 +0100
+++ linux-2.6.20-rc5/drivers/hwmon/f71805f.c	2007-01-23 16:55:05.000000000 +0100
@@ -1290,14 +1290,11 @@
 	if (err) {
 		printk(KERN_ERR DRVNAME ": Device addition failed (%d)\n",
 		       err);
-		goto exit_kfree_data;
+		goto exit_device_put;
 	}
 
 	return 0;
 
-exit_kfree_data:
-	kfree(pdev->dev.platform_data);
-	pdev->dev.platform_data = NULL;
 exit_device_put:
 	platform_device_put(pdev);
 exit:
@@ -1390,10 +1387,7 @@
 
 static void __exit f71805f_exit(void)
 {
-	kfree(pdev->dev.platform_data);
-	pdev->dev.platform_data = NULL;
 	platform_device_unregister(pdev);
-
 	platform_driver_unregister(&f71805f_driver);
 }
 


-- 
Jean Delvare

