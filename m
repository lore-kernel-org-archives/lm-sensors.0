From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Apr 2015 21:54:58 +0000
Subject: [lm-sensors] [PATCH v2 07/22] hwmon: (it87) Don't use pdev as static driver variable
Message-Id: <1428184513-22380-8-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Using the same varible name for function names and as static
variable invites misuse and prevents us from adding support
for a second chip. Rename pdev to it87_pdev and limit its use
to where it is needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rebased to previous patches; no functional change

 drivers/hwmon/it87.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index a951112d5481..dc40951346dd 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -76,7 +76,7 @@ static unsigned short force_id;
 module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
-static struct platform_device *pdev;
+static struct platform_device *it87_pdev;
 
 #define	REG	0x2e	/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
@@ -2257,7 +2257,7 @@ exit:
 
 static void it87_remove_files(struct device *dev)
 {
-	struct it87_data *data = platform_get_drvdata(pdev);
+	struct it87_data *data = dev_get_drvdata(dev);
 	struct it87_sio_data *sio_data = dev_get_platdata(dev);
 	int i;
 
@@ -2860,6 +2860,7 @@ static struct it87_data *it87_update_device(struct device *dev)
 static int __init it87_device_add(unsigned short address,
 				  const struct it87_sio_data *sio_data)
 {
+	struct platform_device *pdev;
 	struct resource res = {
 		.start	= address + IT87_EC_OFFSET,
 		.end	= address + IT87_EC_OFFSET + IT87_EC_EXTENT - 1,
@@ -2895,6 +2896,7 @@ static int __init it87_device_add(unsigned short address,
 		goto exit_device_put;
 	}
 
+	it87_pdev = pdev;
 	return 0;
 
 exit_device_put:
@@ -2927,7 +2929,7 @@ static int __init sm_it87_init(void)
 
 static void __exit sm_it87_exit(void)
 {
-	platform_device_unregister(pdev);
+	platform_device_unregister(it87_pdev);
 	platform_driver_unregister(&it87_driver);
 }
 
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
