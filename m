From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 09 Jan 2006 21:36:02 +0000
Subject: [lm-sensors] [PATCH 0/11] i2c and hwmon updates
Message-Id: <20060109223602.706e100f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes an 11-piece i2c and hwmon update patchset. The more important
change (in volume) is the new f71805f hardware monitoring driver, then
comes the pc87360 driver those sysfs file creation was batched, and the
rest is composed of small cleanups here and there. The first 3 patches
of this set are meant for Linux 2.6.16, and should be sent to Linus
ASAP. I've marked them specifically (*) in the summary below. The rest
should spend some times in -mm for now.

Here's the summary:

Eric Sesterhenn:
 o i2c-algo-sibyte: Use module_param

Jean Delvare:
 o lm77: Fix negative temperature readings (*)
 o i2c: Resurrect i2c_smbus_write_i2c_block_data (*)
 o w83792d: Inline register access functions
 o f71805f: New driver
 o f71805f: Use attribute arrays
 o f71805f: Add documentation

Jim Cromie;
 o hwmon: Allow sensor attributes arrays
 o pc87360: Use attribute arrays

Rudolf Marek:
 o i2c-sis96x: Rename documentation file (*)

Tobias Klauser:
 o i2c: Use ARRAY_SIZE macro

Statistics:

 Documentation/hwmon/f71805f            |  105 ++++
 Documentation/hwmon/sysfs-interface    |   18 +
 Documentation/i2c/busses/i2c-sis69x    |   73 ---
 Documentation/i2c/busses/i2c-sis96x    |   73 +++
 MAINTAINERS                            |    6 +
 drivers/hwmon/Kconfig                  |   10 +
 drivers/hwmon/Makefile                 |    1 +
 drivers/hwmon/f71805f.c                |  896 ++++++++++++++++++++++++++++++++
 drivers/hwmon/lm77.c                   |    8 
 drivers/hwmon/pc87360.c                |  410 +++++++--------
 drivers/hwmon/w83792d.c                |   31 -
 drivers/i2c/algos/i2c-algo-sibyte.c    |    2 
 drivers/i2c/busses/i2c-parport-light.c |    9 -
 drivers/i2c/busses/i2c-parport.c       |    7 -
 drivers/i2c/busses/i2c-pxa.c           |    2 
 drivers/i2c/i2c-core.c                 |   15 +
 include/linux/hwmon-sysfs.h            |   12 +
 include/linux/i2c.h                    |    3 +
 18 files changed, 1360 insertions(+), 321 deletions(-)

Thanks,
-- 
Jean Delvare

