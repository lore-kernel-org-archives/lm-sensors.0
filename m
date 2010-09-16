From: Keerthy <j-keerthy@ti.com>
Date: Thu, 16 Sep 2010 10:35:10 +0000
Subject: [lm-sensors] [PATCH 0/2] twl4030-madc driver
Message-Id: <1284632590-25266-1-git-send-email-j-keerthy@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-omap@vger.kernel.org, lm-sensors@lm-sensors.org
Cc: j-keerthy@ti.com, balajitk@ti.com

MADC(Monitoring ADC) driver enables monitoring analog signals using 
analog-to-digital conversion (ADC) on the input source. The MADC driver
is being added under the Hwmon class of drivers. 
To get the context, the last set of comments can be found here:
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg19981.html

Several people have contributed to this driver on the linux-omap list.

Keerthy (2):
  hwmon: twl4030: Driver for twl4030 madc module
  Makefile and Kconfig changes for twl4030-madc driver

 arch/arm/mach-omap2/Kconfig      |    4 +
 drivers/hwmon/Kconfig            |    4 +
 drivers/hwmon/Makefile           |    1 +
 drivers/hwmon/twl4030-madc.c     |  584 ++++++++++++++++++++++++++++++++++++++
 include/linux/i2c/twl4030-madc.h |  118 ++++++++
 5 files changed, 711 insertions(+), 0 deletions(-)
 create mode 100644 drivers/hwmon/twl4030-madc.c
 create mode 100644 include/linux/i2c/twl4030-madc.h


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
