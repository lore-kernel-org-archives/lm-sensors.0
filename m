From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 04 Apr 2015 21:54:57 +0000
Subject: [lm-sensors] [PATCH v2 06/22] hwmon: (it87) Simplify error return in it87_device_add
Message-Id: <1428184513-22380-7-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Return directly on errors if there is no cleanup necessary.
Don't create an error message on memory allocation errors.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
v2: Rebased to previous patches; no functional change

 drivers/hwmon/it87.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/it87.c b/drivers/hwmon/it87.c
index f5861b195080..a951112d5481 100644
--- a/drivers/hwmon/it87.c
+++ b/drivers/hwmon/it87.c
@@ -2870,14 +2870,11 @@ static int __init it87_device_add(unsigned short address,
 
 	err = acpi_check_resource_conflict(&res);
 	if (err)
-		goto exit;
+		return err;
 
 	pdev = platform_device_alloc(DRVNAME, address);
-	if (!pdev) {
-		err = -ENOMEM;
-		pr_err("Device allocation failed\n");
-		goto exit;
-	}
+	if (!pdev)
+		return -ENOMEM;
 
 	err = platform_device_add_resources(pdev, &res, 1);
 	if (err) {
@@ -2902,7 +2899,6 @@ static int __init it87_device_add(unsigned short address,
 
 exit_device_put:
 	platform_device_put(pdev);
-exit:
 	return err;
 }
 
-- 
2.1.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
