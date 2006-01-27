From: telackey@bozemanpass.com (Thomas E Lackey)
Date: Fri, 27 Jan 2006 20:34:32 +0000
Subject: [lm-sensors] Proposed Patch for default sensors.conf
Message-Id: <43DA83D8.3060802@bozemanpass.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When working with lm_sensors and net-snmp lately, we found that the 
default sensors.conf file does not include "temp" in the labels for all 
chipset groups.  Specifically, there are two chipset groups where it is 
not in the label:

chip "lm85c-*" "adm1027-*" "adt7463-*" "lm85-*" "lm85b-*"
and
chip "adm1021-*" "adm1023-*" "max1617-*" "max1617a-*" "thmc10-*" 
"lm84-*" "gl523sm-*" "mc1066-*"

The reason for the patch is that the net-snmp lm_sensors extension uses 
the label name when determining what type of sensor it is reading, and 
as a result, which OID to use as the parent.  It uses "V" for volt, 
"fan" or "Fan" for fans, and "temp" or "Temp" for temperature.  All 
other sensors get placed under the "misc" sensors category.  Since these 
sensors lack "temp" in their labels, they are erroneously placed in the 
"misc" category.

Attached is a patch against CVS HEAD with the corrected names.

Regards,

-- 
Thomas E Lackey
Bozeman Pass, Inc.


Index: sensors.conf.eg
=================================RCS file: /home/cvs/lm_sensors2/etc/sensors.conf.eg,v
retrieving revision 1.179
diff -U3 -r1.179 sensors.conf.eg
--- sensors.conf.eg     7 Dec 2005 20:45:38 -0000       1.179
+++ sensors.conf.eg     27 Jan 2006 20:45:42 -0000
@@ -1802,8 +1802,8 @@

 chip "adm1021-*" "adm1023-*" "max1617-*" "max1617a-*" "thmc10-*" 
"lm84-*" "gl523sm-*" "mc1066-*"

-   label temp          "Board"
-   label remote_temp   "CPU"
+   label temp          "Board Temp"
+   label remote_temp   "CPU Temp"
 #   set temp_low               40
 #   set temp_over              70
 #   set remote_temp_low                40
@@ -2231,9 +2231,9 @@
    label in4   "V12"

 # Temperature inputs
-   label temp1  "CPU"
-   label temp2  "Board"
-   label temp3  "Remote"
+   label temp1  "CPU Temp"
+   label temp2  "Board Temp"
+   label temp3  "Remote Temp"

 # Fan inputs
    label fan1   "CPU_Fan"


