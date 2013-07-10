From: Wei Ni <wni@nvidia.com>
Date: Wed, 10 Jul 2013 11:25:36 +0000
Subject: [lm-sensors] [PATCH v2 0/3] Lm90 Enhancements
Message-Id: <1373455539-2831-1-git-send-email-wni@nvidia.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Cc: lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Wei Ni <wni-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

This patch set enhance the lm90 driver,
it make the driver more readable and easier to use thermal framework.

This series is v2, previous version patches:
[RFC]: http://thread.gmane.org/gmane.linux.power-management.general/31056
[v1]: http://thread.gmane.org/gmane.linux.ports.tegra/11710/

Changes from v1:
1. change the string "irq" to "IRQ"
2. add macro defines for the alarm status
3. consider the shared IRQ.

Changes from RFC:
1. change _show_temp() to read_temp(), _set_temp() to write_temp().
2. simply return value for the read_temp(), not use pointer.
3. use devm_request_threaded_irq() to request irq and set flag IRQF_ONESHOT.

Wei Ni (3):
  hwmon: (lm90) split set&show temp as common codes
  hwmon: (lm90) add support to handle IRQ.
  hwmon: (lm90) use enums for the indexes of temp8 and temp11

 drivers/hwmon/lm90.c |  374 ++++++++++++++++++++++++++++++++++----------------
 1 file changed, 253 insertions(+), 121 deletions(-)

-- 
1.7.9.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
