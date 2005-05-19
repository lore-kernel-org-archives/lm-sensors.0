From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:31 +0000
Subject: [patch] fscpos upgrade for sensor library
Message-Id: <SnX6eRDo.1106211699.2306390.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050119213747.GB26072@desire.ch>
In-Reply-To: <20050119213747.GB26072@desire.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Stefan,

> The following patch changes lm_sensors in order to work properly with the
> new fscpos driver.
> (...)
>--- lm_sensors-2.9.0-orig/etc/sensors.conf.eg	2004-11-25 20:40:09.000000000 +0100
>+++ lm-sensors-2.9.0/etc/sensors.conf.eg	2005-01-19 22:12:57.000000000 +0100
>@@ -1587,15 +1587,15 @@
>
> # Fans
>
>-    label  fan1       "Fan1"
>-    ignore  fan2
>-    ignore  fan3
>+    label fan1        "Fan1"
>+    label fan2        "Fan2"
>+    label fan3        "Fan3"

Sounds sane.

> # Voltage
>
>-    label volt12      "+12V"
>-    label volt5       "+5V"
>-    label voltbatt    "+3.3V"
>+    label in0_input   "+12V"
>+    label in1_input   "+5V"
>+    label in2_input   "Battery"

Not correct. libsensors refers to the 2.4 names, which we would try not
to change so as to preserve compatibility wherever possible. These lines
should not be changed. See below.

>diff -Nru lm_sensors-2.9.0-orig/lib/chips.c lm-sensors-2.9.0/lib/chips.c
>--- lm_sensors-2.9.0-orig/lib/chips.c	2004-11-24 05:31:40.000000000 +0100
>+++ lm-sensors-2.9.0/lib/chips.c	2005-01-19 22:08:14.000000000 +0100
>@@ -4010,17 +4010,13 @@
>
> static sensors_chip_feature fscpos_features[] >   {
>-    { SENSORS_FSCPOS_REV, "rev", NOMAP, NOMAP,
>-                        R, FSCPOS_SYSCTL_REV, VALUE(1), 0 },
>     { SENSORS_FSCPOS_EVENT, "event", NOMAP, NOMAP,
>                         R, FSCPOS_SYSCTL_EVENT, VALUE(1), 0 },
>-    { SENSORS_FSCPOS_CONTROL, "control", NOMAP, NOMAP,
>-                        RW, FSCPOS_SYSCTL_CONTROL, VALUE(1), 0 },

Fine with me. The "sensors" program wouldn't even use them anyway.

>-    { SENSORS_FSCPOS_VOLTAGE1, "volt12", NOMAP, NOMAP,
>+    { SENSORS_FSCPOS_VOLTAGE1, "in0_input", NOMAP, NOMAP,
>                         R, FSCPOS_SYSCTL_VOLT0, VALUE(1), 2 },
>-    { SENSORS_FSCPOS_VOLTAGE2, "volt5", NOMAP, NOMAP,
>+    { SENSORS_FSCPOS_VOLTAGE2, "in1_input", NOMAP, NOMAP,
>                         R, FSCPOS_SYSCTL_VOLT1, VALUE(1), 2 },
>-    { SENSORS_FSCPOS_VOLTAGE3, "voltbatt", NOMAP,
>+    { SENSORS_FSCPOS_VOLTAGE3, "in2_input", NOMAP,
> 			NOMAP, R,
> 			FSCPOS_SYSCTL_VOLT2, VALUE(1), 2 },

Not correct. Don't change the symbol names. Instead, add an alternative
name for 2.6. For volt12, it would look like:

    { SENSORS_FSCPOS_VOLTAGE1, "volt12", NOMAP, NOMAP,
                        R, FSCPOS_SYSCTL_VOLT0, VALUE(1), 2,
                        "in0_input", 3 },

I.e. basically you just have to append the symbol name and magnitude for
the 2.6 driver right after the other values. That way we preserve
compatibility with the 2.4 driver.


>-    { SENSORS_FSCPOS_FAN1_MIN, "fan1_min", SENSORS_FSCPOS_FAN1,
>+    { SENSORS_FSCPOS_PWM2, "pwm1", SENSORS_FSCPOS_FAN1,
> 			SENSORS_FSCPOS_FAN1, RW,
> 			FSCPOS_SYSCTL_FAN0, VALUE(2), 0 },
>-    { SENSORS_FSCPOS_FAN2_MIN, "fan2_min", SENSORS_FSCPOS_FAN2,
>+    { SENSORS_FSCPOS_PWM2, "pwm2", SENSORS_FSCPOS_FAN2,
> 			SENSORS_FSCPOS_FAN2, RW,
> 			FSCPOS_SYSCTL_FAN1, VALUE(2), 0 },

Likewise, I would rather add the 2.6 names than change existing ones so
as to preserve compatibility. Unless you also plan to modify the 2.4
driver to extract the fan_min values from fanN files and have separate
pwm files instead, like it should probably have been done in the first
place. That said, since you said you don't exactly get how fan mins
work with this chip, it might be wiser not to change this (for now at
least).

Thanks,
--
Jean Delvare
