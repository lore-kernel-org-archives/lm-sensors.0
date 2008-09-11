From: Jim Cromie <jim.cromie@gmail.com>
Date: Thu, 11 Sep 2008 04:44:41 +0000
Subject: [lm-sensors] [ patch 2.6.27-rc6 5/6 v2] separate alarm sysfs files
Message-Id: <48C8A239.8060209@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030804010203080505060605"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030804010203080505060605
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

[jimc@harpo ts-t4d]$ more 
0005-hwmon-pc87360-separate-alarm-files-add-dev_dbg-hel.patch
 From d8f9a3ff6f972b32197c98d71cf8eaadf133f763 Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 28 Jun 2008 20:42:24 -0600
Subject: [PATCH] hwmon/pc87360 separate alarm files - add dev_dbg help

temp and vin status register values may be set by chip specifications,
set again by bios, or by this previously loaded driver.
Debug output nicely displays modprobe init=\d actions.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index ac9dcca..acff04f 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -1294,10 +1294,11 @@ static void pc87360_init_device(struct 
platform_device *pdev,
 
     nr = data->innr < 11 ? data->innr : 11;
     for (i = 0; i < nr; i++) {
+        reg = pc87360_read_value(data, LD_IN, i,
+                     PC87365_REG_IN_STATUS);
+        dev_dbg(&pdev->dev, "bios in%d status:0x%02x\n", i, reg);
         if (init >= init_in[i]) {
             /* Forcibly enable voltage channel */
-            reg = pc87360_read_value(data, LD_IN, i,
-                         PC87365_REG_IN_STATUS);
             if (!(reg & CHAN_ENA)) {
                 dev_dbg(&pdev->dev, "Forcibly "
                     "enabling in%d\n", i);
@@ -1310,18 +1311,23 @@ static void pc87360_init_device(struct 
platform_device *pdev,
 
     /* We can't blindly trust the Super-I/O space configuration bit,
        most BIOS won't set it properly */
+    dev_dbg(&pdev->dev, "bios thermistors:%d\n", use_thermistors);
     for (i = 11; i < data->innr; i++) {
         reg = pc87360_read_value(data, LD_IN, i,
                      PC87365_REG_TEMP_STATUS);
         use_thermistors = use_thermistors || (reg & CHAN_ENA);
+        /* thermistors are temp[4-6], measured on vin[11-14] */
+        dev_dbg(&pdev->dev, "bios temp%d_status:0x%02x\n", i-7, reg);
     }
+    dev_dbg(&pdev->dev, "using thermistors:%d\n", use_thermistors);
 
     i = use_thermistors ? 2 : 0;
     for (; i < data->tempnr; i++) {
+        reg = pc87360_read_value(data, LD_TEMP, i,
+                     PC87365_REG_TEMP_STATUS);
+        dev_dbg(&pdev->dev, "bios temp%d_status:0x%02x\n", i+1, reg);
         if (init >= init_temp[i]) {
             /* Forcibly enable temperature channel */
-            reg = pc87360_read_value(data, LD_TEMP, i,
-                         PC87365_REG_TEMP_STATUS);
             if (!(reg & CHAN_ENA)) {
                 dev_dbg(&pdev->dev, "Forcibly "
                     "enabling temp%d\n", i+1);
@@ -1363,6 +1369,7 @@ static void pc87360_init_device(struct 
platform_device *pdev,
     if (data->innr) {
         reg = pc87360_read_value(data, LD_IN, NO_BANK,
                      PC87365_REG_IN_CONFIG);
+        dev_dbg(&pdev->dev, "bios vin-cfg:0x%02x\n", reg);
         if (reg & CHAN_ENA) {
             dev_dbg(&pdev->dev, "Forcibly "
                 "enabling monitoring (VLM)\n");
@@ -1375,6 +1382,7 @@ static void pc87360_init_device(struct 
platform_device *pdev,
     if (data->tempnr) {
         reg = pc87360_read_value(data, LD_TEMP, NO_BANK,
                      PC87365_REG_TEMP_CONFIG);
+        dev_dbg(&pdev->dev, "bios temp-cfg:0x%02x\n", reg);
         if (reg & CHAN_ENA) {
             dev_dbg(&pdev->dev, "Forcibly enabling "
                 "monitoring (TMS)\n");
-- 
1.5.5.1



--------------030804010203080505060605
Content-Type: text/x-patch;
	name="0005-hwmon-pc87360-separate-alarm-files-add-dev_dbg-hel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0005-hwmon-pc87360-separate-alarm-files-add-dev_dbg-hel.patc";
	filename*1="h"

From d8f9a3ff6f972b32197c98d71cf8eaadf133f763 Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 28 Jun 2008 20:42:24 -0600
Subject: [PATCH] hwmon/pc87360 separate alarm files - add dev_dbg help

temp and vin status register values may be set by chip specifications,
set again by bios, or by this previously loaded driver.
Debug output nicely displays modprobe init=\d actions.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |   16 ++++++++++++----
 1 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index ac9dcca..acff04f 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -1294,10 +1294,11 @@ static void pc87360_init_device(struct platform_device *pdev,
 
 	nr = data->innr < 11 ? data->innr : 11;
 	for (i = 0; i < nr; i++) {
+		reg = pc87360_read_value(data, LD_IN, i,
+					 PC87365_REG_IN_STATUS);
+		dev_dbg(&pdev->dev, "bios in%d status:0x%02x\n", i, reg);
 		if (init >= init_in[i]) {
 			/* Forcibly enable voltage channel */
-			reg = pc87360_read_value(data, LD_IN, i,
-						 PC87365_REG_IN_STATUS);
 			if (!(reg & CHAN_ENA)) {
 				dev_dbg(&pdev->dev, "Forcibly "
 					"enabling in%d\n", i);
@@ -1310,18 +1311,23 @@ static void pc87360_init_device(struct platform_device *pdev,
 
 	/* We can't blindly trust the Super-I/O space configuration bit,
 	   most BIOS won't set it properly */
+	dev_dbg(&pdev->dev, "bios thermistors:%d\n", use_thermistors);
 	for (i = 11; i < data->innr; i++) {
 		reg = pc87360_read_value(data, LD_IN, i,
 					 PC87365_REG_TEMP_STATUS);
 		use_thermistors = use_thermistors || (reg & CHAN_ENA);
+		/* thermistors are temp[4-6], measured on vin[11-14] */
+		dev_dbg(&pdev->dev, "bios temp%d_status:0x%02x\n", i-7, reg);
 	}
+	dev_dbg(&pdev->dev, "using thermistors:%d\n", use_thermistors);
 
 	i = use_thermistors ? 2 : 0;
 	for (; i < data->tempnr; i++) {
+		reg = pc87360_read_value(data, LD_TEMP, i,
+					 PC87365_REG_TEMP_STATUS);
+		dev_dbg(&pdev->dev, "bios temp%d_status:0x%02x\n", i+1, reg);
 		if (init >= init_temp[i]) {
 			/* Forcibly enable temperature channel */
-			reg = pc87360_read_value(data, LD_TEMP, i,
-						 PC87365_REG_TEMP_STATUS);
 			if (!(reg & CHAN_ENA)) {
 				dev_dbg(&pdev->dev, "Forcibly "
 					"enabling temp%d\n", i+1);
@@ -1363,6 +1369,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 	if (data->innr) {
 		reg = pc87360_read_value(data, LD_IN, NO_BANK,
 					 PC87365_REG_IN_CONFIG);
+		dev_dbg(&pdev->dev, "bios vin-cfg:0x%02x\n", reg);
 		if (reg & CHAN_ENA) {
 			dev_dbg(&pdev->dev, "Forcibly "
 				"enabling monitoring (VLM)\n");
@@ -1375,6 +1382,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 	if (data->tempnr) {
 		reg = pc87360_read_value(data, LD_TEMP, NO_BANK,
 					 PC87365_REG_TEMP_CONFIG);
+		dev_dbg(&pdev->dev, "bios temp-cfg:0x%02x\n", reg);
 		if (reg & CHAN_ENA) {
 			dev_dbg(&pdev->dev, "Forcibly enabling "
 				"monitoring (TMS)\n");
-- 
1.5.5.1


--------------030804010203080505060605
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030804010203080505060605--
