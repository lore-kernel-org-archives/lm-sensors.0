From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Tue, 03 Nov 2009 12:09:45 +0000
Subject: [lm-sensors] [RFC PATCH 10/10] LIS3: Update documentation to match
Message-Id: <1257250185-7929-11-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 Documentation/hwmon/lis3lv02d |   16 +++++++++-------
 1 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/Documentation/hwmon/lis3lv02d b/Documentation/hwmon/lis3lv02d
index 21f0902..e8ced22 100644
--- a/Documentation/hwmon/lis3lv02d
+++ b/Documentation/hwmon/lis3lv02d
@@ -20,18 +20,20 @@ sporting the feature officially called "HP Mobile Data Protection System 3D" or
 models (full list can be found in drivers/hwmon/hp_accel.c) will have their
 axis automatically oriented on standard way (eg: you can directly play
 neverball). The accelerometer data is readable via
-/sys/devices/platform/lis3lv02d.
+/sys/devices/platform/lis3lv02d. Reported values are scaled
+to mg values (1/1000th of earth gravity).
 
 Sysfs attributes under /sys/devices/platform/lis3lv02d/:
 position - 3D position that the accelerometer reports. Format: "(x,y,z)"
-calibrate - read: values (x, y, z) that are used as the base for input
-		  class device operation.
-            write: forces the base to be recalibrated with the current
-		   position.
-rate - reports the sampling rate of the accelerometer device in HZ
+rate - read reports the sampling rate of the accelerometer device in HZ.
+	write changes sampling rate of the accelerometer device.
+	Only values which are supported by HW are accepted.
+selftest - performs selftest for the chip as specified by chip manufacturer.
+	Acceptance limits for the selftest must be set in platform data.
 
 This driver also provides an absolute input class device, allowing
-the laptop to act as a pinball machine-esque joystick.
+the laptop to act as a pinball machine-esque joystick. Joystick device can be
+calibrated.
 
 On HP laptops, if the led infrastructure is activated, support for a led
 indicating disk protection will be provided as /sys/class/leds/hp::hddprotect.
-- 
1.5.6.3


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
