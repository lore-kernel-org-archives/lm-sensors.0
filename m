From: Lukasz Majewski <l.majewski@samsung.com>
Date: Mon, 22 Dec 2014 16:27:44 +0000
Subject: [lm-sensors] [PATCH v2 4/8] ARM: dts: Add pwm-fan node to the Odroid-U3 board
Message-Id: <1419265668-32283-5-git-send-email-l.majewski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1419265668-32283-1-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1419265668-32283-1-git-send-email-l.majewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>

From: Kamil Debski <k.debski@samsung.com>

Add pwm-fan node to the Odroid-U3 board file to enable PWM control of the
cooling fan. In addition, add the "pwm" label to the pwm@139D0000 node
in the exynos4412.dtsi.

Signed-off-by: Kamil Debski <k.debski@samsung.com>
[Rebased on the newest mainline by l.majewski@samsung.com]
---
Changes since v1:
- added pwm label to the pwm@139D0000 node in exynos4.dtsi
- use the pwm label in the exynos4412-odroidu3.dts
- change order or properties in the pwn-fan node, to be sorted
  in alphabetical order

---
 arch/arm/boot/dts/exynos4.dtsi            |  2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 13 +++++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index 1735bb3..f227a39 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -583,7 +583,7 @@
 		status = "disabled";
 	};
 
-	pwm@139D0000 {
+	pwm: pwm@139D0000 {
 		compatible = "samsung,exynos4210-pwm";
 		reg = <0x139D0000 0x1000>;
 		interrupts = <0 37 0>, <0 38 0>, <0 39 0>, <0 40 0>, <0 41 0>;
diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index c8a64be..60bd1e4 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -31,6 +31,19 @@
 			linux,default-trigger = "heartbeat";
 		};
 	};
+
+	pwm-fan {
+		compatible = "pwm-fan";
+		pwms = <&pwm 0 10000 0>;
+		status = "okay";
+	};
+};
+
+&pwm {
+	pinctrl-0 = <&pwm0_out>;
+	pinctrl-names = "default";
+	samsung,pwm-outputs = <0>;
+	status = "okay";
 };
 
 &usb3503 {
-- 
2.0.0.rc2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
