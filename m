From: jchapman@katalix.com (James Chapman)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH: 2.6.11-rc5] i2c chips: add adt7461 support to lm90 driver
Message-Id: <4227764D.9090701@katalix.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4223513F.4030403@katalix.com>
In-Reply-To: <4223513F.4030403@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Attached is a new version of the adt7461 sensors patch, as requested.

Jean Delvare wrote:

>>Patch to add adt7461 support to lmsensors-2.9.0 is attached. I'm new
>>to the internals of lmsensors so I may not have done all I need to.
> 
> Patch is good but incomplete. You'd need to also "add support" in
> prog/sensors/main.c and etc/sensors.conf.eg. Please provide a new patch
> that does everything or a diffenet patch for me to apply additionally to
> this one.
-------------- next part --------------
Add adt7461 temp sensor support as an lm90-compatible device.
Requires lm90 kernel driver changes archived at
http://archives.andrew.net.au/lm-sensors/msg29763.html

Index: lm_sensors-2.9.0/prog/detect/sensors-detect
=================================--- lm_sensors-2.9.0.orig/prog/detect/sensors-detect	2004-12-10 20:10:09.000000000 +0000
+++ lm_sensors-2.9.0/prog/detect/sensors-detect	2005-03-03 16:46:08.000000000 +0000
@@ -1293,7 +1293,7 @@
      },
      {
        name => "Analog Devices ADT7461",
-       driver => "to-be-written",
+       driver => "lm90",
        i2c_addrs => [0x4c],
        i2c_detect => sub { lm90_detect 5, @_ },
      },
Index: lm_sensors-2.9.0/lib/chips.c
=================================--- lm_sensors-2.9.0.orig/lib/chips.c	2004-11-24 04:31:40.000000000 +0000
+++ lm_sensors-2.9.0/lib/chips.c	2005-03-03 16:51:41.000000000 +0000
@@ -5350,6 +5350,7 @@
  { SENSORS_LM99_PREFIX, lm90_features },
  { SENSORS_LM86_PREFIX, lm90_features },
  { SENSORS_MAX6657_PREFIX, lm90_features },
+ { SENSORS_ADT7461_PREFIX, lm90_features },
  { SENSORS_LM63_PREFIX, lm63_features },
  { SENSORS_MAX1619_PREFIX, max1619_features },
  { SENSORS_XEONTEMP_PREFIX, xeontemp_features },
Index: lm_sensors-2.9.0/lib/chips.h
=================================--- lm_sensors-2.9.0.orig/lib/chips.h	2004-11-24 04:31:40.000000000 +0000
+++ lm_sensors-2.9.0/lib/chips.h	2005-03-03 16:50:42.000000000 +0000
@@ -475,13 +475,14 @@
 #define SENSORS_LM85_ZONE3_RANGE           100  /* RW -- zone3_range  */
 #define SENSORS_LM85_ZONE3_SMOOTH          101  /* RW -- zone3_smooth  */
 
-/* LM86/LM89/LM90/LM99/ADM1032/MAX6657 chips */
+/* LM86/LM89/LM90/LM99/ADM1032/MAX6657/ADT7461 chips */
 
 #define SENSORS_LM90_PREFIX "lm90"
 #define SENSORS_ADM1032_PREFIX "adm1032"
 #define SENSORS_LM99_PREFIX "lm99"
 #define SENSORS_LM86_PREFIX "lm86"
 #define SENSORS_MAX6657_PREFIX "max6657"
+#define SENSORS_ADT7461_PREFIX "adt7461"
 
 #define SENSORS_LM90_LOCAL_TEMP 51 /* R */
 #define SENSORS_LM90_LOCAL_HIGH 52 /* RW */
Index: lm_sensors-2.9.0/prog/sensors/main.c
=================================--- lm_sensors-2.9.0.orig/prog/sensors/main.c	2004-11-24 04:31:40.000000000 +0000
+++ lm_sensors-2.9.0/prog/sensors/main.c	2005-03-03 20:32:25.000000000 +0000
@@ -392,6 +392,7 @@
 	{ "lm99", print_lm90 },
 	{ "lm86", print_lm90 },
 	{ "max6657", print_lm90 },
+	{ "adt7461", print_lm90 },
 	{ "lm63", print_lm63 },
 	{ "xeontemp", print_xeontemp },
 	{ "max6650", print_max6650 },
Index: lm_sensors-2.9.0/etc/sensors.conf.eg
=================================--- lm_sensors-2.9.0.orig/etc/sensors.conf.eg	2004-11-25 19:40:09.000000000 +0000
+++ lm_sensors-2.9.0/etc/sensors.conf.eg	2005-03-03 20:31:43.000000000 +0000
@@ -1750,7 +1750,7 @@
    set temp2_hyst  40
 
 
-chip "lm90-*" "adm1032-*" "lm86-*" "max6657-*"
+chip "lm90-*" "adm1032-*" "lm86-*" "max6657-*" "adt7461-*"
 
    label temp1 "M/B Temp"
    label temp2 "CPU Temp"
