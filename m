From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 24 Sep 2006 18:43:04 +0000
Subject: [lm-sensors] [PATCH 00/23] hwmon updates for 2.6.19
Message-Id: <20060924204304.f479ee21.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg,

Here comes a 23-piece hwmon update patchset. The bulk of it is added
checks for device_create_file() failures, to comply with the new checks
that have been in -mm for a while and which I guess will hit mainline
soon. In the same time, we now delete sysfs files when device/driver is
deleted. There are also a new driver (for the VIA VT1211) and
documentation updates. This is the last large patchset I'll have for
2.6.19.

Here's the summary:

Charles Spirakis:
 o w83791d: Documentation update

David Hubbard:
 o w83627ehf: Fix unchecked return status

Jean Delvare:
 o hwmon: Make a dozen drivers no more experimental
 o hwmon: Add individual alarm files to 4 drivers
 o hwmon: Fix unchecked return status, batch 4
 o hwmon: Fix unchecked return status, batch 5
 o hwmon: Fix unchecked return status, batch 6
 o hwmon: Fix unchecked return status, SMSC chips
 o hwmon: Remove Yuan Mu's address

Jim Cromie:
 o pc87360: Move some code around
 o pc87360: Delete sysfs files on device deletion
 o pc87360: Check for error on sysfs files creation
 o w83781d: Fix unchecked return status

Juerg Haefliger:
 o hwmon: New driver for the VIA VT1211
 o vt1211: Add documentation
 o vt1211: Document module parameters

Mark M. Hoffman:
 o hwmon: Fix unchecked return status, batch 1
 o hwmon: Fix unchecked return status, batch 2
 o hwmon: Fix unchecked return status, batch 3

Roger Lucas:
 o vt8231: Fix unchecked return status

Rudolf Marek:
 o k8temp: Add documentation
 o w83l785ts: Fix unchecked return status
 o w83792d: Fix unchecked return status

Statistics:

 Documentation/hwmon/k8temp    |   52 ++
 Documentation/hwmon/vt1211    |  206 ++++++
 Documentation/hwmon/w83627ehf |    2 
 Documentation/hwmon/w83791d   |   67 +-
 MAINTAINERS                   |    6 +
 drivers/hwmon/Kconfig         |   37 +
 drivers/hwmon/Makefile        |    1 +
 drivers/hwmon/adm1021.c       |   31 +
 drivers/hwmon/adm1025.c       |   94 +--
 drivers/hwmon/adm1026.c       |  286 +++++----
 drivers/hwmon/adm1031.c       |  114 ++-
 drivers/hwmon/adm9240.c       |  105 +--
 drivers/hwmon/asb100.c        |  122 ++--
 drivers/hwmon/atxp1.c         |   25 +
 drivers/hwmon/ds1621.c        |   28 +
 drivers/hwmon/f71805f.c       |  336 +++++++---
 drivers/hwmon/fscher.c        |  106 +--
 drivers/hwmon/fscpos.c        |   75 +-
 drivers/hwmon/gl518sm.c       |   74 +-
 drivers/hwmon/gl520sm.c       |  128 +++-
 drivers/hwmon/it87.c          |  234 ++++---
 drivers/hwmon/lm63.c          |   96 ++-
 drivers/hwmon/lm75.c          |   24 +
 drivers/hwmon/lm77.c          |   33 +
 drivers/hwmon/lm78.c          |   88 ++-
 drivers/hwmon/lm80.c          |   85 ++-
 drivers/hwmon/lm83.c          |  128 +++-
 drivers/hwmon/lm85.c          |  173 +++--
 drivers/hwmon/lm87.c          |  191 ++++--
 drivers/hwmon/lm90.c          |   90 +++
 drivers/hwmon/lm92.c          |   34 +
 drivers/hwmon/max1619.c       |   33 +
 drivers/hwmon/pc87360.c       |  230 +++++--
 drivers/hwmon/sis5595.c       |  101 ++-
 drivers/hwmon/smsc47b397.c    |   39 +
 drivers/hwmon/smsc47m1.c      |   78 ++
 drivers/hwmon/smsc47m192.c    |  150 ++---
 drivers/hwmon/via686a.c       |   83 +--
 drivers/hwmon/vt1211.c        | 1355 +++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/vt8231.c        |  186 +++++-
 drivers/hwmon/w83627ehf.c     |  124 +++-
 drivers/hwmon/w83627hf.c      |  232 ++++---
 drivers/hwmon/w83781d.c       |  277 ++++----
 drivers/hwmon/w83791d.c       |    7 +
 drivers/hwmon/w83792d.c       |  554 +++++++++--------
 drivers/hwmon/w83l785ts.c     |   28 +
 46 files changed, 4671 insertions(+), 1877 deletions(-)

-- 
Jean Delvare

