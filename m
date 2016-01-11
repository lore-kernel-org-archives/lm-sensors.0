From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 11 Jan 2016 04:15:24 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for v4.5
Message-Id: <1452485724-3889-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon updates for Linux v4.5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.5

Thanks,
Guenter
------

The following changes since commit a3a316cfc41ab3e7b9e0079338f8ea9dff911d88:

  hwmon: (sht15) Select CONFIG_BITREVERSE (2015-12-18 08:19:52 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.5

for you to fetch changes up to 91918d13eb17b8c11a9b6b76bfdd7cc0efab4f50:

  hwmon: (nct6683) Add basic support for NCT6683 on Mitac boards (2016-01-09 07:31:58 -0800)

----------------------------------------------------------------
Notable hwmon updates for v4.5:

Add basic support for NCT6683 on Mitac boards
Add support for AMD new 15h processors to fam15h_power driver
Add pmbus client driver for LTC3815
Remove htu21 driver (now supported by iio subsystem)

----------------------------------------------------------------
Guenter Roeck (3):
      hwmon: (htu21) Remove driver
      hwmon: (pmbus) Add client driver for LTC3815
      hwmon: (nct6683) Add basic support for NCT6683 on Mitac boards

Huang Rui (2):
      hwmon: (fam15h_power) Add support for AMD new 15h processors
      MAINTAINERS: change the maintainer of fam15h_power driver

Julia Lawall (2):
      hwmon: (nct6683,nct6775) constify sensor_template_group structures
      hwmon: (ibmaem) constify aem_rw_sensor_template and aem_ro_sensor_template structures

 CREDITS                       |   8 ++
 Documentation/hwmon/htu21     |  46 ---------
 Documentation/hwmon/ltc3815   |  61 ++++++++++++
 MAINTAINERS                   |   4 +-
 drivers/hwmon/Kconfig         |  10 --
 drivers/hwmon/Makefile        |   1 -
 drivers/hwmon/fam15h_power.c  |   7 +-
 drivers/hwmon/htu21.c         | 174 ----------------------------------
 drivers/hwmon/ibmaem.c        |  12 +--
 drivers/hwmon/nct6683.c       |  89 ++++++++++++-----
 drivers/hwmon/nct6775.c       |  11 ++-
 drivers/hwmon/pmbus/Kconfig   |  10 ++
 drivers/hwmon/pmbus/Makefile  |   1 +
 drivers/hwmon/pmbus/ltc3815.c | 215 ++++++++++++++++++++++++++++++++++++++++++
 14 files changed, 381 insertions(+), 268 deletions(-)
 delete mode 100644 Documentation/hwmon/htu21
 create mode 100644 Documentation/hwmon/ltc3815
 delete mode 100644 drivers/hwmon/htu21.c
 create mode 100644 drivers/hwmon/pmbus/ltc3815.c

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
