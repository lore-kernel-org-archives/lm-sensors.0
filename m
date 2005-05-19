From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: PATCH RFC fix adm1025 vid reporting
Message-Id: <sqnr31tknef38mtio55qgae5dkdaqg98nd@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6a3o319k8q774n0dgmj2q98u18rum7t2hs@4ax.com>
In-Reply-To: <6a3o319k8q774n0dgmj2q98u18rum7t2hs@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 20 Mar 2005 14:10:37 +0100, Jean Delvare <khali@linux-fr.org> wrote:

>Hi Grant,
>
>> Is this what you after?  Against latest CVS lm_sensors2, let me know
>> if  CVS wrong source, please.
>That's almost it, except that this breaks compatibility for the adm1025
>chip. Please leave "in1_ref" as the alternative sysfs file name (last
>member of the structure). If you don't, then people with an ADM1025 chip
>upgrading to lm_sensors 2.9.1 would also need to upgrade their kernel if
>they don't want to lose VID, which is no good.

Fussed about tab/space mix in this file?  Lot of noise for little gain?

Cheers,
Grant.

--- lm_sensors2/lib/chips.c	2005-03-16 09:16:05.000000000 +1100
+++ lm_sensors2x/lib/chips.c	2005-03-21 07:37:26.000000000 +1100
@@ -1939,7 +1939,7 @@
                          ADM9240_SYSCTL_TEMP, VALUE(1), 1, "temp1_max", 3 },
 
     { SENSORS_ADM9240_VID, "vid", NOMAP, NOMAP,
-                         R, ADM9240_SYSCTL_VID, VALUE(1), 2, "in1_ref", 3 },
+                         R, ADM9240_SYSCTL_VID, VALUE(1), 2, "cpu0_vid", 3 },
     { SENSORS_ADM9240_FAN1_DIV, "fan1_div", SENSORS_ADM9240_FAN1, 
                          NOMAP, RW, 
                          ADM9240_SYSCTL_FAN_DIV, VALUE(1), 0 },
@@ -2587,8 +2587,8 @@
     { SENSORS_ADM1025_TEMP2_HIGH, "temp2_high", SENSORS_ADM1025_TEMP2,
                          SENSORS_ADM1025_TEMP2, RW, 
                          ADM1025_SYSCTL_TEMP, VALUE(1), 1 },
-    { SENSORS_ADM1025_VID, "vid", NOMAP, NOMAP,
-                         R, ADM1025_SYSCTL_VID, VALUE(1), 3 , "in1_ref", 3 },
+    { SENSORS_ADM1025_VID, "vid", NOMAP, NOMAP, R, ADM1025_SYSCTL_VID, 
+			VALUE(1), 3 , "cpu0_vid", 3, "in1_ref" },
     { SENSORS_ADM1025_VRM, "vrm", NOMAP, NOMAP,
                          RW, ADM1025_SYSCTL_VRM, VALUE(1), 1 },
     { SENSORS_ADM1025_ALARMS, "alarms", NOMAP, NOMAP, 
