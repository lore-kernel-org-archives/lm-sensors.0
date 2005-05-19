From: aurelien@aurel32.net (Aurelien Jarno)
Date: Thu, 19 May 2005 06:24:48 +0000
Subject: [PATCH] sensord: support for in7 and fan3 for the it87 driver
Message-Id: <20040320231026.GA31811@pc.aurel32.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Sensord misses a few sensors with an it87 chip, in7 and fan3, whereas
they are supported in the library and in sensors.

The attached patch fixes that.

Aurelien

-- 
  .''`.  Aurelien Jarno	              GPG: 1024D/F1BCDB73
 : :' :  Debian GNU/Linux developer | Electrical Engineering Student 
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
-------------- next part --------------
Index: prog/sensord/chips.c
=================================RCS file: /home/cvs/lm_sensors2/prog/sensord/chips.c,v
retrieving revision 1.10
diff -u -1 -b -p -r1.10 chips.c
--- lm_sensors2.orig/prog/sensord/chips.c	21 Nov 2003 20:19:08 -0000	1.10
+++ lm_sensors2/prog/sensord/chips.c	20 Mar 2004 23:06:59 -0000
@@ -564,2 +564,4 @@ static const FeatureDescriptor it87_feat
     { SENSORS_IT87_IN6, SENSORS_IT87_IN6_MIN, SENSORS_IT87_IN6_MAX, -1 } },
+  { fmtVolts_2, rrdF2, DataType_voltage, IT87_ALARM_IN7, 0,
+    { SENSORS_IT87_IN7, SENSORS_IT87_IN7_MIN, SENSORS_IT87_IN7_MAX, -1 } },
   { fmtFans_0, rrdF0, DataType_rpm, IT87_ALARM_FAN1, 0,
@@ -568,2 +570,4 @@ static const FeatureDescriptor it87_feat
     { SENSORS_IT87_FAN2, SENSORS_IT87_FAN2_MIN, SENSORS_IT87_FAN2_DIV, -1 } },
+  { fmtFans_0, rrdF0, DataType_rpm, IT87_ALARM_FAN3, 0,
+    { SENSORS_IT87_FAN3, SENSORS_IT87_FAN3_MIN, SENSORS_IT87_FAN3_DIV, -1 } },
   { fmtTemps_minmax_0, rrdF1, DataType_temperature, IT87_ALARM_TEMP1, 0,
