From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 14 Mar 2016 13:51:33 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for v4.6
Message-Id: <1457963493-24735-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon updates for Linux v4.6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.6

Thanks,
Guenter
------

The following changes since commit fc77dbd34c5c99bce46d40a2491937c3bcbd10af:

  Linux 4.5-rc6 (2016-02-28 08:41:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.6

for you to fetch changes up to 630300d5fcb6ee9c32c75d8b576c100fbb794159:

  hwmon: Create an NSA320 hardware monitoring driver (2016-03-08 18:40:49 -0800)

----------------------------------------------------------------
hwmon updates for v4.5:

- New drivers for NSA320 and LTC2990
- Added support for ADM1278 to adm1275 driver
- Added support for ncpXXxh103 to ntc_thermistor driver
- Renamed vexpress hwmon implementation
- Minor cleanups and improvements

----------------------------------------------------------------
Adam Baker (2):
      hwmon: Define binding for the nsa320-hwmon driver
      hwmon: Create an NSA320 hardware monitoring driver

Guenter Roeck (1):
      hwmon: (adm1275) Add support for ADM1278

Joseph McNally (1):
      hwmon: (ntc_thermistor) Add support for ncpXXxh103

Masanari Iida (1):
      Doc: hwmon: Fix typo "montoring" in hwmon

Mike Looijmans (1):
      hwmon: Add LTC2990 sensor driver

Sanchayan Maity (3):
      hwmon: (iio_hwmon) Allow the driver to accept hypen in device tree node names
      ARM: dts: Change iio_hwmon nodes to use hypen in node names
      ARM: dts: vfxxx: Add iio_hwmon node for ADC temperature channel

Sudeep Holla (1):
      hwmon: (vexpress) rename vexpress hwmon implementation

 .../devicetree/bindings/hwmon/nsa320-mcu.txt       |  20 ++
 .../devicetree/bindings/hwmon/ntc_thermistor.txt   |   1 +
 .../devicetree/bindings/iio/iio-bindings.txt       |   2 +-
 Documentation/hwmon/adm1275                        |  29 ++-
 Documentation/hwmon/lm25066                        |   2 +-
 Documentation/hwmon/ltc2990                        |  43 +++++
 Documentation/hwmon/max16064                       |   2 +-
 Documentation/hwmon/max34440                       |   2 +-
 Documentation/hwmon/max8688                        |   2 +-
 Documentation/hwmon/nsa320                         |  53 +++++
 Documentation/hwmon/ntc_thermistor                 |   4 +-
 Documentation/hwmon/pmbus                          |   2 +-
 Documentation/hwmon/zl6100                         |   2 +-
 arch/arm/boot/dts/imx23.dtsi                       |   2 +-
 arch/arm/boot/dts/imx28.dtsi                       |   2 +-
 arch/arm/boot/dts/vfxxx.dtsi                       |   5 +
 drivers/hwmon/Kconfig                              |  31 ++-
 drivers/hwmon/Makefile                             |   4 +-
 drivers/hwmon/iio_hwmon.c                          |  11 +-
 drivers/hwmon/ltc2990.c                            | 161 +++++++++++++++
 drivers/hwmon/nsa320-hwmon.c                       | 215 +++++++++++++++++++++
 drivers/hwmon/ntc_thermistor.c                     |  44 +++++
 drivers/hwmon/pmbus/Kconfig                        |   4 +-
 drivers/hwmon/pmbus/adm1275.c                      |  56 +++++-
 drivers/hwmon/{vexpress.c => vexpress-hwmon.c}     |   0
 include/linux/platform_data/ntc_thermistor.h       |   1 +
 26 files changed, 677 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/nsa320-mcu.txt
 create mode 100644 Documentation/hwmon/ltc2990
 create mode 100644 Documentation/hwmon/nsa320
 create mode 100644 drivers/hwmon/ltc2990.c
 create mode 100644 drivers/hwmon/nsa320-hwmon.c
 rename drivers/hwmon/{vexpress.c => vexpress-hwmon.c} (100%)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
