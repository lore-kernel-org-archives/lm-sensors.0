From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Wed, 01 Feb 2012 21:05:39 +0000
Subject: [lm-sensors] [PATCH v5 0/5] Support for the TS-5500 platform
Message-Id: <1328130344-18836-1-git-send-email-vivien.didelot@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: x86@kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, Guenter Roeck <guenter.roeck@ericsson.com>, Jean Delvare <khali@linux-fr.org>

This patchset brings the support for the TS-5500 platform.

The first patch adds the base support for the board in
/arch/x86/platform/ts5500, and a documentation file in
Documentation/ABI/testing/sysfs-platform-ts5500.

The second patch adds support for GPIO.

The third patch adds support for the on-board LED.

The fourth patch adds support to hwmon for the Maxim MAX197 A/D converter,
which is embedded on the TS-5500 platform, as suggested by Guenter Roeck.

The fifth patch brings support for the A/D converter. 


Jerome Oufella (1):
  x86/platform: (TS-5500) add GPIO support

Jonas Fonseca (1):
  x86/platform: (TS-5500) add LED support

Vivien Didelot (3):
  x86/platform: (TS-5500) add platform base support
  hwmon: add MAX197 support
  x86/platform: (TS-5500) add ADC support

 Documentation/ABI/testing/sysfs-platform-ts5500 |   46 +++
 Documentation/hwmon/max197                      |   54 +++
 MAINTAINERS                                     |    5 +
 arch/x86/Kconfig                                |    2 +
 arch/x86/platform/Makefile                      |    1 +
 arch/x86/platform/ts5500/Kconfig                |   29 ++
 arch/x86/platform/ts5500/Makefile               |    4 +
 arch/x86/platform/ts5500/ts5500.c               |  299 ++++++++++++++
 arch/x86/platform/ts5500/ts5500.h               |   35 ++
 arch/x86/platform/ts5500/ts5500_adc.c           |  104 +++++
 arch/x86/platform/ts5500/ts5500_gpio.c          |  478 +++++++++++++++++++++++
 arch/x86/platform/ts5500/ts5500_gpio.h          |   60 +++
 arch/x86/platform/ts5500/ts5500_led.c           |  179 +++++++++
 drivers/hwmon/Kconfig                           |    9 +
 drivers/hwmon/Makefile                          |    1 +
 drivers/hwmon/max197.c                          |  403 +++++++++++++++++++
 include/linux/max197.h                          |   22 +
 17 files changed, 1731 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-ts5500
 create mode 100644 Documentation/hwmon/max197
 create mode 100644 arch/x86/platform/ts5500/Kconfig
 create mode 100644 arch/x86/platform/ts5500/Makefile
 create mode 100644 arch/x86/platform/ts5500/ts5500.c
 create mode 100644 arch/x86/platform/ts5500/ts5500.h
 create mode 100644 arch/x86/platform/ts5500/ts5500_adc.c
 create mode 100644 arch/x86/platform/ts5500/ts5500_gpio.c
 create mode 100644 arch/x86/platform/ts5500/ts5500_gpio.h
 create mode 100644 arch/x86/platform/ts5500/ts5500_led.c
 create mode 100644 drivers/hwmon/max197.c
 create mode 100644 include/linux/max197.h

-- 
1.7.6.5


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
