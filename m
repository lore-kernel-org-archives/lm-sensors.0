From: Lukasz Majewski <l.majewski@samsung.com>
Date: Mon, 22 Dec 2014 16:27:45 +0000
Subject: [lm-sensors] [PATCH v2 5/8] hwmon: thermal: dts: Add properties to use pwm-fan device as a cooling d
Message-Id: <1419265668-32283-6-git-send-email-l.majewski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
 <1419265668-32283-1-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1419265668-32283-1-git-send-email-l.majewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

With those bindings it is possible to use pwm-fan device available in
Odroid U3 as a cooling device.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
Changes for v2:
- Rename cooling-pwm-values property to cooling-levels
---
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 33 ++++++++++++++++++++++++++++++-
 1 file changed, 32 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index 60bd1e4..380035d 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -32,11 +32,42 @@
 		};
 	};
 
-	pwm-fan {
+	fan0: pwm-fan {
 		compatible = "pwm-fan";
 		pwms = <&pwm 0 10000 0>;
+		cooling-min-state = <0>;
+		cooling-max-state = <3>;
+		#cooling-cells = <2>;
+		cooling-levels = <0 102 170 255>;
 		status = "okay";
 	};
+
+	thermal-zones {
+		cpu_thermal: cpu-thermal {
+			cooling-maps {
+				map0 {
+				     trip = <&cpu_alert1>;
+				     cooling-device = <&cpu0 7 7>;
+				};
+				map1 {
+				     trip = <&cpu_alert2>;
+				     cooling-device = <&cpu0 13 13>;
+				};
+				map2 {
+				     trip = <&cpu_alert0>;
+				     cooling-device = <&fan0 0 1>;
+				};
+				map3 {
+				     trip = <&cpu_alert1>;
+				     cooling-device = <&fan0 1 2>;
+				};
+				map4 {
+				     trip = <&cpu_alert2>;
+				     cooling-device = <&fan0 2 3>;
+				};
+			};
+		};
+	};
 };
 
 &pwm {
-- 
2.0.0.rc2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
