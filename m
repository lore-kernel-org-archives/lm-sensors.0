From: Lukasz Majewski <l.majewski@samsung.com>
Date: Thu, 18 Dec 2014 10:13:11 +0000
Subject: [lm-sensors] [PATCH 9/9] hwmon: thermal: dts: Disable FAN on boot on the Odroid U3
Message-Id: <1418897591-18332-10-git-send-email-l.majewski@samsung.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
In-Reply-To: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

By specifying default-pulse-width to zero, disable FAN on boot.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
---
 arch/arm/boot/dts/exynos4412-odroidu3.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/exynos4412-odroidu3.dts b/arch/arm/boot/dts/exynos4412-odroidu3.dts
index cc50e96..fec063e 100644
--- a/arch/arm/boot/dts/exynos4412-odroidu3.dts
+++ b/arch/arm/boot/dts/exynos4412-odroidu3.dts
@@ -39,6 +39,7 @@
 		cooling-max-state = <3>;
 		#cooling-cells = <2>;
 		cooling-pwm-values = <0 102 170 255>;
+		default-pulse-width = <0>;
 		status = "okay";
 	};
 
-- 
2.0.0.rc2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
