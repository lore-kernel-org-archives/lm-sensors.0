From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 26 Nov 2005 20:02:26 +0000
Subject: [lm-sensors] [PATCH 00/25] i2c and hwmon updates
Message-Id: <20051126200322.7c926b0a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a 25-piece i2c and hwmon update patchset. There are
individual driver fixes or improvements, a new hardware monitoring
driver, and a number of i2c core cleanups, which affect all i2c chip
drivers. None of these are meant for Linux 2.6.15. I'd like you to have
them included in the next -mm releases so that they get some testing,
and can then be merged in Linux 2.6.16.

The most important part here is certainly the i2c core cleanup. There
are three distinct changes:
* Removal of i2c_driver.flags (3 patches, incremental)
* Removal of i2c_driver.{owner,name} (11 patches, not incremental)
* Removal of I2C_CLIENT_ALLOW_USE and I2C_CLIENT_ALLOW_MULTIPLE_USE (3
  patches, incremental)

Here's the summary:

Jean Delvare:
 o Support the VRM 10 mode of the ADT7463
 o i2c: I2C_DF_DUMMY cleanups
 o i2c: I2C_DF_NOTIFY removal
 o i2c: Drop i2c_driver.flags
 o i2c: I2C_CLIENT_ALLOW_MULTIPLE_USE removal
 o i2c: I2C_CLIENT_ALLOW_USE removal
 o i2c: Allow unlimited i2c_client.usage_count by default
 o i2c: Chip driver porting guide update
 o i2c: i2c_get_client is gone

Laurent Riffard:
 o i2c: Drop i2c_driver.{owner,name}

Mark M. Hoffman:
 o Clarify the W83627THF VID documentation

Nicolas Kaiser:
 o Remove duplicate rtc8564 BCD macros

Peter Korsgaard:
 o Add support for Barco LTP->DVI to i2c-parport

Roger Lucas:
 o New vt8231 hardware monitoring driver

Yuan Mu:
 o W83627THF VID fixes

