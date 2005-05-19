From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:23:49 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <10476033263399@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <1047603324728@kroah.com>
References: <10476033213315@kroah.com>
In-Reply-To: <10476033213315@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com

ChangeSet 1.1113, 2003/03/13 16:37:27-08:00, greg@kroah.com

driver core: Export the legacy_bus structure for drivers to use.


 drivers/base/platform.c |    3 ++-
 include/linux/device.h  |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)


diff -Nru a/drivers/base/platform.c b/drivers/base/platform.c
--- a/drivers/base/platform.c	Thu Mar 13 16:57:00 2003
+++ b/drivers/base/platform.c	Thu Mar 13 16:57:00 2003
@@ -9,7 +9,7 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-static struct device legacy_bus = {
+struct device legacy_bus = {
 	.name		= "legacy bus",
 	.bus_id		= "legacy",
 };
@@ -75,5 +75,6 @@
 	return bus_register(&platform_bus_type);
 }
 
+EXPORT_SYMBOL(legacy_bus);
 EXPORT_SYMBOL(platform_device_register);
 EXPORT_SYMBOL(platform_device_unregister);
diff -Nru a/include/linux/device.h b/include/linux/device.h
--- a/include/linux/device.h	Thu Mar 13 16:57:00 2003
+++ b/include/linux/device.h	Thu Mar 13 16:57:00 2003
@@ -366,6 +366,7 @@
 extern void platform_device_unregister(struct platform_device *);
 
 extern struct bus_type platform_bus_type;
+extern struct device legacy_bus;
 
 /* drivers/base/power.c */
 extern int device_suspend(u32 state, u32 level);
