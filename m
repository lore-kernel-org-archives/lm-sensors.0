From: Eduardo Valentin <eduardo.valentin@ti.com>
Date: Tue, 01 Oct 2013 18:32:17 +0000
Subject: [lm-sensors] [PATCH 0/7] DRA7: DT thermal support
Message-Id: <1380652344-18819-1-git-send-email-eduardo.valentin@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: swarren@wwwdotorg.org, pawel.moll@arm.com, mark.rutland@arm.com, ian.campbell@citrix.com, rob.herring@calxeda.com, linux@roeck-us.net, rui.zhang@intel.com, grant.likely@linaro.org
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>

Hello all,

This is a complementary patch series with themal DT support for DRA7.

Although this work depends on the thermal dt parser work [1], I decided
to share it before hand. It also depends on DRA7 DT base port support,
which I fetched from Rajendra's tree [2].

This patch series has been runtime tested on DRA7-evm.

All best,

[1] - https://lkml.org/lkml/2013/9/26/787
[2] - git://github.com/rrnayak/linux.git out-of-tree/dra-integrated-v3

Eduardo Valentin (7):
  arm: dts: add dra7 DSPEVE thermal data
  arm: dts: add dra7 IVA thermal data
  arm: dts: dra7: add bandgap entry
  arm: dts: add cooling properties on dra7 cpu node
  arm: dts: dra7: add thermal data
  arm: dts: add tmp102 i2c sensor node on dra7-evm
  arm: dts: add thermal zones info on tmp102 for DRA7-EVM

 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7-evm.dts             | 23 +++++++++++++++++++++++
 arch/arm/boot/dts/dra7-iva-thermal.dtsi    | 28 ++++++++++++++++++++++++++++
 arch/arm/boot/dts/dra7.dtsi                | 27 ++++++++++++++++++++++++++-
 4 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/dra7-dspeve-thermal.dtsi
 create mode 100644 arch/arm/boot/dts/dra7-iva-thermal.dtsi

-- 
1.8.2.1.342.gfa7285d


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
