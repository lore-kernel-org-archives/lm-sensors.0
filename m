From: Lukasz Majewski <l.majewski@samsung.com>
Date: Thu, 18 Dec 2014 10:13:04 +0000
Subject: [lm-sensors] [PATCH 2/9] hwmon: dts: Doc: Add DTS doc to explain how to use PWM FAN as a cooling dev
Message-Id: <1418897591-18332-3-git-send-email-l.majewski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Several new properties to allow PWM fan working as a cooling device have been
combined into this single commit.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 .../devicetree/bindings/hwmon/pwm-fan.txt          | 28 ++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
index 610757c..3877810 100644
--- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
+++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
@@ -3,10 +3,38 @@ Bindings for a fan connected to the PWM lines
 Required properties:
 - compatible	: "pwm-fan"
 - pwms		: the PWM that is used to control the PWM fan
+- cooling-pwm-values      : PWM duty cycle values relative to
+			    cooling-max-pwm-value correspondig to
+			    proper cooling states
+- default-pulse-width     : Property specifying default pulse width for FAN
+			    at system boot (zero to disable FAN on boot).
+			    Allowed range is 0 to 255
+
+Thorough description of the following bindings:
+		cooling-min-state = <0>;
+		cooling-max-state = <3>;
+		#cooling-cells = <2>;
+		thermal-zone {
+			cpu_thermal: cpu-thermal {
+			cooling-maps {
+				map0 {
+				     trip = <&cpu_alert1>;
+				     cooling-device = <&fan0 0 1>;
+				};
+			};
+		};
+
+for PWM FAN used as cooling device can be found at:
+./Documentation/devicetree/bindings/thermal/thermal.txt
 
 Example:
 	pwm-fan {
 		compatible = "pwm-fan";
 		status = "okay";
 		pwms = <&pwm 0 10000 0>;
+		cooling-min-state = <0>;
+		cooling-max-state = <3>;
+		#cooling-cells = <2>;
+		cooling-pwm-values = <0 102 170 255>;
+		default-pulse-width = <0>;
 	};
-- 
2.0.0.rc2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
