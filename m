From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 07 Oct 2005 23:01:18 +0000
Subject: [lm-sensors] [PATCH 00/16] hwmon and i2c updates
Message-Id: <20051007230046.1df3ed73.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a 16-piece hwmon and i2c update patchset. These are fixes I
gathered in the last few weeks or wrote myself. Details are given in
the header of each patch. None of these are meant for Linux 2.6.14. I'd
like you to have them included in the next -mm releases so that they get
enough testing and can be merged in Linux 2.6.15.

Here's the summary:

Hideki Iwamoto:
 o Documentation fixes

Jean Delvare:
 o Add missing i2c-ixp2000/4xx adapter name
 o Cleanup i2c-dev ioctl debug message
 o Drop useless CVS revision IDs
 o Cleanup i2c-i801 ifdefs
 o Fix misplaced i2c.h comment
 o Drop out-of-date, colliding ioctl definitions
 o Drop legacy ISA address support from it87
 o Drop useless w83627hf initialization step
 o Drop unused per-i2c-algorithm adapter max
 o Drop I2C_SMBUS_I2C_BLOCK_MAX
 o Rename i2c-parport variable to avoid confusion
 o Drop meaningless use of I2C_DF_NOTIFY in i2c_client structures

Petr Vandrovec:
 o Fix w83627ehf/hf vs PNPACPI conflict (bug #4014)

Stig Telfer:
 o Fix i2c-elektor on Alpha
 o Big i2c-elektor cleanup

Statistics:

 Documentation/hwmon/it87          |    8 +-
 Documentation/i2c/writing-clients |   11 +--
 drivers/hwmon/it87.c              |   51 +++-----------
 drivers/hwmon/w83627ehf.c         |   13 ++-
 drivers/hwmon/w83627hf.c          |   28 ++++----
 drivers/i2c/busses/i2c-elektor.c  |  138 +++++++++++++++++++++++--------------
 drivers/i2c/busses/i2c-i801.c     |   20 -----
 drivers/i2c/busses/i2c-ixp2000.c  |    4 +
 drivers/i2c/busses/i2c-ixp4xx.c   |    4 +
 drivers/i2c/busses/i2c-parport.c  |    6 +-
 drivers/i2c/chips/ds1374.c        |    1 -
 drivers/i2c/chips/eeprom.c        |    4 
 drivers/i2c/chips/m41t00.c        |    1 -
 drivers/i2c/chips/rtc8564.c       |    2 
 drivers/i2c/i2c-core.c            |    8 +-
 drivers/i2c/i2c-dev.c             |    4 
 include/linux/i2c-algo-bit.h      |    4 -
 include/linux/i2c-algo-pca.h      |    2 -
 include/linux/i2c-algo-pcf.h      |    4 -
 include/linux/i2c-dev.h           |    2 -
 include/linux/i2c.h               |   10 ---
 21 files changed, 146 insertions(+), 179 deletions(-)

Thanks,
-- 
Jean Delvare
