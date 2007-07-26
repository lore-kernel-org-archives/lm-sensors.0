From: Krzysztof Helt <krzysztof.h1@wp.pl>
Date: Thu, 26 Jul 2007 21:09:02 +0000
Subject: [lm-sensors] [PATCH] THMC50 2.6 additions to lm-sensors
Message-Id: <20070726230902.b6750577.krzysztof.h1@wp.pl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch adds support for the THMC50 kernel driver to lm-sensors library (for 2.6 kernel driver).
At least temperatures and analog output (fan) can be read.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

--- lm-sensors2/lib/chips.c	2007-07-26 22:37:21.000000000 +0200
+++ lm-sensors/lib/chips.c	2007-07-26 23:07:33.889347402 +0200
@@ -2747,7 +2747,8 @@ static sensors_chip_feature thmc50_featu
                              THMC50_SYSCTL_TEMP, VALUE(3), 0 },
     { { SENSORS_THMC50_TEMP_HYST, "temp_hyst", SENSORS_THMC50_TEMP, 
                                   SENSORS_THMC50_TEMP, RW }, 
-                                  THMC50_SYSCTL_TEMP, VALUE(2), 0 },
+                                  THMC50_SYSCTL_TEMP, VALUE(2), 0,
+                                  "temp1_min", 3 },
     { { SENSORS_THMC50_TEMP_OVER, "temp_over", SENSORS_THMC50_TEMP, 
                                   SENSORS_THMC50_TEMP, RW }, 
                                   THMC50_SYSCTL_TEMP, VALUE(1), 0 },
@@ -2757,14 +2758,15 @@ static sensors_chip_feature thmc50_featu
                                          SENSORS_THMC50_REMOTE_TEMP, 
                                          SENSORS_THMC50_REMOTE_TEMP, RW }, 
                                          THMC50_SYSCTL_REMOTE_TEMP, VALUE(2), 
-                                         0 },
+                                         0, "temp2_min", 3 },
     { { SENSORS_THMC50_REMOTE_TEMP_OVER, "remote_temp_over", 
                                          SENSORS_THMC50_REMOTE_TEMP, 
                                          SENSORS_THMC50_REMOTE_TEMP, RW }, 
                                          THMC50_SYSCTL_REMOTE_TEMP, VALUE(1), 
                                          0 },
     { { SENSORS_THMC50_INTER_MASK, "analog output", NOMAP, NOMAP, RW }, 
-                                   THMC50_SYSCTL_ANALOG_OUT, VALUE(1), 0 },
+                                   THMC50_SYSCTL_ANALOG_OUT, VALUE(1), 0,
+                                   "pwm1", 0 },
     { { SENSORS_THMC50_INTER, "interrupts", NOMAP, NOMAP, R }, 
                               THMC50_SYSCTL_INTER, VALUE(1), 0 },
     { { SENSORS_THMC50_INTER_MASK, "interrupt mask", NOMAP, NOMAP, RW }, 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
