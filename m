From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 29 Nov 2005 22:26:04 +0000
Subject: [lm-sensors] [PATCH] hwmon: w83792d fix unused fan pins
Message-Id: <20051129222714.0b53543e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECEB7B7A0@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECEB7B7A0@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

I know I'm a bit late but this one patch should preferably be merged in
before 2.6.15 is released.

Thanks.

* * * * *

Content-Disposition: inline; filename=hwmon-w83792d-fan-pins-fixes.patch

1. This patch add check for fan4,5,6,7 and do not create device file
   if their pins are not configured as fan.
2. Fix the issue that can not set fan divisor to 128.
3. Fix the index out of bounds bug in w83792d_detect function.

Signed-off-by: Yuan Mu <ymu@winbond.com.tw>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
 drivers/hwmon/w83792d.c |   25 ++++++++++++++++++-------
 1 files changed, 18 insertions(+), 7 deletions(-)

--- linux-2.6.15-rc2.orig/drivers/hwmon/w83792d.c	2005-11-29 12:17:50.000000000 +0100
+++ linux-2.6.15-rc2/drivers/hwmon/w83792d.c	2005-11-29 12:47:15.000000000 +0100
@@ -193,6 +193,7 @@
 	  0xE2 }	/* (bit3-0) SmartFanII: Fan3 Level 3 */
 };
 
+#define W83792D_REG_GPIO_EN		0x1A
 #define W83792D_REG_CONFIG		0x40
 #define W83792D_REG_VID_FANDIV		0x47
 #define W83792D_REG_CHIPID		0x49
@@ -257,7 +258,7 @@
 {
 	int i;
 	val = SENSORS_LIMIT(val, 1, 128) >> 1;
-	for (i = 0; i < 6; i++) {
+	for (i = 0; i < 7; i++) {
 		if (val = 0)
 			break;
 		val >>= 1;
@@ -1282,8 +1283,8 @@
 	w83792d_init_client(new_client);
 
 	/* A few vars need to be filled upon startup */
-	for (i = 1; i <= 7; i++) {
-		data->fan_min[i - 1] = w83792d_read_value(new_client,
+	for (i = 0; i < 7; i++) {
+		data->fan_min[i] = w83792d_read_value(new_client,
 					W83792D_REG_FAN_MIN[i]);
 	}
 
@@ -1306,10 +1307,20 @@
 	device_create_file_fan(new_client, 1);
 	device_create_file_fan(new_client, 2);
 	device_create_file_fan(new_client, 3);
-	device_create_file_fan(new_client, 4);
-	device_create_file_fan(new_client, 5);
-	device_create_file_fan(new_client, 6);
-	device_create_file_fan(new_client, 7);
+
+	/* Read GPIO enable register to check if pins for fan 4,5 are used as
+	   GPIO */
+	val1 = w83792d_read_value(new_client, W83792D_REG_GPIO_EN);
+	if (!(val1 & 0x40))
+		device_create_file_fan(new_client, 4);
+	if (!(val1 & 0x20))
+		device_create_file_fan(new_client, 5);
+
+	val1 = w83792d_read_value(new_client, W83792D_REG_PIN);
+	if (val1 & 0x40)
+		device_create_file_fan(new_client, 6);
+	if (val1 & 0x04)
+		device_create_file_fan(new_client, 7);
 
 	device_create_file_temp1(new_client);		/* Temp1 */
 	device_create_file_temp_add(new_client, 2);	/* Temp2 */



-- 
Jean Delvare
