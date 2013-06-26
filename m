From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Date: Wed, 26 Jun 2013 08:51:10 +0000
Subject: [lm-sensors] [PATCH 1/4] arm: mxs: Add #io-channel-cells property to lradc
Message-Id: <1372236673-20725-2-git-send-email-alexandre.belloni@free-electrons.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1372236673-20725-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1372236673-20725-1-git-send-email-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Shawn Guo <shawn.guo@linaro.org>, Jean Delvare <khali@linux-fr.org>
Cc: jimwall@q.com, brian@crystalfontz.com, Maxime Ripard <maxime.ripard@free-electrons.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, Guenter Roeck <linux@roeck-us.net>, Russell King <linux@arm.linux.org.uk>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, linux-arm-kernel@lists.infradead.org, Alexandre Belloni <alexandre.belloni@free-electrons.com>

Adding #io-channel-cells property to lradc allows us to use the lradc as an iio
provider.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
 arch/arm/boot/dts/imx28.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/imx28.dtsi b/arch/arm/boot/dts/imx28.dtsi
index 600f7cb..9a7feeb 100644
--- a/arch/arm/boot/dts/imx28.dtsi
+++ b/arch/arm/boot/dts/imx28.dtsi
@@ -829,6 +829,7 @@
 				interrupts = <10 14 15 16 17 18 19
 						20 21 22 23 24 25>;
 				status = "disabled";
+				#io-channel-cells = <1>;
 			};
 
 			spdif@80054000 {
-- 
1.8.1.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