Statistics:

 Documentation/hwmon/w83627hf                   |   19 +
 Documentation/i2c/busses/i2c-parport           |    1 +
 Documentation/i2c/porting-clients              |   91 ++-
 Documentation/i2c/writing-clients              |   11 -
 MAINTAINERS                                    |    6 +
 arch/arm/mach-pxa/akita-ioexp.c                |    8 
 drivers/acorn/char/pcf8583.c                   |    6 +
 drivers/hwmon/Kconfig                          |   12 +
 drivers/hwmon/Makefile                         |    1 +
 drivers/hwmon/adm1021.c                        |    7 +
 drivers/hwmon/adm1025.c                        |    7 +
 drivers/hwmon/adm1026.c                        |    7 +
 drivers/hwmon/adm1031.c                        |    7 +
 drivers/hwmon/adm9240.c                        |    7 +
 drivers/hwmon/asb100.c                         |    7 +
 drivers/hwmon/atxp1.c                          |    7 +
 drivers/hwmon/ds1621.c                         |    7 +
 drivers/hwmon/fscher.c                         |    7 +
 drivers/hwmon/fscpos.c                         |    7 +
 drivers/hwmon/gl518sm.c                        |    7 +
 drivers/hwmon/gl520sm.c                        |    7 +
 drivers/hwmon/it87.c                           |   16 +
 drivers/hwmon/lm63.c                           |    7 +
 drivers/hwmon/lm75.c                           |    7 +
 drivers/hwmon/lm77.c                           |    7 +
 drivers/hwmon/lm78.c                           |   15 +
 drivers/hwmon/lm80.c                           |    7 +
 drivers/hwmon/lm83.c                           |    7 +
 drivers/hwmon/lm85.c                           |   51 +
 drivers/hwmon/lm87.c                           |    7 +
 drivers/hwmon/lm90.c                           |    7 +
 drivers/hwmon/lm92.c                           |    7 +
 drivers/hwmon/max1619.c                        |    7 +
 drivers/hwmon/pc87360.c                        |    8 +
 drivers/hwmon/sis5595.c                        |    9 +
 drivers/hwmon/smsc47b397.c                     |    9 +
 drivers/hwmon/smsc47m1.c                       |    8 +
 drivers/hwmon/via686a.c                        |    9 +
 drivers/hwmon/vt8231.c                         |  863 ++++++++++++++++++++++++
 drivers/hwmon/w83627ehf.c                      |    8 +
 drivers/hwmon/w83627hf.c                       |   24 
 drivers/hwmon/w83781d.c                        |   15 +
 drivers/hwmon/w83792d.c                        |    7 +
 drivers/hwmon/w83l785ts.c                      |    7 +
 drivers/i2c/busses/i2c-isa.c                   |    4 -
 drivers/i2c/busses/i2c-parport.h               |   12 +
 drivers/i2c/chips/ds1337.c                     |    7 +
 drivers/i2c/chips/ds1374.c                     |    7 +
 drivers/i2c/chips/eeprom.c                     |    7 +
 drivers/i2c/chips/isp1301_omap.c               |    7 +
 drivers/i2c/chips/m41t00.c                     |    7 +
 drivers/i2c/chips/max6875.c                    |    7 +
 drivers/i2c/chips/pca9539.c                    |    7 +
 drivers/i2c/chips/pcf8574.c                    |    7 +
 drivers/i2c/chips/pcf8591.c                    |    7 +
 drivers/i2c/chips/rtc8564.c                    |   44 -
 drivers/i2c/chips/tps65010.c                   |    7 +
 drivers/i2c/chips/x1205.c                      |    7 +
 drivers/i2c/i2c-core.c                         |   57 +-
 drivers/i2c/i2c-dev.c                          |    7 +
 drivers/macintosh/therm_adt746x.c              |    7 +
 drivers/macintosh/therm_pm72.c                 |    7 +
 drivers/macintosh/therm_windtunnel.c           |    7 +
 drivers/macintosh/windfarm_lm75_sensor.c       |    7 +
 drivers/media/video/adv7170.c                  |    8 
 drivers/media/video/adv7175.c                  |    8 
 drivers/media/video/bt819.c                    |    8 
 drivers/media/video/bt832.c                    |    8 
 drivers/media/video/bt856.c                    |    8 
 drivers/media/video/bttv-i2c.c                 |    2 
 drivers/media/video/cs53l32a.c                 |   15 +
 drivers/media/video/cx25840/cx25840-core.c     |    8 
 drivers/media/video/cx25840/cx25840.h          |    7 +
 drivers/media/video/cx88/cx88-i2c.c            |    2 
 drivers/media/video/em28xx/em28xx-i2c.c        |    1 -
 drivers/media/video/indycam.c                  |    7 +
 drivers/media/video/ir-kbd-i2c.c               |    6 +
 drivers/media/video/msp3400.c                  |   21 +
 drivers/media/video/ovcamchip/ovcamchip_core.c |    7 +
 drivers/media/video/saa5246a.c                 |    7 +
 drivers/media/video/saa5249.c                  |    7 +
 drivers/media/video/saa6588.c                  |    8 
 drivers/media/video/saa7110.c                  |    8 
 drivers/media/video/saa7111.c                  |    8 
 drivers/media/video/saa7114.c                  |    8 
 drivers/media/video/saa7115.c                  |   15 +
 drivers/media/video/saa711x.c                  |    8 
 drivers/media/video/saa7127.c                  |   18 +
 drivers/media/video/saa7134/saa6752hs.c        |    8 
 drivers/media/video/saa7134/saa7134-i2c.c      |    4 
 drivers/media/video/saa7185.c                  |    8 
 drivers/media/video/saa7191.c                  |    7 +
 drivers/media/video/tda7432.c                  |    7 +
 drivers/media/video/tda9840.c                  |    7 +
 drivers/media/video/tda9875.c                  |    7 +
 drivers/media/video/tda9887.c                  |    6 -
 drivers/media/video/tea6415c.c                 |    7 +
 drivers/media/video/tea6420.c                  |    7 +
 drivers/media/video/tuner-3036.c               |    7 +
 drivers/media/video/tuner-core.c               |    8 -
 drivers/media/video/tvaudio.c                  |    8 
 drivers/media/video/tveeprom.c                 |    8 
 drivers/media/video/tvmixer.c                  |   13 -
 drivers/media/video/tvp5150.c                  |    8 
 drivers/media/video/vpx3220.c                  |    8 
 drivers/media/video/wm8775.c                   |   12 
 drivers/media/video/zoran_driver.c             |   14 
 drivers/usb/media/w9968cf.c                    |    4 
 drivers/video/matrox/matroxfb_maven.c          |    7 +
 include/linux/i2c.h                            |   34 -
 include/media/tuner.h                          |    7 +
 sound/oss/dmasound/dac3550a.c                  |    7 +
 sound/oss/dmasound/tas_common.c                |    7 +
 sound/ppc/keywest.c                            |    6 +
 114 files changed, 1496 insertions(+), 513 deletions(-)

Thanks,
-- 
Jean Delvare
