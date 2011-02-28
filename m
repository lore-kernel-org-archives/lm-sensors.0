From: Keerthy <j-keerthy@ti.com>
Date: Mon, 28 Feb 2011 06:17:27 +0000
Subject: [lm-sensors] [PATCH 0/2 v3] twl4030-madc driver
Message-Id: <1298873127-5582-1-git-send-email-j-keerthy@ti.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298872374-4878-1-git-send-email-j-keerthy@ti.com>
In-Reply-To: <1298872374-4878-1-git-send-email-j-keerthy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, sameo@linux.intel.com
Cc: mikko.k.ylinen@nokia.com, amit.kucheria@canonical.com, j-keerthy@ti.com, linux-omap@vger.kernel.org

MADC(Monitoring ADC) driver enables monitoring analog signals using
analog-to-digital conversion (ADC) on the input source.
The previous discussion concluded in keeping the generic ADC
functionality and the hwmon separate. The discussion can be found here:

http://www.mail-archive.com/linux-omap@vger.kernel.org/msg41805.html

Keerthy (2):
  hwmon: twl4030: Hwmon Driver for TWL4030 MADC
  mfd: twl4030: Driver for twl4030 madc module

 Documentation/hwmon/twl4030-madc-hwmon |   45 ++
 drivers/hwmon/Kconfig                  |   10 +
 drivers/hwmon/Makefile                 |    1 +
 drivers/hwmon/twl4030-madc-hwmon.c     |  153 ++++++
 drivers/mfd/Kconfig                    |   10 +
 drivers/mfd/Makefile                   |    1 +
 drivers/mfd/twl4030-madc.c             |  813 ++++++++++++++++++++++++++++++++
 include/linux/i2c/twl4030-madc.h       |  142 ++++++
 8 files changed, 1175 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/hwmon/twl4030-madc-hwmon
 create mode 100644 drivers/hwmon/twl4030-madc-hwmon.c
 create mode 100644 drivers/mfd/twl4030-madc.c
 create mode 100644 include/linux/i2c/twl4030-madc.h


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
