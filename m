From: Lukasz Majewski <l.majewski@samsung.com>
Date: Wed, 18 Feb 2015 10:07:31 +0000
Subject: [lm-sensors] [PATCH v4 3/8] Documentation: dts: Documentation entry to explain how to use PWM FAN as
Message-Id: <1424254056-5904-4-git-send-email-l.majewski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1424254056-5904-1-git-send-email-l.majewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Explanation of several properties, which allow PWM fan working as a cooling
device, have been embraced in this commit.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- Rename cooling-pwm-values to cooling-levels
- Remove default-pulse-width property and stick to default hwmon policy
Changes for v3:
- Changing commit title from "hwmon: dts: Doc:" to "Documentation: dts"
- Remove unnecessary properties
- Set maximal cooling level to 230 instead of 255
Changes for v4:
- None
---
 Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
index 610757c..d53fe0c 100644
--- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
+++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
@@ -3,10 +3,30 @@ Bindings for a fan connected to the PWM lines
 Required properties:
 - compatible	: "pwm-fan"
 - pwms		: the PWM that is used to control the PWM fan
+- cooling-levels      : PWM duty cycle values in a range from 0 to 255
+			which correspond to thermal cooling states
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
+		cooling-levels = <0 102 170 230>;
 	};
-- 
2.0.0.rc2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
