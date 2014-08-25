From: Wei Ni <wni@nvidia.com>
Date: Mon, 25 Aug 2014 06:29:44 +0000
Subject: [lm-sensors] [PATCH v3 0/4] expose lm90 to thermal fw
Message-Id: <1408948188-4181-1-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Expose lm90 to thermal framework via DT nodes.

This series is v3, previous version patches are:
[v2]: https://lkml.org/lkml/2014/3/4/194

Changes from v2:
add more description in documentation, per Stephen's comment.

Changes from v1:
1. remove the unnecessary log messages, per Guenter's request.
2. add thermal zones node for nct1008 on dalmore.

Wei Ni (1):
  thermal: add more description for thermal-zones

lightning314 (3):
  hwmon: (lm90) split set&show temp as common codes
  hwmon: lm90: expose to thermal fw via DT nodes
  ARM: tegra: dalmore: add thermal zones for nct1008

 .../devicetree/bindings/thermal/thermal.txt        |  10 +-
 arch/arm/boot/dts/tegra114-dalmore.dts             |  20 +-
 drivers/hwmon/lm90.c                               | 222 ++++++++++++++++-----
 3 files changed, 192 insertions(+), 60 deletions(-)

-- 
1.8.1.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
