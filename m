From: Linus Walleij <linus.walleij@stericsson.com>
Date: Tue, 18 Oct 2011 09:09:48 +0000
Subject: [lm-sensors] [PATCH 0/3] ST-Ericsson ABx500 hwmon driver
Message-Id: <1318928988-15780-1-git-send-email-linus.walleij@stericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

From: Linus Walleij <linus.walleij@linaro.org>

This is an initial submission of the ST-Ericsson ABx500 HWMON
driver core, used by the included AB8500 driver but also the
upcoming AB5500 driver.

I will make necessary adjustments to the patch set, however
the principal authors are set as patch authors for this.

Daniel Willerud (2):
  hwmon: add notifiers to hwmon
  hwmon/abx500: add hwmon notifications

Martin Persson (1):
  hwmon: add driver for ABx500 chips

 drivers/hwmon/Kconfig     |   13 +
 drivers/hwmon/Makefile    |    1 +
 drivers/hwmon/ab8500.c    |  179 ++++++++++++
 drivers/hwmon/abx500.c    |  693 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/abx500.h    |   90 ++++++
 drivers/hwmon/hwmon.c     |   21 ++-
 drivers/mfd/ab8500-core.c |    4 +-
 include/linux/hwmon.h     |    5 +
 8 files changed, 1003 insertions(+), 3 deletions(-)
 create mode 100644 drivers/hwmon/ab8500.c
 create mode 100644 drivers/hwmon/abx500.c
 create mode 100644 drivers/hwmon/abx500.h

-- 
1.7.3.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
