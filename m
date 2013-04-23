From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 23 Apr 2013 22:06:08 +0000
Subject: [lm-sensors] [PATCHv1 2/3] hwmon: Add documentation for g762 driver
Message-Id: <24acd174f829d211f5d4c1b8631ffc3f8dd97910.1366753420.git.arno@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366322287.git.arno@natisbad.org>
	<4f4a821bbc61e2da28fd70553fd717ada255097d.1366322287.git.arno@natisbad.org>
	<20130419043555.GA14124@roeck-us.net>
In-Reply-To: <cover.1366753420.git.arno@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <khali@linux-fr.org>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>, Simon Guinot <simon.guinot@sequanux.org>, Olivier Mouchet <olivier.mouchet@gmail.com>


Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 Documentation/hwmon/g762 |   67 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/hwmon/g762

diff --git a/Documentation/hwmon/g762 b/Documentation/hwmon/g762
new file mode 100644
index 0000000..5015829
--- /dev/null
+++ b/Documentation/hwmon/g762
@@ -0,0 +1,67 @@
+Kernel driver g762
+=========
+
+This documentation is based on G760a one, GMT G762 datasheet available
+at http://natisbad.org/NAS/ref/GMT_EDS-762_763-080710-0.2.pdf (used
+for the development of the driver) and sysfs bindings described in
+Documentation/hwmon/sysfs-interface.
+
+The GMT G762 Fan Speed PWM Controller is connected directly to a fan
+and performs closed-loop or open-loop control of the fan speed. Two
+modes - PWM or linear - are supported by the device.
+
+The following entries are available to the user in a subdirectory of
+/sys/bus/i2c/drivers/g762/ to control the operation of the device.
+This can be done manually using the following entries but is usually
+done via a userland daemon like fancontrol.
+
+Note that those entries do not provide ways to setup the specific
+hardware characteristics of the system (reference clock, pulses per
+fan revolution, ...); Those can be modified via devicetree bindings
+documented in Documentation/devicetree/bindings/hwmon/g762.txt.
+
+
+  fan1_target: set desired fan speed. This only makes sense in closed-loop
+            fan speed control (i.e. when pwm1_enable is set to 2).
+
+  fan1_input: provide current fan rotation value in RPM as reported by
+            the fan to the device.
+
+  fan1_div: fan clock divisor. Supported value are 1, 2, 4 and 8. Default
+            value is 1.
+
+  fan1_gear_mode: fan gear mode. Supported values are 0, 1 and 2. Default
+            value is 0. The value is a characteristic of the system
+            and a higher value can be set for more precisely control
+            fans with a high rotation speed. Note that this affects the
+            measurable speed range, not the read value.
+
+  fan1_fault: reports fan failure, i.e. no transition on fan gear pin for
+            about 0.7s (if the fan is not voluntarily set off).
+
+  fan1_alarm: in closed-loop control mode, if fan RPM value is 25% out
+            of the programmed value for over 6 seconds 'fan1_alarm' is
+            set to 1.
+
+  pwm1: get or set PWM fan control value. This is an integer value
+            between 0 and 255. 0 stops the fan, 255 makes it run at
+            full speed.
+
+  pwm1_enable: set current fan speed control mode i.e. 1 for manual fan
+            speed control (open-loop), 2 for automatic fan speed control
+            (closed-loop).
+
+  pwm1_mode: set or get fan driving mode: 1 for PWM mode, 0 for linear
+            mode. Default is linear mode.
+
+
+In PWM mode ('pwm1_mode' set to 1), the fan speed is programmed either by
+setting a value between 0 and 255 via 'pwm1' entry (0 stops the fan, 255
+makes it run at full speed). This can also be done by passing the
+expected RPM value via 'fan1_target'. Current fan speed value can be
+retrieved via 'fan1_input'. This fan speed value is computed based on
+the parameters associated with the physical characteristics of the
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
