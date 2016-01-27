From: Guenter Roeck <patchwork@patchwork.roeck-us.net>
Date: Wed, 27 Jan 2016 02:03:29 +0000
Subject: [lm-sensors] [PATCH v3 05/25] hwmon: (it87) Don't use pdev as static driver variable
Message-Id: <1453860229-23614-6-git-send-email-patchwork@patchwork.roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

Using the same varible name for function names and as static
variable invites misuse and prevents us from adding support
for a second chip. Rename pdev to it87_pdev and limit its use
to where it is needed.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/hwmon/it87.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index 9b36987d7949..8f28f9b04150 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -78,7 +78,7 @@ static unsigned short force_id;
 module_param(force_id, ushort, 0);
 MODULE_PARM_DESC(force_id, "Override the detected device ID");
 
-static struct platform_device *pdev;
+static struct platform_device *it87_pdev;
 
 #define	REG	0x2e	/* The register to read/write */
 #define	DEV	0x07	/* Register: Logical device select */
@@ -2285,7 +2285,7 @@ exit:
 
 static void it87_remove_files(struct device *dev)
 {
-	struct it87_data *data = platform_get_drvdata(pdev);
+	struct it87_data *data = dev_get_drvdata(dev);
 	struct it87_sio_data *sio_data = dev_get_platdata(dev);
 	int i;
 
@@ -2888,6 +2888,7 @@ static struct it87_data *it87_update_device(struct device *dev)
 static int __init it87_device_add(unsigned short address,
 				  const struct it87_sio_data *sio_data)
 {
+	struct platform_device *pdev;
 	struct resource res = {
 		.start	= address + IT87_EC_OFFSET,
 		.end	= address + IT87_EC_OFFSET + IT87_EC_EXTENT - 1,
@@ -2923,6 +2924,7 @@ static int __init it87_device_add(unsigned short address,
 		goto exit_device_put;
 	}
 
+	it87_pdev = pdev;
 	return 0;
 
 exit_device_put:
@@ -2955,7 +2957,7 @@ static int __init sm_it87_init(void)
 
 static void __exit sm_it87_exit(void)
 {
-	platform_device_unregister(pdev);
+	platform_device_unregister(it87_pdev);
 	platform_driver_unregister(&it87_driver);
 }
 
-- 
2.1.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
