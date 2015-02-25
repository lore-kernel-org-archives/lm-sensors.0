From: Simon Guinot <simon.guinot@sequanux.org>
Date: Wed, 25 Feb 2015 18:00:19 +0000
Subject: [lm-sensors] [PATCH v2] ARM: Kirkwood: enable GPIO fan alarm support for 2Big Network v2
Message-Id: <1424887219-26652-1-git-send-email-simon.guinot@sequanux.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On the LaCie 2Big Network v2 (net2big_v2) board, the fan alarm is not
wired to the I2C fan controller but to a separe GPIO. This GPIO can be
controlled by using the gpio-fan driver.

This patch adds the gpio-fan alarm description in the net2big_v2 DTS.

Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
---
 arch/arm/boot/dts/kirkwood-net2big.dts | 5 +++++
 1 file changed, 5 insertions(+)

v2 change:
- Fix node name according to the ePAPR standard.

diff --git a/arch/arm/boot/dts/kirkwood-net2big.dts b/arch/arm/boot/dts/kirkwood-net2big.dts
index 53dc37a3b687..13a44773b6df 100644
--- a/arch/arm/boot/dts/kirkwood-net2big.dts
+++ b/arch/arm/boot/dts/kirkwood-net2big.dts
@@ -27,6 +27,11 @@
 		device_type = "memory";
 		reg = <0x00000000 0x10000000>;
 	};
+
+	fan {
+		compatible = "gpio-fan";
+		alarm-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
+	};
 };
 
 &regulators {
-- 
2.1.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
