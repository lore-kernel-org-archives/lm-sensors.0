From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Fri, 29 Apr 2011 22:21:47 +0000
Subject: [lm-sensors] [RFC 0/5] Support for Technologic Systems TS-5500 board
Message-Id: <1304115712-5299-1-git-send-email-vivien.didelot@savoirfairelinux.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-kernel@vger.kernel.org
Cc: platform-driver-x86@vger.kernel.org, linux-serial@vger.kernel.org, lm-sensors@lm-sensors.org

This set of patches is a request for comments. It brings the complete support
for the TS-5500 Single Board Computer from Technologic Systems.

The first patch adds detection for TS-5xxx boards (it also works for TS-3xxx
boards).

The second patch adds GPIO support.

The third patch adds support for the RS-485 feature of the ts-5500 SBC.

The fourth patch adds support for the TS-5500 LEDs.

The fifth patch adds support for the analogic to digital converter feature of
the board.

Jerome Oufella (1):
  gpio: add support for Technologic Systems TS-5500 GPIOs

Jonas Fonseca (3):
  platform-drivers-x86: add support for Technologic Systems TS-5xxx
    detection
  leds: add support for Technologic Systems TS-5500 leds
  hwmon: add support for Technologic Systems TS-5500 A-D converter

Vivien Didelot (1):
  serial: add support for Technologic Systems TS-5500 RS-485 serial
    port

 Documentation/ts5xxx-sbcinfo.txt      |   47 +++
 MAINTAINERS                           |   11 +
 drivers/gpio/Kconfig                  |   10 +
 drivers/gpio/Makefile                 |    1 +
 drivers/gpio/ts5500-gpio.c            |  528 +++++++++++++++++++++++++++++++++
 drivers/hwmon/Kconfig                 |   10 +
 drivers/hwmon/Makefile                |    1 +
 drivers/hwmon/ts5500-adc.c            |  481 ++++++++++++++++++++++++++++++
 drivers/leds/Kconfig                  |   12 +
 drivers/leds/Makefile                 |    1 +
 drivers/leds/leds-ts5500.c            |  211 +++++++++++++
 drivers/platform/x86/Kconfig          |   11 +
 drivers/platform/x86/Makefile         |    1 +
 drivers/platform/x86/ts5xxx-sbcinfo.c |  254 ++++++++++++++++
 drivers/tty/serial/8250.c             |   30 ++
 drivers/tty/serial/Kconfig            |   19 ++
 drivers/tty/serial/Makefile           |    1 +
 drivers/tty/serial/ts5500-auto485.c   |   45 +++
 include/linux/ts5500-gpio.h           |   68 +++++
 include/linux/ts5xxx-sbcinfo.h        |   42 +++
 20 files changed, 1784 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/ts5xxx-sbcinfo.txt
 create mode 100644 drivers/gpio/ts5500-gpio.c
 create mode 100644 drivers/hwmon/ts5500-adc.c
 create mode 100644 drivers/leds/leds-ts5500.c
 create mode 100644 drivers/platform/x86/ts5xxx-sbcinfo.c
 create mode 100644 drivers/tty/serial/ts5500-auto485.c
 create mode 100644 include/linux/ts5500-gpio.h
 create mode 100644 include/linux/ts5xxx-sbcinfo.h


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
