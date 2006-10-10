From: gregkh@suse.de (gregkh at suse.de)
Date: Tue, 10 Oct 2006 20:54:03 +0000
Subject: [lm-sensors] patch hwmon-documentation-typos.patch added to
Message-Id: <20061010205356.5E26D8FD5EB@imap.suse.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


This is a note to let you know that I've just added the patch titled

     Subject: [PATCH 3/6] hwmon: Fix documentation typos

to my gregkh-2.6 tree.  Its filename is

     hwmon-documentation-typos.patch

This tree can be found at 
    http://www.kernel.org/pub/linux/kernel/people/gregkh/gregkh-2.6/patches/


From khali at linux-fr.org Sun Oct  8 12:59:58 2006
Date: Sun, 8 Oct 2006 21:59:54 +0200
From: Jean Delvare <khali at linux-fr.org>
To: Greg KH <greg at kroah.com>
Cc: LM Sensors <lm-sensors at lm-sensors.org>
Subject: [PATCH 3/6] hwmon: Fix documentation typos
Message-Id: <20061008215954.3a00c185.khali at linux-fr.org>
Content-Disposition: inline; filename=hwmon-documentation-typos.patch

Fix typos in hardware monitoring documentation.

Signed-off-by: Jean Delvare <khali at linux-fr.org>
Signed-off-by: Greg Kroah-Hartman <gregkh at suse.de>

---
 Documentation/hwmon/f71805f   |    2 +-
 Documentation/hwmon/w83627ehf |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

--- gregkh-2.6.orig/Documentation/hwmon/f71805f
+++ gregkh-2.6/Documentation/hwmon/f71805f
@@ -17,7 +17,7 @@ Thanks to Kris Chen from Fintek for answ
 providing additional documentation.
 
 Thanks to Chris Lin from Jetway for providing wiring schematics and
-anwsering technical questions.
+answering technical questions.
 
 
 Description
--- gregkh-2.6.orig/Documentation/hwmon/w83627ehf
+++ gregkh-2.6/Documentation/hwmon/w83627ehf
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


Patches currently in gregkh-2.6 which might be from khali at linux-fr.org are

i2c/hwmon-documentation-typos.patch
i2c/hwmon-k8temp-documentation-update.patch
i2c/hwmon-smsc47m112-documentation.patch
i2c/hwmon-unchecked-return-status-fixes-w83791d.patch
i2c/hwmon-update-Grant-Coady-email-address.patch
i2c/hwmon-w83627ehf-fix-fan5-detection.patch
driver-class/i2c-dev-device.patch
driver-class/i2c-dev-device.old.patch

