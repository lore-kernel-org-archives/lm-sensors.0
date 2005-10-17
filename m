From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 17 Oct 2005 22:37:41 +0000
Subject: [lm-sensors] [PATCH 00/14] hwmon and i2c updates
Message-Id: <20051017223757.7fe6672c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a 14-piece hwmon and i2c update patchset. These are fixes I
gathered in the last few weeks or wrote myself. Details are given in
the header of each patch. None of these are meant for Linux 2.6.14. I'd
like you to have them included in the next -mm releases so that they get
enough testing and can be merged in Linux 2.6.15.

Here's the summary:

Alessandro Zummo:
 o New Xicor X1205 RTC driver

Deepak Saxena:
 o Mass kzalloc conversion

Jean Delvare:
 o Missing class check in two hwmon drivers
 o More kzalloc cleanups
 o i2c documentation update

Laurent Riffard:
 o Owner field additions to many i2c drivers

Mark M. Hoffman:
 o New device ID for the smsc47b397 driver

Statistics:

 Documentation/hwmon/smsc47b397        |    8 +
 Documentation/i2c/chips/x1205         |   38 ++
 Documentation/i2c/porting-clients     |    2 
 Documentation/i2c/writing-clients     |   16 -
 drivers/hwmon/adm1021.c               |    3 -
 drivers/hwmon/adm1025.c               |    3 -
 drivers/hwmon/adm1026.c               |    4 -
 drivers/hwmon/adm1031.c               |    3 -
 drivers/hwmon/asb100.c                |   11 -
 drivers/hwmon/atxp1.c                 |    5 +
 drivers/hwmon/ds1621.c                |    5 +
 drivers/hwmon/fscher.c                |    3 -
 drivers/hwmon/fscpos.c                |    3 -
 drivers/hwmon/gl518sm.c               |    3 -
 drivers/hwmon/gl520sm.c               |    3 -
 drivers/hwmon/it87.c                  |    3 -
 drivers/hwmon/lm63.c                  |    3 -
 drivers/hwmon/lm75.c                  |    3 -
 drivers/hwmon/lm77.c                  |    3 -
 drivers/hwmon/lm78.c                  |    3 -
 drivers/hwmon/lm80.c                  |    3 -
 drivers/hwmon/lm83.c                  |    3 -
 drivers/hwmon/lm85.c                  |    3 -
 drivers/hwmon/lm87.c                  |    3 -
 drivers/hwmon/lm90.c                  |    3 -
 drivers/hwmon/lm92.c                  |    3 -
 drivers/hwmon/max1619.c               |    3 -
 drivers/hwmon/pc87360.c               |    3 -
 drivers/hwmon/sis5595.c               |    3 -
 drivers/hwmon/smsc47b397.c            |   10 
 drivers/hwmon/smsc47m1.c              |    3 -
 drivers/hwmon/via686a.c               |    3 -
 drivers/hwmon/w83627ehf.c             |    3 -
 drivers/hwmon/w83627hf.c              |    3 -
 drivers/hwmon/w83781d.c               |   10 -
 drivers/hwmon/w83792d.c               |    6 -
 drivers/hwmon/w83l785ts.c             |    4 -
 drivers/i2c/busses/i2c-ali1535.c      |    1 +
 drivers/i2c/busses/i2c-ali1563.c      |    1 +
 drivers/i2c/busses/i2c-ali15x3.c      |    1 +
 drivers/i2c/busses/i2c-amd756-s4882.c |    4 
 drivers/i2c/busses/i2c-amd756.c       |    1 +
 drivers/i2c/busses/i2c-amd8111.c      |    4 
 drivers/i2c/busses/i2c-hydra.c        |    1 +
 drivers/i2c/busses/i2c-i801.c         |    1 +
 drivers/i2c/busses/i2c-i810.c         |    1 +
 drivers/i2c/busses/i2c-ibm_iic.c      |    3 -
 drivers/i2c/busses/i2c-iop3xx.c       |    7 -
 drivers/i2c/busses/i2c-isa.c          |    1 +
 drivers/i2c/busses/i2c-ixp2000.c      |    4 
 drivers/i2c/busses/i2c-ixp4xx.c       |    4 
 drivers/i2c/busses/i2c-keywest.c      |    5 +
 drivers/i2c/busses/i2c-mpc.c          |    4 
 drivers/i2c/busses/i2c-mv64xxx.c      |    6 -
 drivers/i2c/busses/i2c-nforce2.c      |    5 -
 drivers/i2c/busses/i2c-parport.c      |    5 -
 drivers/i2c/busses/i2c-piix4.c        |    1 +
 drivers/i2c/busses/i2c-pmac-smu.c     |    3 -
 drivers/i2c/busses/i2c-prosavage.c    |    5 -
 drivers/i2c/busses/i2c-s3c2410.c      |    2 +
 drivers/i2c/busses/i2c-savage4.c      |    1 +
 drivers/i2c/busses/i2c-sis5595.c      |    1 +
 drivers/i2c/busses/i2c-sis630.c       |    1 +
 drivers/i2c/busses/i2c-sis96x.c       |    1 +
 drivers/i2c/busses/i2c-via.c          |    1 +
 drivers/i2c/busses/i2c-viapro.c       |    1 +
 drivers/i2c/busses/i2c-voodoo3.c      |    1 +
 drivers/i2c/busses/scx200_acb.c       |    3 -
 drivers/i2c/chips/Kconfig             |    9 +
 drivers/i2c/chips/Makefile            |    1 +
 drivers/i2c/chips/ds1337.c            |    3 -
 drivers/i2c/chips/ds1374.c            |    3 -
 drivers/i2c/chips/eeprom.c            |    3 -
 drivers/i2c/chips/isp1301_omap.c      |    1 +
 drivers/i2c/chips/m41t00.c            |    3 -
 drivers/i2c/chips/max6875.c           |    6 -
 drivers/i2c/chips/pca9539.c           |    3 -
 drivers/i2c/chips/pcf8574.c           |    3 -
 drivers/i2c/chips/pcf8591.c           |    3 -
 drivers/i2c/chips/rtc8564.c           |    3 -
 drivers/i2c/chips/tps65010.c          |    3 -
 drivers/i2c/chips/x1205.c             |  698 ++++++++++++++++++++++++++++++++++
 drivers/i2c/i2c-core.c                |    3 +
 drivers/i2c/i2c-dev.c                 |    3 -
 include/linux/x1205.h                 |   31 ++
 85 files changed, 897 insertions(+), 156 deletions(-)

Thanks,
-- 
Jean Delvare
