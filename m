From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Fix for tickets #1527 and #1528
Message-Id: <20040118091321.13620f07.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Could you please check that the attached patch, when applied to
lm_sensors 2.8.3, make it work with Linux 2.6.1's it87 driver?

Apply with "patch -p0". If if works, I'll commit that change to our CVS
repository and close ticket #1527.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/
-------------- next part --------------
Index: doc/chips/it87
=================================RCS file: /home/cvs/lm_sensors2/doc/chips/it87,v
retrieving revision 1.8
diff -u -r1.8 it87
--- doc/chips/it87	4 Jan 2004 17:11:58 -0000	1.8
+++ doc/chips/it87	18 Jan 2004 07:59:18 -0000
@@ -203,12 +203,12 @@
           temp1            NONE            NONE      R     1
           temp2            NONE            NONE      R     1
           temp3            NONE            NONE      R     1
-     temp_hyst1            temp            temp      RW    1
-     temp_over1            temp            temp      RW    1
-     temp_hyst2            temp            temp      RW    1
-     temp_over2            temp            temp      RW    1
-     temp_hyst3            temp            temp      RW    1
-     temp_over3            temp            temp      RW    1
+      temp1_low            temp            temp      RW    1
+     temp1_over            temp            temp      RW    1
+      temp2_low            temp            temp      RW    1
+     temp2_over            temp            temp      RW    1
+      temp3_low            temp            temp      RW    1
+     temp3_over            temp            temp      RW    1
             vid            NONE            NONE      R     2
        fan1_div            fan1            NONE      RW    0
        fan2_div            fan2            NONE      RW    0
@@ -248,15 +248,15 @@
        fan1_min                    SENSORS_IT87_FAN1_MIN            fan1:1
        fan2_min                    SENSORS_IT87_FAN2_MIN            fan2:1
        fan3_min                    SENSORS_IT87_FAN3_MIN            fan3:1
-          temp1                       SENSORS_IT87_TEMP1            temp1:3
-          temp2                       SENSORS_IT87_TEMP2            temp2:3
-          temp3                       SENSORS_IT87_TEMP3            temp3:3
-     temp1_hyst                  SENSORS_IT87_TEMP1_HYST            temp1:2
-     temp1_over                  SENSORS_IT87_TEMP1_OVER            temp1:1
-     temp2_hyst                  SENSORS_IT87_TEMP2_HYST            temp2:2
-     temp2_over                  SENSORS_IT87_TEMP2_OVER            temp2:1
-     temp3_hyst                  SENSORS_IT87_TEMP3_HYST            temp3:2
-     temp3_over                  SENSORS_IT87_TEMP3_OVER            temp3:1
+          temp1                       SENSORS_IT87_TEMP1           temp1:3
+          temp2                       SENSORS_IT87_TEMP2           temp2:3
+          temp3                       SENSORS_IT87_TEMP3           temp3:3
+      temp1_low                   SENSORS_IT87_TEMP1_LOW           temp1:2
+     temp1_over                  SENSORS_IT87_TEMP1_HIGH           temp1:1
+      temp2_low                   SENSORS_IT87_TEMP2_LOW           temp2:2
+     temp2_over                  SENSORS_IT87_TEMP2_HIGH           temp2:1
+      temp3_low                   SENSORS_IT87_TEMP3_LOW           temp3:2
+     temp3_over                  SENSORS_IT87_TEMP3_HIGH           temp3:1
             vid                         SENSORS_IT87_VID             vid:1
        fan1_div                    SENSORS_IT87_FAN1_DIV         fan_div:1
        fan2_div                    SENSORS_IT87_FAN2_DIV         fan_div:2
Index: etc/sensors.conf.eg
=================================RCS file: /home/cvs/lm_sensors2/etc/sensors.conf.eg,v
retrieving revision 1.105
diff -u -r1.105 sensors.conf.eg
--- etc/sensors.conf.eg	9 Jan 2004 21:35:27 -0000	1.105
+++ etc/sensors.conf.eg	18 Jan 2004 07:59:19 -0000
@@ -1411,14 +1411,14 @@
 
     label temp1       "M/B Temp"
     set   temp1_over  40
-    set   temp1_hyst  20
+    set   temp1_low   15
     label temp2       "CPU Temp"
     set   temp2_over  45
-    set   temp2_hyst  25
+    set   temp2_low   15
 #   ignore temp3
     label temp3       "Temp3"
     set   temp3_over  45
-    set   temp3_hyst  25
+    set   temp3_low   15
 
 # The A7V8X-X has temperatures inverted, and needs a conversion for
 # CPU temp. Thanks to Preben Randhol for the formula.
Index: lib/chips.c
=================================RCS file: /home/cvs/lm_sensors2/lib/chips.c,v
retrieving revision 1.111
diff -u -r1.111 chips.c
--- lib/chips.c	9 Jan 2004 21:26:54 -0000	1.111
+++ lib/chips.c	18 Jan 2004 07:59:21 -0000
@@ -3757,13 +3757,13 @@
                          R, IT87_SYSCTL_TEMP2, VALUE(3), 1 },
     { SENSORS_IT87_TEMP3, "temp3", NOMAP, NOMAP,
                          R, IT87_SYSCTL_TEMP3, VALUE(3), 1 },
-    { SENSORS_IT87_TEMP1_LOW, "temp1_hyst", SENSORS_IT87_TEMP1,
+    { SENSORS_IT87_TEMP1_LOW, "temp1_low", SENSORS_IT87_TEMP1,
                               SENSORS_IT87_TEMP1, RW,
                               IT87_SYSCTL_TEMP1, VALUE(2), 1 },
-    { SENSORS_IT87_TEMP2_LOW, "temp2_hyst", SENSORS_IT87_TEMP2,
+    { SENSORS_IT87_TEMP2_LOW, "temp2_low", SENSORS_IT87_TEMP2,
                               SENSORS_IT87_TEMP2, RW,
                               IT87_SYSCTL_TEMP2, VALUE(2), 1 },
-    { SENSORS_IT87_TEMP3_LOW, "temp3_hyst", SENSORS_IT87_TEMP3,
+    { SENSORS_IT87_TEMP3_LOW, "temp3_low", SENSORS_IT87_TEMP3,
                               SENSORS_IT87_TEMP3, RW,
                               IT87_SYSCTL_TEMP3, VALUE(2), 1 },
     { SENSORS_IT87_TEMP1_HIGH, "temp1_over", SENSORS_IT87_TEMP1,
