From: Jim Cromie <jim.cromie@gmail.com>
Date: Sun, 29 Jun 2008 18:01:55 +0000
Subject: [lm-sensors] [patch 1/6 v2] hwmon/pc87360 individual alarm files -
Message-Id: <4867CE13.1000902@gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------030707090608020000010309"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------030707090608020000010309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


attaching for easy apply,
pasting for easy review.

Ive patched these new constants into 2 places - where theyll be used.
It occurred to me (post fact) that maybe this isnt desirable.
If thats the case, please also indicate if a final fix-up patch is OK,
Id prefer not to have to try to insert a fix at the beginning of  the 
patchset


[jimc@harpo linux-2.6]$ more 
0001-hwmon-pc87360-separate-alarm-files-define-some-con.patch
 From 5a3af0b603842baede88dd66c32e737b7bf9d2e7 Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 28 Jun 2008 11:59:19 -0600
Subject: [PATCH] hwmon/pc87360 separate alarm files - define some constants

2 different kinds of constants added:
- CHAN_ALM_* constants for (later) vin, temp alarm callbacks.
- CHAN_* conversion constants, used in _init_device, partly for RW1C bits

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 9b462bb..1043b11 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -489,6 +489,11 @@ static struct sensor_device_attribute in_max[] = {
     SENSOR_ATTR(in10_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 10),
 };
 
+/* (temp & vin) channel status register alarm bits (pdf sec.11.5.12) */
+#define CHAN_ALM_MIN    0x02    /* min limit crossed */
+#define CHAN_ALM_MAX    0x04    /* max limit exceeded */
+#define TEMP_ALM_CRIT    0x08    /* temp crit exceeded (temp only) */
+
 #define VIN_UNIT_ATTRS(X) \
     &in_input[X].dev_attr.attr,    \
     &in_status[X].dev_attr.attr,    \
@@ -1131,6 +1136,12 @@ static void pc87360_write_value(struct 
pc87360_data *data, u8 ldi, u8 bank,
     mutex_unlock(&(data->lock));
 }
 
