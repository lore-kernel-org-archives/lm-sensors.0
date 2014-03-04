From: Wei Ni <wni@nvidia.com>
Date: Tue, 04 Mar 2014 11:31:01 +0000
Subject: [lm-sensors] [PATCH v2 0/3] expose lm90 to thermal fw
Message-Id: <1393932664-13319-1-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Expose lm90 to thermal framework via DT nodes.

Changes from v1:
1. remove the unnecessary log messages, per Guenter's request.
2. add thermal zones node for nct1008 on dalmore.

Wei Ni (3):
  hwmon: (lm90) split set&show temp as common codes
  hwmon: lm90: expose to thermal fw via DT nodes
  ARM: tegra: dalmore: add thermal zones for nct1008

 arch/arm/boot/dts/tegra114-dalmore.dts |   20 ++-
 drivers/hwmon/lm90.c                   |  222 ++++++++++++++++++++++++--------
 2 files changed, 186 insertions(+), 56 deletions(-)

-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
