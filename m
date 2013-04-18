From: arno@natisbad.org (Arnaud Ebalard)
Date: Thu, 18 Apr 2013 22:28:39 +0000
Subject: [lm-sensors] [RFC, PATCHv0 2/3] Add DT documentation for G762 PWM fan controller
Message-Id: <3a1f8fa72e97a3dc8102bc3ba416c83160205355.1366322287.git.arno@natisbad.org>
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
 Documentation/devicetree/bindings/hwmon/g762.txt |   37 ++++++++++++++++++++++
 1 file changed, 37 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/g762.txt

diff --git a/Documentation/devicetree/bindings/hwmon/g762.txt b/Documentation/devicetree/bindings/hwmon/g762.txt
new file mode 100644
index 0000000..9eee838
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/g762.txt
@@ -0,0 +1,37 @@
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
+ - "pwm_enable": fan speed control. 1 for open-loop, 2 for closed-loop.
+               Default value is 2, i.e. closed-loop.
+ - "pwm_freq": reference clock frequency for PWM mode in Hz. Default is
+               32768.
+ - "fan_pulses": number of pulses per fan revolution. Supported values
+               are 2 and 4. Default is 2.
+ - "fan_div": fan clock frequency divisor value. Supported values are
+              1, 2, 4 and 8. Default is 1.
+ - "fan_target": initial target fan speed in RPM. By default, current
+               value is not modified.
+
+Previous optional properties provides devicetree access to the entries
+described in Documentation/hwmon/g762
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
+   };
-- 
1.7.10.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
