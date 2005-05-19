From: jthiessen@penguincomputing.com (Justin Thiessen)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: prog/chips.c patch for kernel 2.6.X lm85 driver
Message-Id: <20040809214314.GD26019@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Here is the associated prog/chips.c patch for the kernel 2.6.X lm85 driver

Justin Thiessen
-----------------
Linux Engineer
jthiessen@penguincomputing.com
http://www.penguincomputing.com

from

$diff -Naur


----------------------------------------



--- chips.c	2004-08-09 14:10:13.368639736 -0700
+++ chips.c.new	2004-08-09 14:10:29.162238744 -0700
@@ -1383,7 +1383,7 @@
   }
 
   if( is1027 ) {
-    if (!sensors_get_feature(*name,SENSORS_ADM1027_ALARM_MASK,&cur)) 
+    if (!sensors_get_feature(*name,SENSORS_ADM1027_ALARM_MASK_TEMP1,&cur)) 
       alarm_mask = cur + 0.5;
     else {
       printf("ERROR: Can't get alarm mask data!\n");
@@ -1604,8 +1604,8 @@
     printf("ERROR: Can't get TEMP3 data!\n");
   free_the_label(&label);
 
-  if (!sensors_get_label_and_valid(*name,SENSORS_LM85_PWM1,&label,&valid) &&
-      !sensors_get_feature(*name,SENSORS_LM85_PWM1,&cur)) {
+  if (!sensors_get_label_and_valid(*name,SENSORS_LM85_FAN1_PWM,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_LM85_FAN1_PWM,&cur)) {
     if (valid) {
       print_label(label,10);
       printf("%4.0f\n", cur);
@@ -1613,8 +1613,8 @@
   } else
     printf("ERROR: Can't get PWM1 data!\n");
   free_the_label(&label);
-  if (!sensors_get_label_and_valid(*name,SENSORS_LM85_PWM2,&label,&valid) &&
-      !sensors_get_feature(*name,SENSORS_LM85_PWM2,&cur)) {
+  if (!sensors_get_label_and_valid(*name,SENSORS_LM85_FAN2_PWM,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_LM85_FAN2_PWM,&cur)) {
     if (valid) {
       print_label(label,10);
       printf("%4.0f\n", cur);
@@ -1622,8 +1622,8 @@
   } else
     printf("ERROR: Can't get PWM2 data!\n");
   free_the_label(&label);
-  if (!sensors_get_label_and_valid(*name,SENSORS_LM85_PWM3,&label,&valid) &&
-      !sensors_get_feature(*name,SENSORS_LM85_PWM3,&cur)) {
+  if (!sensors_get_label_and_valid(*name,SENSORS_LM85_FAN3_PWM,&label,&valid) &&
+      !sensors_get_feature(*name,SENSORS_LM85_FAN3_PWM,&cur)) {
     if (valid) {
       print_label(label,10);
       printf("%4.0f\n", cur);

