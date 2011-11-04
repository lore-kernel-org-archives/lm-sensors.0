From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 04 Nov 2011 12:57:05 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for Linux 3.2
Message-Id: <20111104135705.4254d734@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, Guenter Roeck <guenter.roeck@ericsson.com>

Hi Linus,

Please pull hwmon subsystem updates for Linux 3.2 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

This includes support for a new device (Winbond/Nuvoton W83627UHG) and
random other improvements and cleanups.

 Documentation/hwmon/w83627ehf |   28 +++---
 drivers/hwmon/Kconfig         |   20 +++-
 drivers/hwmon/ad7414.c        |    7 +-
 drivers/hwmon/ad7418.c        |   27 ++----
 drivers/hwmon/ads1015.c       |   21 +----
 drivers/hwmon/ads7828.c       |   12 +--
 drivers/hwmon/asb100.c        |   10 +-
 drivers/hwmon/ds1621.c        |   24 +----
 drivers/hwmon/ds620.c         |   42 ++------
 drivers/hwmon/gl518sm.c       |    4 +-
 drivers/hwmon/gl520sm.c       |    4 +-
 drivers/hwmon/ibmaem.c        |   60 +++++++-----
 drivers/hwmon/jc42.c          |   52 ++++------
 drivers/hwmon/lm73.c          |   30 +++++--
 drivers/hwmon/lm75.c          |    9 +-
 drivers/hwmon/lm77.c          |    4 +-
 drivers/hwmon/lm90.c          |  146 ++++++++++++++---------------
 drivers/hwmon/lm92.c          |   26 +++---
 drivers/hwmon/max16065.c      |    4 +-
 drivers/hwmon/sht21.c         |   26 +-----
 drivers/hwmon/smm665.c        |   15 +--
 drivers/hwmon/smsc47b397.c    |   13 ++-
 drivers/hwmon/tmp102.c        |   44 ++++-----
 drivers/hwmon/w83627ehf.c     |  210 +++++++++++++++++++++++++++++++---------
 drivers/hwmon/w83781d.c       |   10 +-
 25 files changed, 439 insertions(+), 409 deletions(-)

---------------

Dean Nelson (1):
      hwmon: Avoid building drivers for powerpc that read/write ISA addresses

Jean Delvare (11):
      hwmon: (lm73) Make detection less problematic
      hwmon: (ibmaem) Fix error paths
      hwmon: (ibmaem) Make instance initializations independent
      hwmon: (ibmaem) Avoid repeated memory allocations
      hwmon: (lm90) Fix warnings
      hwmon: (lm90) Make code more readable
      hwmon: (smsc47b397) Fix checkpatch errors
      hwmon: Use i2c_smbus_{read,write}_word_swapped
      hwmon: (w83627ehf) Properly report PECI and AMD-SI sensor types
      hwmon: (w83627ehf) Clean up probe function
      hwmon: (w83627ehf) Add support for the W83627UHG

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
