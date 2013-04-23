From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 23 Apr 2013 22:06:20 +0000
Subject: [lm-sensors] [PATCHv1 3/3] hwmon: Add DT documentation for g762 driver
Message-Id: <6ee748f450ba2a80c87aba08c0672105e2800f93.1366753420.git.arno@natisbad.org>
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
 Documentation/devicetree/bindings/hwmon/g762.txt |   57 ++++++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt

diff --git a/Documentation/devicetree/bindings/hwmon/g762.txt b/Documentation/devicetree/bindings/hwmon/g762.txt
new file mode 100644
index 0000000..87d7cf5
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/g762.txt
@@ -0,0 +1,57 @@
+GMT G762/G763 PWM Fan controller
+
+Required node properties:
+
+ - "compatible": must be either "gmt,g762" or "gmt,g763"
+ - "reg": I2C bus address of the device
+
+Optional properties:
+
+ - "pwm_mode": fan driving mode. 1 for PWM mode, 0 for linear. Default
+               value is 0, i.e. linear.
+
+ - "pwm_enable": fan speed control. 1 for open-loop, 2 for closed-loop.
+               Default value is 2, i.e. closed-loop.
+
+ - "pwm_freq": reference clock frequency for PWM mode in Hz. Default is
+               32768.
+
+ - "fan_pulses": number of pulses per fan revolution. Supported values
+               are 2 and 4. Default is 2.
+
+ - "fan_div": fan clock frequency divisor value. Supported values are 1,
+               2, 4 and 8. Default is 1.
+
+ - "fan_target": initial target fan speed in RPM. By default, current
+               value is not modified. Only works in closed-loop fan speed
+	       control, i.e. when pwm_enable has already been set to 2.
+
+ - "fan_startv": fan startup voltage. Accepted values are 0, 1, 2 and 3.
+               Default value is 1. The higher the more.
+
+ - "pwm_polarity": pwm polarity. Accepted values are 0 (positive duty)
+               and 1 (negative duty). Default is 0 i.e. positive duty.
+
+ - "fan_gear_mode": fan gear mode. Supported values are 0, 1 and 2.
+               Default is 0.
+
+
+Additional information on operational parameters for the device is available
+in Documentation/hwmon/g762. A detailed datasheet for the device is available
+at http://natisbad.org/NAS/refs/GMT_EDS-762_763-080710-0.2.pdf.
+
+Example g762 node:
+
+   g762: g762@3e {
+        compatible = "gmt,g762";
+   	reg = <0x3e>;
+   	pwm_mode = <1>;      /* closed-loop control */
+   	pwm_enable = <2>;    /* PWM mode */
+   	pwm_freq = <8192>;   /* PWM reference clock freq */
+   	fan_pulses = <2>;    /* 2 pulses per rev */
+   	fan_div = <2>;       /* fan clock divisor */
+   	fan_target = <2000>; /* target fan speed at 2000 RPM */
+        fan_gear_mode = <0>; /* default */
+        fan_startv = <1>;    /* default */
+        pwm_polarity = <0>;  /* default */
+   };
-- 
1.7.10.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
