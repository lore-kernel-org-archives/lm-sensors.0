From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Tue, 19 Jul 2011 20:00:30 +0000
Subject: [lm-sensors] [PATCH 0/5] Support for the TS-5500 board
Message-Id: <1311105635-22432-1-git-send-email-vivien.didelot@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: Vivien Didelot <vivien.didelot@savoirfairelinux.com>, lm-sensors@lm-sensors.org, platform-driver-x86@vger.kernel.org

This set of patches brings the support for the Technologic Systems TS-5500
Single Board Computer.

The first patch adds the base for the support of the board in
/arch/x86/platform/ts5500 and a documentation file in
Documentation/ABI/testing/sysfs-platform-ts5500.

The second patch adds support for GPIO.

The third patch adds support for the on-board LED.

The fourth patch brings support for the Analogic/Digital converter.

The fifth patch moves the already existing support for the Flash MTD into the
/arch/x86/platform/ts5500 directory.

Jerome Oufella (1):
  gpio: add support for TS-5500 GPIO

Jonas Fonseca (2):
  leds: add support for TS-5500 LED
  adc: add support for TS-5500 ADC

Vivien Didelot (2):
  x86: base support for TS-5500 Single Board Computer
  mtd: move support for TS-5500 MTD

 Documentation/ABI/testing/sysfs-platform-ts5500 |   46 +++
 MAINTAINERS                                     |   13 +
 arch/x86/Kconfig                                |    2 +
 arch/x86/platform/Makefile                      |    1 +
 arch/x86/platform/ts5500/Kconfig                |   47 +++
 arch/x86/platform/ts5500/Makefile               |    5 +
 arch/x86/platform/ts5500/ts5500.c               |  440 +++++++++++++++++++++++
 arch/x86/platform/ts5500/ts5500_adc.c           |  326 +++++++++++++++++
 arch/x86/platform/ts5500/ts5500_adc.h           |   62 ++++
 arch/x86/platform/ts5500/ts5500_flash.c         |  118 ++++++
 arch/x86/platform/ts5500/ts5500_gpio.c          |  421 ++++++++++++++++++++++
 arch/x86/platform/ts5500/ts5500_gpio.h          |   60 +++
 arch/x86/platform/ts5500/ts5500_leds.c          |  133 +++++++
 drivers/mtd/maps/Kconfig                        |   18 -
 drivers/mtd/maps/Makefile                       |    1 -
 drivers/mtd/maps/ts5500_flash.c                 |  121 -------
 16 files changed, 1674 insertions(+), 140 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-platform-ts5500
 create mode 100644 arch/x86/platform/ts5500/Kconfig
 create mode 100644 arch/x86/platform/ts5500/Makefile
 create mode 100644 arch/x86/platform/ts5500/ts5500.c
 create mode 100644 arch/x86/platform/ts5500/ts5500_adc.c
 create mode 100644 arch/x86/platform/ts5500/ts5500_adc.h
 create mode 100644 arch/x86/platform/ts5500/ts5500_flash.c
 create mode 100644 arch/x86/platform/ts5500/ts5500_gpio.c
 create mode 100644 arch/x86/platform/ts5500/ts5500_gpio.h
 create mode 100644 arch/x86/platform/ts5500/ts5500_leds.c
 delete mode 100644 drivers/mtd/maps/ts5500_flash.c

-- 
1.7.6


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
