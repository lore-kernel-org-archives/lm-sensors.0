From: Samu Onkalo <samu.p.onkalo@nokia.com>
Date: Fri, 22 Oct 2010 11:57:30 +0000
Subject: [lm-sensors] [PATCH 08/12] hwmon: lis3: Adjust fuzziness for 8 bit
Message-Id: <1287748654-2626-9-git-send-email-samu.p.onkalo@nokia.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1287748654-2626-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: eric.piel@tremplin-utc.net, khali@linux-fr.org, guenter.roeck@ericsson.com, jic23@cam.ac.uk
Cc: lm-sensors@lm-sensors.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org

Default fuziness is set smaller for 8 device.
In 12 bit device LSB is quite close to 1 mg
(mg = 1 / 1000 of earth gravity).
In 8bit device LSB is about 18 mg.
Set fuziness to 1 for 8 bit device.

Signed-off-by: Samu Onkalo <samu.p.onkalo@nokia.com>
---
 drivers/hwmon/lis3lv02d.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/lis3lv02d.c b/drivers/hwmon/lis3lv02d.c
index d66cbe1..7555091 100644
--- a/drivers/hwmon/lis3lv02d.c
+++ b/drivers/hwmon/lis3lv02d.c
@@ -71,8 +71,10 @@
 #define LIS3_SENSITIVITY_12B		((LIS3_ACCURACY * 1000) / 1024)
 #define LIS3_SENSITIVITY_8B		(18 * LIS3_ACCURACY)
 
-#define LIS3_DEFAULT_FUZZ		3
-#define LIS3_DEFAULT_FLAT		3
+#define LIS3_DEFAULT_FUZZ_12B		3
+#define LIS3_DEFAULT_FLAT_12B		3
+#define LIS3_DEFAULT_FUZZ_8B		1
+#define LIS3_DEFAULT_FLAT_8B		1
 
 struct lis3lv02d lis3_dev = {
 	.misc_wait   = __WAIT_QUEUE_HEAD_INITIALIZER(lis3_dev.misc_wait),
@@ -530,8 +532,16 @@ int lis3lv02d_joystick_enable(void)
 
 	set_bit(EV_ABS, input_dev->evbit);
 	max_val = (lis3_dev.mdps_max_val * lis3_dev.scale) / LIS3_ACCURACY;
-	fuzz = (LIS3_DEFAULT_FUZZ * lis3_dev.scale) / LIS3_ACCURACY;
-	flat = (LIS3_DEFAULT_FLAT * lis3_dev.scale) / LIS3_ACCURACY;
+	if (lis3_dev.whoami = WAI_12B) {
+		fuzz = LIS3_DEFAULT_FUZZ_12B;
+		flat = LIS3_DEFAULT_FLAT_12B;
+	} else {
+		fuzz = LIS3_DEFAULT_FUZZ_8B;
+		flat = LIS3_DEFAULT_FLAT_8B;
+	}
+	fuzz = (fuzz * lis3_dev.scale) / LIS3_ACCURACY;
+	flat = (flat * lis3_dev.scale) / LIS3_ACCURACY;
+
 	input_set_abs_params(input_dev, ABS_X, -max_val, max_val, fuzz, flat);
 	input_set_abs_params(input_dev, ABS_Y, -max_val, max_val, fuzz, flat);
 	input_set_abs_params(input_dev, ABS_Z, -max_val, max_val, fuzz, flat);
-- 
1.6.0.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
