From: Wei Ni <wni@nvidia.com>
Date: Thu, 04 Jul 2013 09:09:37 +0000
Subject: [lm-sensors] [PATCH 0/2] Enable lm90 in Tegra30 and Tegra114.
Message-Id: <1372928979-26938-1-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org
Cc: MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Enable thermal sensor lm90 for Tegra30 Cardhu and Tegra114 Dalmore.

This series is v1, based on [RFC 1/9] submitted here:
http://thread.gmane.org/gmane.linux.power-management.general/31056

Changes from RFC:
1. Enable it for Tegra114 Dalmore.

Wei Ni (2):
  ARM: dt: t30 cardhu: add dt entry for lm90
  ARM: dt: t114 dalmore: add dt entry for lm90

 arch/arm/boot/dts/tegra114-dalmore.dts |    7 +++++++
 arch/arm/boot/dts/tegra30-cardhu.dtsi  |    7 +++++++
 2 files changed, 14 insertions(+)

-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
