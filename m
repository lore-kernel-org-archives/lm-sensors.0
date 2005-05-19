From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <40228EDC.5010000@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>>>1* Clean up sensors code so that it doesn't reference fan_min. For
>>>>one thing, it'll let us get rid of the errors you had when running
>>>>"sensors". (...)
>>
>>I'll do this, as mentioned above.
> 
> Done and commited to CVS. Please checkout and test. Output with 2.4
> driver should be unchanged, and output with 2.6 driver should now be
> fine now.

Yes, thank you very much for fixing it.

Attached, you'll find some minor changes, because it's bit 2 that signals a 
fan fault, and the fan labels where assigned in the wrong order.

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
-------------- next part --------------
--- ./etc/sensors.conf.eg.orig	2004-02-05 17:53:05.000000000 +0100
+++ ./etc/sensors.conf.eg	2004-02-05 18:57:04.640782410 +0100
@@ -1586,9 +1586,9 @@
     label temp3       "Temp3/AUX"
 
 # Fans
-    label fan1        "Fan1/CPU"
-    label fan2        "Fan2/AUX"
-    label fan3        "Fan3/PS"
+    label fan1        "Fan1/PS"
+    label fan2        "Fan2/CPU"
+    label fan3        "Fan3/AUX"
 
 # Voltage
     label in0         "+12V"
-------------- next part --------------
--- ./prog/sensors/chips.c.orig	2004-02-05 17:54:04.000000000 +0100
+++ ./prog/sensors/chips.c	2004-02-05 18:44:18.197884435 +0100
@@ -3243,7 +3243,7 @@
       !sensors_get_feature(*name,SENSORS_FSCPOS_FAN1_STATE,&state)) { 
     if (valid) {
       print_label(label,10);
-	if((int) state & 0x02)
+	if((int) state & 0x04)
 	  printf("\tfaulty\n");
 	else
 	  printf("\t%6.0f RPM \n",fan);
@@ -3257,7 +3257,7 @@
       !sensors_get_feature(*name,SENSORS_FSCPOS_FAN2_STATE,&state)) { 
     if (valid) {
       print_label(label,10);
-	if((int) state & 0x02)
+	if((int) state & 0x04)
 	  printf("\tfaulty\n");
 	else
 	  printf("\t%6.0f RPM \n",fan);
@@ -3271,7 +3271,7 @@
       !sensors_get_feature(*name,SENSORS_FSCPOS_FAN3_STATE,&state)) { 
     if (valid) {
       print_label(label,10);
-	if((int) state & 0x02)
+	if((int) state & 0x04)
 	  printf("\tfaulty\n");
 	else
 	  printf("\t%6.0f RPM \n",fan);
@@ -3557,7 +3557,7 @@
       && !sensors_get_feature(*name,SENSORS_FSCHER_FAN1_STATE,&state)) { 
     if (valid) {
       print_label(label,10);
-      if((int) state & 0x02)
+      if((int) state & 0x04)
         printf("\tfaulty\n");
       else
         printf("\t%6.0f RPM \n",fan);
@@ -3571,7 +3571,7 @@
       && !sensors_get_feature(*name,SENSORS_FSCHER_FAN2_STATE,&state)) { 
     if (valid) {
       print_label(label,10);
-      if((int) state & 0x02)
+      if((int) state & 0x04)
         printf("\tfaulty\n");
       else
         printf("\t%6.0f RPM \n",fan);
@@ -3585,7 +3585,7 @@
       && !sensors_get_feature(*name,SENSORS_FSCHER_FAN3_STATE,&state)) { 
     if (valid) {
       print_label(label,10);
-      if((int) state & 0x02)
+      if((int) state & 0x04)
         printf("\tfaulty\n");
       else
         printf("\t%6.0f RPM \n",fan);
