From: MyungJoo Ham <myungjoo.ham@samsung.com>
Date: Mon, 14 Nov 2011 08:10:42 +0000
Subject: [lm-sensors] [PATCH v2 0/2] HWMON: add in-kernel interfaces to read
Message-Id: <CAJ0PZbQu3N7Bs+ewf7vP=bN9B13xZSQYrnhqT733O1m5gEBqGg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org
Cc: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <guenter.roeck@ericsson.com>, dg77.kim@samsung.com, kyungmin.park@samsung.com, =?UTF-8?B?7ZWo66qF7KO8?= <myungjoo.ham@gmail.com>, Ben Hutchings <bhutchings@solarflare.com>

We have been reading hwmon values (TMU, the SoC-core temperature sensor,
and NTC, the ambient or battery surface temperature sensor) for
Charger-Manager. However, because hwmon does not have in-kernel interface,
we have been using undesired method, including "../../../fs/*.h".

This patch is to provide in-kernel interface for hwmon:
hwmon_get_value and hwmon_set_value. In order to use these two functions,
a) the hwmon driver should provide its sysfs attributes to hwmon framework,
and b) the hwmon_{get/set}_value caller should get the hwmon property pointer
with hwmon_find_device(dev) or hwmon_find_device_name(device-name).

A hwmon driver may provide its sysfs attributes with
hwmon_register_property(hwmon, attr) or
hwmon_register_properties(hwmon, attr_group)

In patch 2/2, we have added "register_property" for NTC-thermistor,
Exynos4-TMU, and S3C-HWMON drivers.

As soon as the server synchronizes git repositories, you can see how
hwmon_get_value() is used at:
http://git.infradead.org/users/kmpark/linux-2.6-samsung/shortlog/refs/heads/charger-manager


MyungJoo Ham (2):
  HWMON: add interfaces to read/write hwmon values inside kernel
  HWMON: support in-kernel HWMON API: NTC, S3C-HWMON, Exynos4-TMU

 drivers/hwmon/exynos4_tmu.c    |    2 +
 drivers/hwmon/hwmon.c          |  353 +++++++++++++++++++++++++++++++++++++++-
 drivers/hwmon/ntc_thermistor.c |    2 +
 drivers/hwmon/s3c-hwmon.c      |   10 +
 include/linux/hwmon.h          |   34 ++++
 5 files changed, 400 insertions(+), 1 deletions(-)

-- 
1.7.4.1

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
