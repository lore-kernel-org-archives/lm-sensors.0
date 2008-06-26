From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 26 Jun 2008 04:12:55 +0000
Subject: [lm-sensors] [patch 5/5 v1] hwmon/pc87360 individual alarm files -
Message-Id: <48631747.4040409@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------070102050707030509060907"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------070102050707030509060907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


restating, Im open to any process tips that seem relevant to you

--------------070102050707030509060907
Content-Type: text/x-patch;
	name="0005-Add-dev_dbg-calls-to-show-status-regs-at-module-lo.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0005-Add-dev_dbg-calls-to-show-status-regs-at-module-lo.patc";
	filename*1="h"

From 72596c8a6c3f7bf11b7d121023f3eb829083742f Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 18 Jun 2008 00:17:55 -0600
Subject: [PATCH] Add dev_dbg() calls to show status regs at module load.

Channel status register values may be set by chip specifications,
set again by bios, or by this previously loaded driver.
My bios (soekris 4801, with TinyBIOS I think) sets CHAN_ALM_ENA
on vin channels, but not on temp channels.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 9163b62..6b61213 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -33,6 +33,8 @@
  *  the standard Super-I/O addresses is used (0x2E/0x2F or 0x4E/0x4F).
  */
 
+#define DEBUG 1
+
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/slab.h>
@@ -1290,10 +1292,11 @@ static void pc87360_init_device(struct platform_device *pdev,
 
 	nr = data->innr < 11 ? data->innr : 11;
 	for (i = 0; i < nr; i++) {
+		reg = pc87360_read_value(data, LD_IN, i,
+					 PC87365_REG_IN_STATUS));
+		dev_dbg(&pdev->dev, "bios vin/temp %d status:0x%02x\n", i, reg);
 		if (init >= init_in[i]) {
 			/* Forcibly enable voltage channel */
-			reg = pc87360_read_value(data, LD_IN, i,
-						 PC87365_REG_IN_STATUS);
 			if (!(reg & CHAN_ENA)) {
 				dev_dbg(&pdev->dev, "Forcibly "
 					"enabling in%d\n", i);
@@ -1310,14 +1313,17 @@ static void pc87360_init_device(struct platform_device *pdev,
 		reg = pc87360_read_value(data, LD_IN, i,
 					 PC87365_REG_TEMP_STATUS);
 		use_thermistors = use_thermistors || (reg & CHAN_ENA);
+		dev_dbg(&pdev->dev, "bios temp%d_status:0x%.2x thermistors:%d\n",
+			i, reg, use_thermistors);
 	}
 
 	i = use_thermistors ? 2 : 0;
 	for (; i < data->tempnr; i++) {
+		reg = pc87360_read_value(data, LD_TEMP, i,
+					 PC87365_REG_TEMP_STATUS);
+		dev_dbg(&pdev->dev, "bios temp%d_status:0x%2x\n", i, reg);
 		if (init >= init_temp[i]) {
 			/* Forcibly enable temperature channel */
-			reg = pc87360_read_value(data, LD_TEMP, i,
-						 PC87365_REG_TEMP_STATUS);
  			if (!(reg & CHAN_ENA)) {
 				dev_dbg(&pdev->dev, "Forcibly "
 					"enabling temp%d\n", i+1);
@@ -1359,6 +1365,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 	if (data->innr) {
 		reg = pc87360_read_value(data, LD_IN, NO_BANK,
 					 PC87365_REG_IN_CONFIG);
+		dev_dbg(&pdev->dev, "bios vin-cfg:0x%02x\n", reg);
 		if (reg & CHAN_ENA) {
 			dev_dbg(&pdev->dev, "Forcibly "
 				"enabling monitoring (VLM)\n");
@@ -1371,6 +1378,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 	if (data->tempnr) {
 		reg = pc87360_read_value(data, LD_TEMP, NO_BANK,
 					 PC87365_REG_TEMP_CONFIG);
+		dev_dbg(&pdev->dev, "bios temp-cfg:0x%02x\n", reg);
 		if (reg & CHAN_ENA) {
 			dev_dbg(&pdev->dev, "Forcibly enabling "
 				"monitoring (TMS)\n");
-- 
1.5.5.1


--------------070102050707030509060907
Content-Type: text/x-patch;
 name="0006-fix-crap-that-snuck-thru.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0006-fix-crap-that-snuck-thru.patch"

From ed2924bede597092edeb59e085c526da1b5d7033 Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 19 Jun 2008 22:26:21 -0600
Subject: [PATCH] fix crap that snuck thru.


Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 6b61213..c02f8af 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -1293,7 +1293,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 	nr = data->innr < 11 ? data->innr : 11;
 	for (i = 0; i < nr; i++) {
 		reg = pc87360_read_value(data, LD_IN, i,
-					 PC87365_REG_IN_STATUS));
+					 PC87365_REG_IN_STATUS);
 		dev_dbg(&pdev->dev, "bios vin/temp %d status:0x%02x\n", i, reg);
 		if (init >= init_in[i]) {
 			/* Forcibly enable voltage channel */
-- 
1.5.5.1


--------------070102050707030509060907
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------070102050707030509060907--
