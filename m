From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 26 Jun 2008 04:10:30 +0000
Subject: [lm-sensors] [patch 4/5 v1] hwmon/pc87360 individual alarm files -
Message-Id: <486316B6.3030005@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020109020508090608040601"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020109020508090608040601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



--------------020109020508090608040601
Content-Type: text/x-patch;
	name="0004-add-LDNI_MAX-constant-for-3-Logical-Devices-we-handl.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0004-add-LDNI_MAX-constant-for-3-Logical-Devices-we-handl.pa";
	filename*1="tch"

From 2f411c315332e1e279c45914c69ee34f640671d8 Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sun, 15 Jun 2008 09:22:35 -0600
Subject: [PATCH] add LDNI_MAX constant for 3 Logical Devices we handle

Driver handles 3 logical units, make that a little clearer.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 37aaaf2..9163b62 100644
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


--------------020109020508090608040601
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020109020508090608040601--
