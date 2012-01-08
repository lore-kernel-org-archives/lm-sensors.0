From: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
Date: Sun, 08 Jan 2012 18:34:14 +0000
Subject: [lm-sensors] [PATCH 11/17 v2] hwmon: (hwmon) fix checkpatch issues
Message-Id: <1326047660-20539-11-git-send-email-fransmeulenbroeks@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

fixed:
WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#122: FILE: hwmon.c:122:
+EXPORT_SYMBOL_GPL(hwmon_device_register);

WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#123: FILE: hwmon.c:123:
+EXPORT_SYMBOL_GPL(hwmon_device_unregister);

Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
---
 drivers/hwmon/hwmon.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/hwmon.c b/drivers/hwmon/hwmon.c
index 6460487..b58a0ff 100644
--- a/drivers/hwmon/hwmon.c
+++ b/drivers/hwmon/hwmon.c
@@ -55,6 +55,7 @@ struct device *hwmon_device_register(struct device *dev)
 
 	return hwdev;
 }
+EXPORT_SYMBOL_GPL(hwmon_device_register);
 
 /**
  * hwmon_device_unregister - removes the previously registered class device
@@ -72,6 +73,7 @@ void hwmon_device_unregister(struct device *dev)
 		dev_dbg(dev->parent,
 			"hwmon_device_unregister() failed: bad class ID!\n");
 }
+EXPORT_SYMBOL_GPL(hwmon_device_unregister);
 
 static void __init hwmon_pci_quirks(void)
 {
@@ -119,9 +121,6 @@ static void __exit hwmon_exit(void)
 subsys_initcall(hwmon_init);
 module_exit(hwmon_exit);
 
-EXPORT_SYMBOL_GPL(hwmon_device_register);
-EXPORT_SYMBOL_GPL(hwmon_device_unregister);
-
 MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>");
 MODULE_DESCRIPTION("hardware monitoring sysfs/class support");
 MODULE_LICENSE("GPL");
-- 
1.7.8.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
