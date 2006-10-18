From: greg@kroah.com (Greg KH)
Date: Wed, 18 Oct 2006 20:09:34 +0000
Subject: [lm-sensors] [PATCH 3/8] hwmon: Fix documentation typos
Message-Id: <11612021851009-git-send-email-greg@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Jean Delvare <khali at linux-fr.org>

Fix typos in hardware monitoring documentation.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>
---
 Documentation/hwmon/f71805f   |    2 +-
 Documentation/hwmon/w83627ehf |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/hwmon/f71805f b/Documentation/hwmon/f71805f
index 28c5b7d..2ca69df 100644
--- a/Documentation/hwmon/f71805f
+++ b/Documentation/hwmon/f71805f
@@ -17,7 +17,7 @@ Thanks to Kris Chen from Fintek for answ
 providing additional documentation.
 
 Thanks to Chris Lin from Jetway for providing wiring schematics and
-anwsering technical questions.
+answering technical questions.
 
 
 Description
diff --git a/Documentation/hwmon/w83627ehf b/Documentation/hwmon/w83627ehf
index fae3b78..caa610a 100644
--- a/Documentation/hwmon/w83627ehf
+++ b/Documentation/hwmon/w83627ehf
@@ -26,7 +26,7 @@ fan control mode).
 Temperatures are measured in degrees Celsius and measurement resolution is 1
 degC for temp1 and 0.5 degC for temp2 and temp3. An alarm is triggered when
 the temperature gets higher than high limit; it stays on until the temperature
-falls below the Hysteresis value.
+falls below the hysteresis value.
 
 Fan rotation speeds are reported in RPM (rotations per minute). An alarm is
 triggered if the rotation speed has dropped below a programmable limit. Fan
@@ -67,9 +67,9 @@ Thermal Cruise mode
 
 If the temperature is in the range defined by:
 
-pwm[1-4]_target    - set target temperature, unit millidegree Celcius
+pwm[1-4]_target    - set target temperature, unit millidegree Celsius
 		     (range 0 - 127000)
-pwm[1-4]_tolerance - tolerance, unit millidegree Celcius (range 0 - 15000)
+pwm[1-4]_tolerance - tolerance, unit millidegree Celsius (range 0 - 15000)
 
 there are no changes to fan speed. Once the temperature leaves the interval,
 fan speed increases (temp is higher) or decreases if lower than desired.
-- 
1.4.2.4


