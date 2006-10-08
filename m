From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 08 Oct 2006 19:59:54 +0000
Subject: [lm-sensors] [PATCH 3/6] hwmon: Fix documentation typos
Message-Id: <20061008215954.3a00c185.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Content-Disposition: inline; filename=hwmon-documentation-typos.patch

Fix typos in hardware monitoring documentation.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
---
 Documentation/hwmon/f71805f   |    2 +-
 Documentation/hwmon/w83627ehf |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--- linux-2.6.19-rc1.orig/Documentation/hwmon/w83627ehf	2006-10-08 12:48:09.000000000 +0200
+++ linux-2.6.19-rc1/Documentation/hwmon/w83627ehf	2006-10-08 15:04:02.000000000 +0200
@@ -26,7 +26,7 @@
 Temperatures are measured in degrees Celsius and measurement resolution is 1
 degC for temp1 and 0.5 degC for temp2 and temp3. An alarm is triggered when
 the temperature gets higher than high limit; it stays on until the temperature
-falls below the Hysteresis value.
+falls below the hysteresis value.
 
 Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
 triggered if the rotation speed has dropped below a programmable limit. Fan
@@ -67,9 +67,9 @@
 
 If the temperature is in the range defined by:
 
-pwm[1-4]_target    - set target temperature, unit millidegree Celcius
+pwm[1-4]_target    - set target temperature, unit millidegree Celsius
 		     (range 0 - 127000)
-pwm[1-4]_tolerance - tolerance, unit millidegree Celcius (range 0 - 15000)
+pwm[1-4]_tolerance - tolerance, unit millidegree Celsius (range 0 - 15000)
 
 there are no changes to fan speed. Once the temperature leaves the interval,
 fan speed increases (temp is higher) or decreases if lower than desired.
--- linux-2.6.19-rc1.orig/Documentation/hwmon/f71805f	2006-10-08 12:48:09.000000000 +0200
+++ linux-2.6.19-rc1/Documentation/hwmon/f71805f	2006-10-08 14:59:21.000000000 +0200
@@ -17,7 +17,7 @@
 providing additional documentation.
 
 Thanks to Chris Lin from Jetway for providing wiring schematics and
-anwsering technical questions.
+answering technical questions.
 
 
 Description

-- 
Jean Delvare

