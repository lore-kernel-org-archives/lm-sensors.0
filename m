From: Jim Cromie <jim.cromie@gmail.com>
Date: Sun, 29 Jun 2008 18:17:30 +0000
Subject: [lm-sensors] [patch 4/6 v2] hwmon/pc87360 individual alarm files -
Message-Id: <4867D1BA.5030505@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------080502060905060607090405"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------080502060905060607090405
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

pasted and attached

[jimc@harpo linux-2.6]$ more  
0004-hwmon-pc87360-separate-alarm-files-define-LDNI_MAX.patch
 From 68bfa74feadfeb191b28e994a9a1f7b76b6f9f7b Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 28 Jun 2008 13:40:50 -0600
Subject: [PATCH] hwmon/pc87360 separate alarm files - define LDNI_MAX const

Driver handles 3 logical devices in fixed length array.
Give this a define-d constant.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 6ffea41..ebb235b 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -75,7 +75,8 @@ MODULE_PARM_DESC(force_id, "Override the detected 
device ID");
 #define FSCM    0x09    /* Logical device: fans */
 #define VLM    0x0d    /* Logical device: voltages */
 #define TMS    0x0e    /* Logical device: temperatures */
-static const u8 logdev[3] = { FSCM, VLM, TMS };
+#define LDNI_MAX 3
+static const u8 logdev[LDNI_MAX] = { FSCM, VLM, TMS };
 
 #define LD_FAN        0
 #define LD_IN        1
@@ -1074,7 +1075,7 @@ static int __devinit pc87360_probe(struct 
platform_device *pdev)
     mutex_init(&data->update_lock);
     platform_set_drvdata(pdev, data);
 
-    for (i = 0; i < 3; i++) {
+    for (i = 0; i < LDNI_MAX; i++) {
         if (((data->address[i] = extra_isa[i]))
          && !request_region(extra_isa[i], PC87360_EXTENT,
                      pc87360_driver.driver.name)) {
-- 
1.5.5.1


--------------080502060905060607090405
Content-Type: text/x-patch;
	name="0004-hwmon-pc87360-separate-alarm-files-define-LDNI_MAX.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0004-hwmon-pc87360-separate-alarm-files-define-LDNI_MAX.patc";
	filename*1="h"

From 68bfa74feadfeb191b28e994a9a1f7b76b6f9f7b Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 28 Jun 2008 13:40:50 -0600
Subject: [PATCH] hwmon/pc87360 separate alarm files - define LDNI_MAX const

Driver handles 3 logical devices in fixed length array.
Give this a define-d constant.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 6ffea41..ebb235b 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -75,7 +75,8 @@ MODULE_PARM_DESC(force_id, "Override the detected device ID");
 #define FSCM	0x09	/* Logical device: fans */
 #define VLM	0x0d	/* Logical device: voltages */
 #define TMS	0x0e	/* Logical device: temperatures */
-static const u8 logdev[3] = { FSCM, VLM, TMS };
+#define LDNI_MAX 3
+static const u8 logdev[LDNI_MAX] = { FSCM, VLM, TMS };
 
 #define LD_FAN		0
 #define LD_IN		1
@@ -1074,7 +1075,7 @@ static int __devinit pc87360_probe(struct platform_device *pdev)
 	mutex_init(&data->update_lock);
 	platform_set_drvdata(pdev, data);
 
-	for (i = 0; i < 3; i++) {
+	for (i = 0; i < LDNI_MAX; i++) {
 		if (((data->address[i] = extra_isa[i]))
 		 && !request_region(extra_isa[i], PC87360_EXTENT,
 		 		    pc87360_driver.driver.name)) {
-- 
1.5.5.1


--------------080502060905060607090405
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------080502060905060607090405--
