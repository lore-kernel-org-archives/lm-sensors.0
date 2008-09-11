From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 11 Sep 2008 04:41:04 +0000
Subject: [lm-sensors] [ patch 2.6.27-rc6 4/6 v2] separate alarm sysfs files
Message-Id: <48C8A160.40503@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070209010005010304090504"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070209010005010304090504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

 From a036bdecb94b279fd699ceb9e31732f1b527568d Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 28 Jun 2008 13:40:50 -0600
Subject: [PATCH] hwmon/pc87360 separate alarm files - use ARRAY_SIZE, not 3

Driver handles 3 logical devices in fixed length array. Replace 3 with 
ARRAY_SIZE.

This is a drive-by patch.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 17688b7..ac9dcca 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -75,7 +75,7 @@ MODULE_PARM_DESC(force_id, "Override the detected 
device ID");
 #define FSCM    0x09    /* Logical device: fans */
 #define VLM    0x0d    /* Logical device: voltages */
 #define TMS    0x0e    /* Logical device: temperatures */
-static const u8 logdev[3] = { FSCM, VLM, TMS };
+static const u8 logdev[] = { FSCM, VLM, TMS };
 
 #define LD_FAN        0
 #define LD_IN        1
@@ -1079,7 +1079,7 @@ static int __devinit pc87360_probe(struct 
platform_device *pdev)
     mutex_init(&data->update_lock);
     platform_set_drvdata(pdev, data);
 
-    for (i = 0; i < 3; i++) {
+    for (i = 0; i < ARRAY_SIZE(logdev); i++) {
         if (((data->address[i] = extra_isa[i]))
          && !request_region(extra_isa[i], PC87360_EXTENT,
                      pc87360_driver.driver.name)) {
-- 
1.5.5.1


--------------070209010005010304090504
Content-Type: text/x-patch;
	name="0004-hwmon-pc87360-separate-alarm-files-use-ARRAY_SIZE.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0004-hwmon-pc87360-separate-alarm-files-use-ARRAY_SIZE.patch"

From a036bdecb94b279fd699ceb9e31732f1b527568d Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 28 Jun 2008 13:40:50 -0600
Subject: [PATCH] hwmon/pc87360 separate alarm files - use ARRAY_SIZE, not 3

Driver handles 3 logical devices in fixed length array.
Replace 3 with ARRAY_SIZE

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 17688b7..ac9dcca 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -75,7 +75,7 @@ MODULE_PARM_DESC(force_id, "Override the detected device ID");
 #define FSCM	0x09	/* Logical device: fans */
 #define VLM	0x0d	/* Logical device: voltages */
 #define TMS	0x0e	/* Logical device: temperatures */
-static const u8 logdev[3] = { FSCM, VLM, TMS };
+static const u8 logdev[] = { FSCM, VLM, TMS };
 
 #define LD_FAN		0
 #define LD_IN		1
@@ -1079,7 +1079,7 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
 
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < ARRAY_SIZE(logdev); i++) {
 		if (((data->address[i] = extra_isa[i]))
 		 && !request_region(extra_isa[i], PC87360_EXTENT,
 		 		    pc87360_driver.driver.name)) {
-- 
1.5.5.1


--------------070209010005010304090504
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070209010005010304090504--
