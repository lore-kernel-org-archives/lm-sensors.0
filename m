From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Wed, 30 Jan 2013 10:21:26 +0000
Subject: [lm-sensors] [PATCH 0/2] Add ST-Ericsson AB8500 HWMON driver
Message-Id: <1359541288-6657-1-git-send-email-hongbo.zhang@linaro.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux@roeck-us.net, khali@linux-fr.org, lm-sensors@lm-sensors.org, sameo@linux.intel.com
Cc: linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linaro-dev@lists.linaro.org, patches@linaro.org, linus.walleij@linaro.org, lee.jones@linaro.org, Hongbo Zhang <hongbo.zhang@linaro.org>

These patches are against the v3.8-rc4.

Guenter Roeck, Jean Delvare,
Please help to have a look at this.

Samuel Ortiz,
Please review 1/2 and leave your Acked-by: if no problem, I think these patches
should be merged into HWMON tree.

Thanks for all.

Hongbo Zhang (2):
  ARM: ux500: rename ab8500 to abx500 for hwmon driver
  hwmon: add ST-Ericsson ABX500 hwmon driver

 drivers/hwmon/Kconfig     |  13 +
 drivers/hwmon/Makefile    |   1 +
 drivers/hwmon/ab8500.c    | 160 +++++++++++
 drivers/hwmon/abx500.c    | 681 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/abx500.h    |  88 ++++++
 drivers/mfd/ab8500-core.c |   6 +-
 6 files changed, 946 insertions(+), 3 deletions(-)
 create mode 100644 drivers/hwmon/ab8500.c
 create mode 100644 drivers/hwmon/abx500.c
 create mode 100644 drivers/hwmon/abx500.h

-- 
1.8.0


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
