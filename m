From: Arnaud Ebalard <arno@natisbad.org>
Date: Tue, 04 Jun 2013 07:14:47 +0000
Subject: [lm-sensors] [PATCHv4 2/3] Add documentation for g762 driver
Message-Id: <424fad46a59b886551c905024f8707ad83b80762.1370327864.git.arno@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1370327864.git.arno@natisbad.org>
In-Reply-To: <cover.1340327864.git.arno@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Simon Guinot <simon.guinot@sequanux.org>, Olivier Mouchet <olivier.mouchet@gmail.com>


Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 Documentation/hwmon/g762 |   62 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/hwmon/g762

diff --git a/Documentation/hwmon/g762 b/Documentation/hwmon/g762
new file mode 100644
index 0000000..8cdb0dc
--- /dev/null
+++ b/Documentation/hwmon/g762
@@ -0,0 +1,62 @@
+Kernel driver g762
+=========
+
+The GMT G762 Fan Speed PWM Controller is connected directly to a fan
+and performs closed-loop or open-loop control of the fan speed. Two
+modes - PWM or DC - are supported by the device.
+
+For additional information, a detailed datasheet is available at
+http://natisbad.org/NAS/ref/GMT_EDS-762_763-080710-0.2.pdf. sysfs
+bindings are described in Documentation/hwmon/sysfs-interface.
+
+The following entries are available to the user in a subdirectory of
+/sys/bus/i2c/drivers/g762/ to control the operation of the device.
+This can be done manually using the following entries but is usually
+done via a userland daemon like fancontrol.
+
+Note that those entries do not provide ways to setup the specific
+hardware characteristics of the system (reference clock, pulses per
+fan revolution, ...); Those can be modified via devicetree bindings
+documented in Documentation/devicetree/bindings/hwmon/g762.txt or
+using a specific platform_data structure in board initialization
+file (see include/linux/platform_data/g762.h).
+
+  fan1_target: set desired fan speed. This only makes sense in closed-loop
+            fan speed control (i.e. when pwm1_enable is set to 2).
+
+  fan1_input: provide current fan rotation value in RPM as reported by
+            the fan to the device.
+
+  fan1_div: fan clock divisor. Supported value are 1, 2, 4 and 8.
+
+  fan1_fault: reports fan failure, i.e. no transition on fan gear pin for
+            about 0.7s (if the fan is not voluntarily set off).
+
+  fan1_alarm: in closed-loop control mode, if fan RPM value is 25% out
+            of the programmed value for over 6 seconds 'fan1_alarm' is
+            set to 1.
+
+  pwm1_enable: set current fan speed control mode i.e. 1 for manual fan
+            speed control (open-loop) via pwm1 described below, 2 for
+            automatic fan speed control (closed-loop) via fan1_target
+            above (pwm1 is also usable).
+
+  pwm1_mode: set or get fan driving mode: 1 for PWM mode, 0 for DC mode.
+
+  pwm1: get or set PWM fan control value in open-loop mode. This is an
+            integer value between 0 and 255. 0 stops the fan, 255 makes
+            it run at full speed.
+
+Both in PWM mode ('pwm1_mode' set to 1) and DC mode ('pwm1_mode' set to 0),
+when current fan speed control mode is open-loop ('pwm1_enable' set to 1),
+the fan speed is programmed by setting a value between 0 and 255 via 'pwm1'
+entry (0 stops the fan, 255 makes it run at full speed). In closed-loop mode
+('pwm1_enable' set to 2), the expected rotation speed in RPM can be passed to
+the chip via 'fan1_target'. In closed-loop mode, the target speed is compared
+with current speed (available via 'fan1_input') by the device and a feedback
+is performed to match that target value. The fan speed value is computed
+based on the parameters associated with the physical characteristics of the
+system: a reference clock source frequency, a number of pulses per fan
+revolution, etc.
+
+Note that the driver will update its values at most once per second.
-- 
1.7.10.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
