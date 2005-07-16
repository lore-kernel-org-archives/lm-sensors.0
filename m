From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Sat, 16 Jul 2005 03:35:55 +0000
Subject: [lm-sensors] [PATCH 2.6.13-rc3 0/3] hwmon: hwmon sysfs class
Message-Id: <20050716013537.GA4265@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Greg:

Here is the patchset that adds the hwmon sysfs class.  It is refreshed
against 2.6.13-rc3, which required no changes since my last RFC.  Please
apply.

 drivers/hwmon/Kconfig      |    7 ++-
 drivers/hwmon/Makefile     |    2 
 drivers/hwmon/adm1021.c    |   16 ++++++-
 drivers/hwmon/adm1025.c    |   16 ++++++-
 drivers/hwmon/adm1026.c    |   19 +++++++-
 drivers/hwmon/adm1031.c    |   20 +++++++--
 drivers/hwmon/adm9240.c    |   19 +++++++-
 drivers/hwmon/asb100.c     |   31 +++++++++++---
 drivers/hwmon/atxp1.c      |   16 ++++++-
 drivers/hwmon/ds1621.c     |   16 ++++++-
 drivers/hwmon/fscher.c     |   16 ++++++-
 drivers/hwmon/fscpos.c     |   16 ++++++-
 drivers/hwmon/gl518sm.c    |   17 ++++++-
 drivers/hwmon/gl520sm.c    |   16 ++++++-
 drivers/hwmon/hwmon.c      |   98 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/hwmon/it87.c       |   16 ++++++-
 drivers/hwmon/lm63.c       |   16 ++++++-
 drivers/hwmon/lm75.c       |   15 ++++++
 drivers/hwmon/lm77.c       |   16 ++++++-
 drivers/hwmon/lm78.c       |   16 ++++++-
 drivers/hwmon/lm80.c       |   16 ++++++-
 drivers/hwmon/lm83.c       |   16 ++++++-
 drivers/hwmon/lm85.c       |   15 ++++++
 drivers/hwmon/lm87.c       |   16 ++++++-
 drivers/hwmon/lm90.c       |   16 ++++++-
 drivers/hwmon/lm92.c       |   17 ++++++-
 drivers/hwmon/max1619.c    |   17 ++++++-
 drivers/hwmon/pc87360.c    |   13 +++++
 drivers/hwmon/sis5595.c    |   18 +++++++-
 drivers/hwmon/smsc47b397.c |   18 +++++++-
 drivers/hwmon/smsc47m1.c   |   19 +++++++-
 drivers/hwmon/via686a.c    |   24 ++++++++---
 drivers/hwmon/w83627ehf.c  |   16 ++++++-
 drivers/hwmon/w83627hf.c   |   16 ++++++-
 drivers/hwmon/w83781d.c    |   39 ++++++++++++++---
 drivers/hwmon/w83l785ts.c  |   16 ++++++-
 include/linux/hwmon.h      |   24 +++++++++++
 37 files changed, 659 insertions(+), 61 deletions(-)

I dedicate this patchset to Celia.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

