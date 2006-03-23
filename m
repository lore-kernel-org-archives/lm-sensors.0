From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 23 Mar 2006 15:09:22 +0000
Subject: [lm-sensors] [PATCH 00/10] hwmon and i2c updates
Message-Id: <20060323160922.1362fb0b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a 10-piece hwmon and i2c patchset, mainly adding support for
more chips (National Semiconductor LM82, ATI IXP200/300/400, SMSC
LPC47M192/997) and new features (Winbond W83627EHF/EHG voltage inputs
and alarms). There also are a few cleanups here and there. All these
patches should make it into 2.6.17.

This is probably the last large patchset I send to you for 2.6.17, BTW,
although there will inevitably be some last minute fixes after that.

Here's the summary:

Hartmut Rick:
 o smsc47m192: New hwmon driver for SMSC LPC47M192/997

Jean Delvare:
 o w83627ehf: Add alarms support
 o w83792d: Be quiet on misdetection
 o f71805f: Resource needs not be global
 o hwmon: Add sysfs interface for individual alarm files

Jordan Crouse:
 o lm83: Add LM82 support

Mark M. Hoffman:
 o i2c-sis96x: Remove an init-time log message
 o i2c-parport: Make type parameter mandatory

Rudolf Marek:
 o w83627ehf: Add voltage inputs support
 o i2c-piix4: Add ATI IXP200/300/400 support

Statistics:

 Documentation/hwmon/lm83               |   16 +
 Documentation/hwmon/smsc47m192         |  102 +++++
 Documentation/hwmon/sysfs-interface    |  104 ++++-
 Documentation/i2c/busses/i2c-parport   |   16 +
 Documentation/i2c/busses/i2c-piix4     |    2 +
 drivers/hwmon/Kconfig                  |   27 +
 drivers/hwmon/Makefile                 |    1 +
 drivers/hwmon/f71805f.c                |   15 -
 drivers/hwmon/lm83.c                   |   50 ++
 drivers/hwmon/smsc47m192.c             |  648 ++++++++++++++++++++++++++++++++
 drivers/hwmon/w83627ehf.c              |  170 ++++++++
 drivers/hwmon/w83792d.c                |    5 +
 drivers/i2c/busses/Kconfig             |   10 +
 drivers/i2c/busses/i2c-parport-light.c |    9 +
 drivers/i2c/busses/i2c-parport.c       |    9 +
 drivers/i2c/busses/i2c-parport.h       |    2 
 drivers/i2c/busses/i2c-piix4.c         |    6 +
 drivers/i2c/busses/i2c-sis96x.c        |    8 -
 include/linux/pci_ids.h                |    3 +
 19 files changed, 1123 insertions(+), 80 deletions(-)

Thanks,
-- 
Jean Delvare

