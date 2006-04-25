From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 25 Apr 2006 10:32:54 +0000
Subject: [lm-sensors] [PATCH 00/10] i2c and hwmon updates
Message-Id: <20060425123254.6827b45f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a 10-piece i2c and hwmon update patchset. We have a new
hardware monitoring driver (w83791d, supporting the Winbond W83791D
chip), support for more devices in existing drivers (M41T81, M41T85,
nForce4 MCP51 and MCP55, Thinkpad laptops), code cleanups and
documentation updates. All of this is meant for -mm/2.6.18.

Here's the summary:

Charles Spirakis:
 o w83791d: New hardware monitoring driver for the Winbond W83791D

Jean Delvare:
 o i2c-piix4: Fix typo in documentation
 o i2c-piix4: Document the IBM problem more clearly
 o i2c-nforce2: Add support for the nForce4 MCP51 and MCP55
 o hdaps: Update the list of supported systems
 o lm83: Documentation update
 o hwmon: Improve the help text for CONFIG_HWMON

Mark A. Greer:
 o m41t00: Add support for the ST M41T81 and M41T85

Rudolf Marek:
 o i2c-piix4: Remove the fix_hstcfg parameter
 o hwmon: Trim VID values to correct number of bits

Statistics:

 Documentation/hwmon/lm83             |    1 +
 Documentation/hwmon/userspace-tools  |   17 +
 Documentation/hwmon/w83791d          |  113 +++
 Documentation/i2c/busses/i2c-nforce2 |    2 +
 Documentation/i2c/busses/i2c-piix4   |   38 +
 drivers/hwmon/Kconfig                |   14 +
 drivers/hwmon/Makefile               |    1 +
 drivers/hwmon/hdaps.c                |    6 +
 drivers/hwmon/hwmon-vid.c            |    9 +
 drivers/hwmon/w83791d.c              | 1255 ++++++++++++++++++++++++++++++++++
 drivers/i2c/busses/i2c-nforce2.c     |   38 +
 drivers/i2c/busses/i2c-piix4.c       |   27 -
 drivers/i2c/chips/m41t00.c           |  309 ++++++--
 include/linux/m41t00.h               |   50 +
 include/linux/pci_ids.h              |    2 +
 15 files changed, 1758 insertions(+), 124 deletions(-)


-- 
Jean Delvare

