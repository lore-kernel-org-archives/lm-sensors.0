From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 09 Feb 2012 16:57:23 +0000
Subject: [lm-sensors] [PATCH 2/2] hwmon: (w83627ehf) Describe undocumented pwm attributes
Message-Id: <1328806643-25371-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Add description of pwm[1-4]_start_output, pwm[1-4]_step_output,
pwm[1-4]_stop_output, and pwm[1-4]_max_output attributes to driver
documentation.

Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
---
 Documentation/hwmon/w83627ehf |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/Documentation/hwmon/w83627ehf b/Documentation/hwmon/w83627ehf
index 3f44dbd..ea75fe4 100644
--- a/Documentation/hwmon/w83627ehf
+++ b/Documentation/hwmon/w83627ehf
@@ -143,6 +143,11 @@ pwm[1-4]_min_output - minimum fan speed (range 1 - 255), when the temperature
 pwm[1-4]_stop_time  - how many milliseconds [ms] must elapse to switch
                       corresponding fan off. (when the temperature was below
                       defined range).
+pwm[1-4]_start_output-minimum fan speed (range 1 - 255) when spinning up
+pwm[1-4]_step_output- rate of fan speed change (1 - 255)
+pwm[1-4]_stop_output- minimum fan speed (range 1 - 255) when spinning down
+pwm[1-4]_max_output - maximum fan speed (range 1 - 255), when the temperature
+                      is above defined range.
 
 Note: last two functions are influenced by other control bits, not yet exported
       by the driver, so a change might not have any effect.
-- 
1.7.3.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
