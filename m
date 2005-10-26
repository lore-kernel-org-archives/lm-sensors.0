From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 26 Oct 2005 20:56:28 +0000
Subject: [lm-sensors] [PATCH 00/16] hwmon and i2c updates
Message-Id: <20051026205718.4f1887de.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051007230046.1df3ed73.khali@linux-fr.org>
In-Reply-To: <20051007230046.1df3ed73.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a 16-piece hwmon and i2c update patchset. These are fixes I
gathered in the last few weeks or wrote myself. Details are given in
the header of each patch. None of these are meant for Linux 2.6.14. I'd
like you to have them included in the next -mm releases so that they get
some testing.

The most important part here is certainly the complete rewrite of the
SMBus PEC implementation. It was discussed briefly on the lm-sensors
list, but I don't think anyone actually took the time to review my
code, and I did not get any feedback (neither negative nor positive)
about the idea of the rewrite itself either. Let's hope that having
this in -mm for some time will let it get proper testing (PEC is almost
unused to date, but at least we want to make sure that the change
doesn't affect non-PEC transactions). If anyone is unhappy about the
change, don't wait any longer, let me know ASAP.

Here's the summary:

Ben Dooks:
 o Static function fixes in i2c drivers
 o Static function fixes in hwmon drivers

Jean Delvare:
 o i2c ID redefinition cleanups
 o Drop unused parport i2c IDs
 o i2c-i810 documentation update
 o SMBus PEC support rewrite
 o i2c-i801 PEC code cleanups
 o Add PEC support to the lm90 driver
 o lm90 documentation update
 o smsc47m1 documentation update

Statistics:

 Documentation/hwmon/lm90                |   47 +++++++-
 Documentation/hwmon/smsc47m1            |    7 +
 Documentation/hwmon/sysfs-interface     |    3 +
 Documentation/i2c/busses/i2c-i810       |    1 +
 drivers/hwmon/adm1026.c                 |   18 +-
 drivers/hwmon/ds1621.c                  |    4 
 drivers/hwmon/fscpos.c                  |    2 
 drivers/hwmon/it87.c                    |    2 
 drivers/hwmon/lm78.c                    |    2 
 drivers/hwmon/lm80.c                    |    2 
 drivers/hwmon/lm85.c                    |   12 +-
 drivers/hwmon/lm90.c                    |  178 ++++++++++++++++++++-----------
 drivers/hwmon/smsc47m1.c                |    7 +
 drivers/i2c/busses/Kconfig              |    3 +
 drivers/i2c/busses/i2c-amd8111.c        |    7 -
 drivers/i2c/busses/i2c-i801.c           |   38 +++----
 drivers/i2c/busses/i2c-i810.c           |    1 +
 drivers/i2c/busses/i2c-nforce2.c        |    7 -
 drivers/i2c/busses/i2c-prosavage.c      |    5 -
 drivers/i2c/chips/ds1374.c              |    3 +
 drivers/i2c/chips/eeprom.c              |    2 
 drivers/i2c/chips/pcf8574.c             |    2 
 drivers/i2c/chips/pcf8591.c             |    2 
 drivers/i2c/i2c-core.c                  |  162 ++++++++--------------------
 drivers/media/video/bt832.c             |    1 -
 drivers/media/video/msp3400.c           |    1 -
 drivers/media/video/saa6588.c           |    2 -
 drivers/media/video/saa7134/saa6752hs.c |    2 -
 drivers/media/video/saa7134/saa7134.h   |    1 -
 drivers/media/video/tda7432.c           |    1 -
 drivers/media/video/tda9875.c           |    1 -
 drivers/media/video/tda9887.c           |    1 -
 drivers/media/video/tvaudio.c           |    3 -
 drivers/media/video/tveeprom.c          |    4 -
 include/linux/i2c-id.h                  |    6 
 include/linux/i2c.h                     |   24 ----
 include/media/id.h                      |   35 ------
 include/media/ovcamchip.h               |   14 --
 38 files changed, 269 insertions(+), 344 deletions(-)

Thanks,
-- 
Jean Delvare
