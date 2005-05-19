From: jchapman@katalix.com (James Chapman)
Date: Thu, 19 May 2005 06:25:41 +0000
Subject: [PATCH: 2.6.11-rc5] i2c chips: add adt7461 support to lm90 driver
Message-Id: <422744A0.8020506@katalix.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4223513F.4030403@katalix.com>
In-Reply-To: <4223513F.4030403@katalix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

Jean Delvare wrote:

>>>Add ADT7461 (temperature sensor) support to LM90 driver.

Thanks for your good comments. I'll post a revised kernel patch soon.

ADT7461 will only be supported in lm90-compat mode.

> I would also appreciate a patch to lm_sensors' sensors-detect script for
> the ADT7461, and possibly a patch for libsensors and sensors as well,
> unless you are not interested in these (in which case you would need to
> explicitely mention in Kconfig that the ADT7461 has no user-space
> support at the moment).

Patch to add adt7461 support to lmsensors-2.9.0 is attached. I'm new to
the internals of lmsensors so I may not have done all I need to.

I'm unable to test it since I can't run sensors on my target
which is an embedded ppc board and lmsensors won't cross-compile. I
don't have enough space to run perl anyway! :)

/james
-------------- next part --------------
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
