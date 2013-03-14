From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 14 Mar 2013 00:44:15 +0000
Subject: [lm-sensors] [PATCH 0/9] hwmon: Cleanup patches
Message-Id: <1363221864-15284-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Guenter Roeck (9):
      hwmon: checkpatch cleanup: Replace printk with pr_debug or dev_dbg as appropriate
      hwmon: Fix 'Macros with complex values' checkpatch errors
      hwmon: Fix CamelCase checkpatch warnings
      hwmon: Fix checkpatch warning 'quoted string split across lines'
      hwmon: (ina2xx) Fix 'Avoid unnecessary line continuations' checkpatch warning
      hwmon: (ltc4151) Fix 'Avoid unnecessary line continuations' checkpatch warning
      hwmon: (ltc4215) Fix 'Macros with complex values' checkpatch error
      hwmon: (ltc4245) Fix 'Macros with complex values' checkpatch error
      hwmon: (ltc4261) Fix 'Macros with complex values' checkpatch error

 drivers/hwmon/abituguru.c                    |   11 +-
 drivers/hwmon/abituguru3.c                   |   10 +-
 drivers/hwmon/ad7314.c                       |    3 +-
 drivers/hwmon/adm1021.c                      |   11 +-
 drivers/hwmon/adm1026.c                      |   53 +++----
 drivers/hwmon/adm1029.c                      |    9 +-
 drivers/hwmon/adm9240.c                      |    9 +-
 drivers/hwmon/ads7871.c                      |   42 ++---
 drivers/hwmon/adt7411.c                      |   10 +-
 drivers/hwmon/applesmc.c                     |    2 +-
 drivers/hwmon/asb100.c                       |   23 +--
 drivers/hwmon/asc7621.c                      |   56 +++----
 drivers/hwmon/coretemp.c                     |    3 +-
 drivers/hwmon/da9052-hwmon.c                 |   14 +-
 drivers/hwmon/da9055-hwmon.c                 |    4 +-
 drivers/hwmon/dme1737.c                      |   68 ++++----
 drivers/hwmon/f71805f.c                      |    3 +-
 drivers/hwmon/fam15h_power.c                 |    4 +-
 drivers/hwmon/fschmd.c                       |    9 +-
 drivers/hwmon/gl518sm.c                      |    5 +-
 drivers/hwmon/gpio-fan.c                     |    2 +-
 drivers/hwmon/ibmaem.c                       |   21 +--
 drivers/hwmon/ibmpex.c                       |   17 +-
 drivers/hwmon/ina2xx.c                       |   16 +-
 drivers/hwmon/it87.c                         |   24 +--
 drivers/hwmon/k8temp.c                       |    4 +-
 drivers/hwmon/lm78.c                         |   10 +-
 drivers/hwmon/lm80.c                         |    5 +-
 drivers/hwmon/lm85.c                         |    4 +-
 drivers/hwmon/lm93.c                         |   74 ++++-----
 drivers/hwmon/ltc4151.c                      |   12 +-
 drivers/hwmon/ltc4215.c                      |   46 +++---
 drivers/hwmon/ltc4245.c                      |  116 +++++++-------
 drivers/hwmon/ltc4261.c                      |   38 ++---
 drivers/hwmon/ntc_thermistor.c               |  216 +++++++++++++-------------
 drivers/hwmon/pc87360.c                      |   25 ++-
 drivers/hwmon/pc87427.c                      |   13 +-
 drivers/hwmon/s3c-hwmon.c                    |   19 +--
 drivers/hwmon/sch56xx-common.c               |   12 +-
 drivers/hwmon/sis5595.c                      |    5 +-
 drivers/hwmon/thmc50.c                       |    7 +-
 drivers/hwmon/tmp102.c                       |    4 +-
 drivers/hwmon/tmp401.c                       |    5 +-
 drivers/hwmon/tmp421.c                       |    7 +-
 drivers/hwmon/via686a.c                      |   47 +++---
 drivers/hwmon/vt1211.c                       |   23 +--
 drivers/hwmon/vt8231.c                       |    5 +-
 drivers/hwmon/w83627ehf.c                    |   31 ++--
 drivers/hwmon/w83781d.c                      |   36 +++--
 drivers/hwmon/w83791d.c                      |    4 +-
 drivers/hwmon/w83792d.c                      |   13 +-
 drivers/hwmon/w83793.c                       |    8 +-
 drivers/hwmon/w83795.c                       |    9 +-
 include/linux/platform_data/ntc_thermistor.h |    4 +-
 54 files changed, 620 insertions(+), 611 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
