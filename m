From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 13 Nov 2009 13:42:03 +0000
Subject: [lm-sensors] [PATCH] hwmon: Clarify autopwm trip points
Message-Id: <20091113144203.7443070d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Document the case of hybrid automatic fan speed control
implementations, where trip points are associated to both PWM output
channels and temperature input channels.

Signed-off-by: Jean Delvare <khali@linux-fr.org>
---
While working on the adt7473 and adt7475 drivers, I have noticed that
their implementation of automatic fan speed control doesn't match what
we documented in the sysfs-interface document. As the implementation
makes sense, I believe we shall keep it and update the documentation
accordingly.

 Documentation/hwmon/sysfs-interface |   11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

--- linux-2.6.32-rc7.orig/Documentation/hwmon/sysfs-interface	2009-11-04 09:27:12.000000000 +0100
+++ linux-2.6.32-rc7/Documentation/hwmon/sysfs-interface	2009-11-13 14:35:24.000000000 +0100
@@ -225,8 +225,6 @@ pwm[1-*]_auto_point[1-*]_temp_hyst
 		to PWM output channels.
 		RW
 
-OR
-
 temp[1-*]_auto_point[1-*]_pwm
 temp[1-*]_auto_point[1-*]_temp
 temp[1-*]_auto_point[1-*]_temp_hyst
@@ -235,6 +233,15 @@ temp[1-*]_auto_point[1-*]_temp_hyst
 		to temperature channels.
 		RW
 
+There is a third case where trip points are associated to both PWM output
+channels and temperature channels: the PWM values are associated to PWM
+output channels while the temperature values are associated to temperature
+channels. In that case, the result is determined by the mapping between
+temperature inputs and PWM outputs. When several temperature inputs are
+mapped to a given PWM output, this leads to several candidate PWM values.
+The actual result is up to the chip, but in general the highest candidate
+value (fastest fan speed) wins.
+
 
 ****************
 * Temperatures *


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
