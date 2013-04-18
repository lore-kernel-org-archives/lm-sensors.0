From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 18 Apr 2013 22:28:56 +0000
Subject: [lm-sensors] [PATCH 3/3] Add documentation for g762 driver
Message-Id: <e1cf59a510473a5596fb9be6fc2134bea9c367f2.1366322287.git.arno@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1366322287.git.arno@natisbad.org>
In-Reply-To: <cover.1366322287.git.arno@natisbad.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>, Grant Likely <grant.likely@secretlab.ca>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, devicetree-discuss@lists.ozlabs.org, Rob Landley <rob@landley.net>, linux-doc@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, Olivier Mouchet <olivier.mouchet@gmail.com>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>, Simon Guinot <simon.guinot@sequanux.org>


Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
---
 Documentation/hwmon/g762 |   89 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)
 create mode 100644 Documentation/hwmon/g762

diff --git a/Documentation/hwmon/g762 b/Documentation/hwmon/g762
new file mode 100644
index 0000000..f281b3d
--- /dev/null
+++ b/Documentation/hwmon/g762
@@ -0,0 +1,89 @@
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
+Some of those can be used to fit operations of the controller to the
+characteristics of the system (reference clock value, fan gear mode,
+number of pulses per fan revolution, ...). Other more common
+parameters can be used to interact with the fan and control its speed
+(set a rotation speed and get current speed for instance). This can be
+done manually using the following entries but is usually done via a
+userland daemon like fancontrol.
+
+
+  fan1_target: set desired fan speed. This only makes sense in closed-loop
+            fan speed control (i.e. when pwm1_enable is set to 2).
+
+  fan1_input: provide current fan rotation value in RPM as reported by
+            the fan to the device.
+
+  fan1_pulses: number of tachometer pulses per fan revolution. Supported
+            values are 2 and 4. Default value is 2.
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
+  fan1_fault_detection: enable fan failure detection and reporting as
+            described above.
+
+  fan1_alarm: in closed-loop control mode, if fan RPM value is 25% out
+            of the programmed value for over 6 seconds 'fan1_alarm' is
+            set to 1.
+
+  fan1_alarm_detection: enable fan out of control detection and reporting
+            as described above.
+
+  fan1_startup_voltage: get or set fan startup voltage. Supported values
+            are 0, 1, 2, 3 (respectively for 1.0V, 1.5V, 2.0V and 2.5V).
+
+
+
+  pwm1: get or set PWM fan control value. This is an integer value
+            between 0 and 255. 0 stops the fan, 255 makes it run at
+            full speed.
+
+  pwm1_polarity: set or get the PWM polarity, 0 for positive duty, 1 for
+            negative duty
+
+  pwm1_enable: set current fan speed control mode i.e. 1 for manual fan
+            speed control (open-loop), 2 for automatic fan speed control
+            (closed-loop).
+
+  pwm1_mode: set or get fan driving mode: 1 for PWM mode, 0 for linear
+            mode. Default is linear mode.
+
+  pwm1_freq: set or get value of PWM reference clock frequency. Default
+            value is 32768 (Hz). This parameter only makes sense when
+            the device is set to operate in PWM mode (i.e. pwm1_mode
+            is 1).
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
