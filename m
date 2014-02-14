From: Laszlo Papp <lpapp@kde.org>
Date: Fri, 14 Feb 2014 09:15:40 +0000
Subject: [lm-sensors] [RFC PATCH 0/2] Redesign the MAX6650-6651 driver to be more flexible
Message-Id: <1392369342-11472-1-git-send-email-lpapp@kde.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.de, linux@roeck-us.net
Cc: lm-sensors@lm-sensors.org, lee.jones@linaro.org, lpapp@kde.org, linux-kernel@vger.kernel.org

Yet to be run-time tested, but early reviews are welcome to catch any obvious
mistakes that are potentially hard and time-consuming to debug.

Laszlo Papp (2):
  mfd: MAX6650/6651 support
  hwmon: (max6650) Convert to be a platform driver

 drivers/hwmon/Kconfig               |   2 +-
 drivers/hwmon/max6650.c             | 125 ++++++++++++++++++------------------
 drivers/mfd/Kconfig                 |  11 ++++
 drivers/mfd/Makefile                |   1 +
 drivers/mfd/max665x.c               |  94 +++++++++++++++++++++++++++
 include/linux/mfd/max665x-private.h |  34 ++++++++++
 6 files changed, 203 insertions(+), 64 deletions(-)
 create mode 100644 drivers/mfd/max665x.c
 create mode 100644 include/linux/mfd/max665x-private.h

-- 
1.8.5.4


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
