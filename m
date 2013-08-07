From: Wei Ni <wni@nvidia.com>
Date: Wed, 07 Aug 2013 06:52:36 +0000
Subject: [lm-sensors] [PATCH 0/2] Add power control for lm90
Message-Id: <1375858358-15070-1-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

The device lm90 can be controlled by the vdd rail.
Add function to power on/off the vdd.
Enable the nct1008 on Tegra114 Dalmore board, and set the vdd-regulator.

Wei Ni (2):
  hwmon: (lm90) Add power control
  ARM: dt: t114 dalmore: add dt entry for nct1008

 arch/arm/boot/dts/tegra114-dalmore.dts |   10 +++++-
 drivers/hwmon/lm90.c                   |   52 ++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 1 deletion(-)

-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
