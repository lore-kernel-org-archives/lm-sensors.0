From: Wei Ni <wni@nvidia.com>
Date: Thu, 04 Jul 2013 07:57:47 +0000
Subject: [lm-sensors] [PATCH 0/3] Lm90 Enhancements
Message-Id: <1372924670-16355-1-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, MLongnecker-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TZX6JHB/w77yyCwEArCW2h5@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This patch set enhance the lm90 driver,
it make the driver more readable and easier to use thermal framework.

This series is v1, based on [RFC 2/9], [RFC 3/9] and [RFC 4/9] submitted here:
http://thread.gmane.org/gmane.linux.power-management.general/31056

This series based on Rui's -thermal tree.

Changes from RFC:
1. change _show_temp() to read_temp(), _set_temp() to write_temp().
2. simply return value for the read_temp(), not use pointer.
3. use devm_request_threaded_irq() to request irq and set flag IRQF_ONESHOT.

Wei Ni (3):
  hwmon: (lm90) split set&show temp as common codes
  hwmon: (lm90) add support to handle irq
  hwmon: (lm90) use enums for the indexes of temp8 and temp11

 drivers/hwmon/lm90.c |  322 +++++++++++++++++++++++++++++++++-----------------
 1 file changed, 214 insertions(+), 108 deletions(-)

-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