+/* (temp & vin) channel conversion status register flags (pdf 
sec.11.5.12) */
+#define CHAN_CNVRTD    0x80    /* new data ready */
+#define CHAN_ENA    0x01    /* enabled channel (temp or vin) */
+#define CHAN_ALM_ENA    0x10    /* propagate to alarms-reg ?? (chk val!) */
+#define CHAN_READY    (CHAN_ENA|CHAN_CNVRTD) /* sample ready mask */
+
 static void pc87360_init_device(struct platform_device *pdev,
                 int use_thermistors)
 {
@@ -1156,7 +1167,7 @@ static void pc87360_init_device(struct 
platform_device *pdev,
             /* Forcibly enable voltage channel */
             reg = pc87360_read_value(data, LD_IN, i,
                          PC87365_REG_IN_STATUS);
-            if (!(reg & 0x01)) {
+            if (!(reg & CHAN_ENA)) {
                 dev_dbg(&pdev->dev, "Forcibly "
                     "enabling in%d\n", i);
                 pc87360_write_value(data, LD_IN, i,
@@ -1171,7 +1182,7 @@ static void pc87360_init_device(struct 
platform_device *pdev,
     for (i = 11; i < data->innr; i++) {
         reg = pc87360_read_value(data, LD_IN, i,
                      PC87365_REG_TEMP_STATUS);
-        use_thermistors = use_thermistors || (reg & 0x01);
+        use_thermistors = use_thermistors || (reg & CHAN_ENA);
     }
 
     i = use_thermistors ? 2 : 0;
@@ -1180,7 +1191,7 @@ static void pc87360_init_device(struct 
platform_device *pdev,
             /* Forcibly enable temperature channel */
             reg = pc87360_read_value(data, LD_TEMP, i,
                          PC87365_REG_TEMP_STATUS);
-            if (!(reg & 0x01)) {
+            if (!(reg & CHAN_ENA)) {
                 dev_dbg(&pdev->dev, "Forcibly "
                     "enabling temp%d\n", i+1);
                 pc87360_write_value(data, LD_TEMP, i,
@@ -1197,7 +1208,7 @@ static void pc87360_init_device(struct 
platform_device *pdev,
                    diodes */
                 reg = pc87360_read_value(data, LD_TEMP,
                       (i-11)/2, PC87365_REG_TEMP_STATUS);
-                if (reg & 0x01) {
+                if (reg & CHAN_ENA) {
                     dev_dbg(&pdev->dev, "Skipping "
                         "temp%d, pin already in use "
                         "by temp%d\n", i-7, (i-11)/2);
@@ -1207,7 +1218,7 @@ static void pc87360_init_device(struct 
platform_device *pdev,
                 /* Forcibly enable thermistor channel */
                 reg = pc87360_read_value(data, LD_IN, i,
                              PC87365_REG_IN_STATUS);
-                if (!(reg & 0x01)) {
+                if (!(reg & CHAN_ENA)) {
                     dev_dbg(&pdev->dev, "Forcibly "
                         "enabling temp%d\n", i-7);
                     pc87360_write_value(data, LD_IN, i,
@@ -1221,7 +1232,7 @@ static void pc87360_init_device(struct 
platform_device *pdev,
     if (data->innr) {
         reg = pc87360_read_value(data, LD_IN, NO_BANK,
                      PC87365_REG_IN_CONFIG);
-        if (reg & 0x01) {
+        if (reg & CHAN_ENA) {
             dev_dbg(&pdev->dev, "Forcibly "
                 "enabling monitoring (VLM)\n");
             pc87360_write_value(data, LD_IN, NO_BANK,
@@ -1233,7 +1244,7 @@ static void pc87360_init_device(struct 
platform_device *pdev,
     if (data->tempnr) {
         reg = pc87360_read_value(data, LD_TEMP, NO_BANK,
                      PC87365_REG_TEMP_CONFIG);
-        if (reg & 0x01) {
+        if (reg & CHAN_ENA) {
             dev_dbg(&pdev->dev, "Forcibly enabling "
                 "monitoring (TMS)\n");
             pc87360_write_value(data, LD_TEMP, NO_BANK,
@@ -1336,11 +1347,11 @@ static struct pc87360_data 
*pc87360_update_device(struct device *dev)
             pc87360_write_value(data, LD_IN, i,
                         PC87365_REG_IN_STATUS,
                         data->in_status[i]);
-            if ((data->in_status[i] & 0x81) == 0x81) {
+            if ((data->in_status[i] & CHAN_READY) == CHAN_READY) {
                 data->in[i] = pc87360_read_value(data, LD_IN,
                           i, PC87365_REG_IN);
             }
-            if (data->in_status[i] & 0x01) {
+            if (data->in_status[i] & CHAN_ENA) {
                 data->in_min[i] = pc87360_read_value(data,
                           LD_IN, i,
                           PC87365_REG_IN_MIN);
@@ -1373,12 +1384,12 @@ static struct pc87360_data 
*pc87360_update_device(struct device *dev)
             pc87360_write_value(data, LD_TEMP, i,
                         PC87365_REG_TEMP_STATUS,
                         data->temp_status[i]);
-            if ((data->temp_status[i] & 0x81) == 0x81) {
+            if ((data->temp_status[i] & CHAN_READY) == CHAN_READY) {
                 data->temp[i] = pc87360_read_value(data,
                         LD_TEMP, i,
                         PC87365_REG_TEMP);
             }
-            if (data->temp_status[i] & 0x01) {
+            if (data->temp_status[i] & CHAN_ENA) {
                 data->temp_min[i] = pc87360_read_value(data,
                             LD_TEMP, i,
                             PC87365_REG_TEMP_MIN);
-- 
1.5.5.1


--------------030707090608020000010309
Content-Type: text/x-patch;
	name="0001-hwmon-pc87360-separate-alarm-files-define-some-con.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
	filename*0="0001-hwmon-pc87360-separate-alarm-files-define-some-con.patc";
	filename*1="h"

From 5a3af0b603842baede88dd66c32e737b7bf9d2e7 Mon Sep 17 00:00:00 2001
From: Jim Cromie <jim.cromie@gmail.com>
Date: Sat, 28 Jun 2008 11:59:19 -0600
Subject: [PATCH] hwmon/pc87360 separate alarm files - define some constants

2 different kinds of constants added:
- CHAN_ALM_* constants for (later) vin, temp alarm callbacks.
- CHAN_* conversion constants, used in _init_device, partly for RW1C bits

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/hwmon/pc87360.c |   33 ++++++++++++++++++++++-----------
 1 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/hwmon/pc87360.c b/drivers/hwmon/pc87360.c
index 9b462bb..1043b11 100644
--- a/drivers/hwmon/pc87360.c
+++ b/drivers/hwmon/pc87360.c
@@ -489,6 +489,11 @@ static struct sensor_device_attribute in_max[] = {
 	SENSOR_ATTR(in10_max, S_IWUSR | S_IRUGO, show_in_max, set_in_max, 10),
 };
 
+/* (temp & vin) channel status register alarm bits (pdf sec.11.5.12) */
+#define CHAN_ALM_MIN	0x02	/* min limit crossed */
+#define CHAN_ALM_MAX	0x04	/* max limit exceeded */
+#define TEMP_ALM_CRIT	0x08	/* temp crit exceeded (temp only) */
+
 #define VIN_UNIT_ATTRS(X) \
 	&in_input[X].dev_attr.attr,	\
 	&in_status[X].dev_attr.attr,	\
@@ -1131,6 +1136,12 @@ static void pc87360_write_value(struct pc87360_data *data, u8 ldi, u8 bank,
 	mutex_unlock(&(data->lock));
 }
 
+/* (temp & vin) channel conversion status register flags (pdf sec.11.5.12) */
+#define CHAN_CNVRTD	0x80	/* new data ready */
+#define CHAN_ENA	0x01	/* enabled channel (temp or vin) */
+#define CHAN_ALM_ENA	0x10	/* propagate to alarms-reg ?? (chk val!) */
+#define CHAN_READY	(CHAN_ENA|CHAN_CNVRTD) /* sample ready mask */
+
 static void pc87360_init_device(struct platform_device *pdev,
 				int use_thermistors)
 {
@@ -1156,7 +1167,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 			/* Forcibly enable voltage channel */
 			reg = pc87360_read_value(data, LD_IN, i,
 						 PC87365_REG_IN_STATUS);
-			if (!(reg & 0x01)) {
+			if (!(reg & CHAN_ENA)) {
 				dev_dbg(&pdev->dev, "Forcibly "
 					"enabling in%d\n", i);
 				pc87360_write_value(data, LD_IN, i,
@@ -1171,7 +1182,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 	for (i = 11; i < data->innr; i++) {
 		reg = pc87360_read_value(data, LD_IN, i,
 					 PC87365_REG_TEMP_STATUS);
-		use_thermistors = use_thermistors || (reg & 0x01);
+		use_thermistors = use_thermistors || (reg & CHAN_ENA);
 	}
 
 	i = use_thermistors ? 2 : 0;
@@ -1180,7 +1191,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 			/* Forcibly enable temperature channel */
 			reg = pc87360_read_value(data, LD_TEMP, i,
 						 PC87365_REG_TEMP_STATUS);
-			if (!(reg & 0x01)) {
+			if (!(reg & CHAN_ENA)) {
 				dev_dbg(&pdev->dev, "Forcibly "
 					"enabling temp%d\n", i+1);
 				pc87360_write_value(data, LD_TEMP, i,
@@ -1197,7 +1208,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 				   diodes */
 				reg = pc87360_read_value(data, LD_TEMP,
 				      (i-11)/2, PC87365_REG_TEMP_STATUS);
-				if (reg & 0x01) {
+				if (reg & CHAN_ENA) {
 					dev_dbg(&pdev->dev, "Skipping "
 						"temp%d, pin already in use "
 						"by temp%d\n", i-7, (i-11)/2);
@@ -1207,7 +1218,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 				/* Forcibly enable thermistor channel */
 				reg = pc87360_read_value(data, LD_IN, i,
 							 PC87365_REG_IN_STATUS);
-				if (!(reg & 0x01)) {
+				if (!(reg & CHAN_ENA)) {
 					dev_dbg(&pdev->dev, "Forcibly "
 						"enabling temp%d\n", i-7);
 					pc87360_write_value(data, LD_IN, i,
@@ -1221,7 +1232,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 	if (data->innr) {
 		reg = pc87360_read_value(data, LD_IN, NO_BANK,
 					 PC87365_REG_IN_CONFIG);
-		if (reg & 0x01) {
+		if (reg & CHAN_ENA) {
 			dev_dbg(&pdev->dev, "Forcibly "
 				"enabling monitoring (VLM)\n");
 			pc87360_write_value(data, LD_IN, NO_BANK,
@@ -1233,7 +1244,7 @@ static void pc87360_init_device(struct platform_device *pdev,
 	if (data->tempnr) {
 		reg = pc87360_read_value(data, LD_TEMP, NO_BANK,
 					 PC87365_REG_TEMP_CONFIG);
-		if (reg & 0x01) {
+		if (reg & CHAN_ENA) {
 			dev_dbg(&pdev->dev, "Forcibly enabling "
 				"monitoring (TMS)\n");
 			pc87360_write_value(data, LD_TEMP, NO_BANK,
@@ -1336,11 +1347,11 @@ static struct pc87360_data *pc87360_update_device(struct device *dev)
 			pc87360_write_value(data, LD_IN, i,
 					    PC87365_REG_IN_STATUS,
 					    data->in_status[i]);
-			if ((data->in_status[i] & 0x81) == 0x81) {
+			if ((data->in_status[i] & CHAN_READY) == CHAN_READY) {
 				data->in[i] = pc87360_read_value(data, LD_IN,
 					      i, PC87365_REG_IN);
 			}
-			if (data->in_status[i] & 0x01) {
+			if (data->in_status[i] & CHAN_ENA) {
 				data->in_min[i] = pc87360_read_value(data,
 						  LD_IN, i,
 						  PC87365_REG_IN_MIN);
@@ -1373,12 +1384,12 @@ static struct pc87360_data *pc87360_update_device(struct device *dev)
 			pc87360_write_value(data, LD_TEMP, i,
 					    PC87365_REG_TEMP_STATUS,
 					    data->temp_status[i]);
-			if ((data->temp_status[i] & 0x81) == 0x81) {
+			if ((data->temp_status[i] & CHAN_READY) == CHAN_READY) {
 				data->temp[i] = pc87360_read_value(data,
 						LD_TEMP, i,
 						PC87365_REG_TEMP);
 			}
-			if (data->temp_status[i] & 0x01) {
+			if (data->temp_status[i] & CHAN_ENA) {
 				data->temp_min[i] = pc87360_read_value(data,
 						    LD_TEMP, i,
 						    PC87365_REG_TEMP_MIN);
-- 
1.5.5.1


--------------030707090608020000010309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------030707090608020000010309--
