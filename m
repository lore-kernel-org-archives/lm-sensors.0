From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 15:21:20 +0000
Subject: [lm-sensors] [PATCH 00/11] i2c and hwmon updates
Message-Id: <20051218162120.4a4dbd5b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes an 11-piece i2c and hwmon update patchset. The more important
changes are to the hwmon-vid, w83792d and i2c-mv64xxx drivers, and the
rest is composed of random cleanups here and there; nothing ground
breaking. None of these are meant for Linux 2.6.15. I'd like you to
have them included in the next -mm releases so that they get some
testing, and can then be merged in Linux 2.6.16.

Here's the summary:

Jean Delvare:
 o w83792d: miscellaneous cleanups
 o w83792d: simplify in low bits handling
 o it87: use u8 for vrm
 o i2c: driver ID list cleanups
 o Update i2c_driver.command documentation
 o I2C_DF_NOTIFY removal comment cleanups
 o i2c-nforce2: add nforce4 MCP-04 device ID

Laurent Riffard:
 o Drop empty i2c_driver.command implementations

Mark A. Greer:
 o i2c-mv64xxx: fix transaction abortion

Martin Hicks:
 o i2c-ibm_iic: add I2C_CLASS_HWMON

Rudolf Marek:
 o hwmon-vid: add support for some VIA CPUs

Statistics:

 Documentation/i2c/busses/i2c-nforce2  |    3 +
 Documentation/i2c/writing-clients     |   10 +---
 drivers/hwmon/hwmon-vid.c             |   69 ++++++++++++++++++-----------
 drivers/hwmon/it87.c                  |    4 +-
 drivers/hwmon/w83792d.c               |   79 +++++++++------------------------
 drivers/i2c/busses/i2c-ibm_iic.c      |    1 +
 drivers/i2c/busses/i2c-mv64xxx.c      |   33 ++++++--------
 drivers/i2c/busses/i2c-nforce2.c      |    2 +
 drivers/i2c/i2c-core.c                |    8 ---
 drivers/i2c/i2c-dev.c                 |    7 ---
 drivers/media/video/saa5246a.c        |    7 ---
 drivers/media/video/saa5249.c         |    7 ---
 drivers/video/matrox/matroxfb_maven.c |    5 --
 include/linux/hwmon-vid.h             |    6 +-
 include/linux/i2c-id.h                |   20 --------
 include/linux/pci_ids.h               |    1 +
 16 files changed, 92 insertions(+), 170 deletions(-)

Thanks,
-- 
Jean Delvare

