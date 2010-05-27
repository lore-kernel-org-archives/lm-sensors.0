From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 27 May 2010 18:09:24 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for 2.6.35
Message-Id: <20100527200924.1666758c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull hwmon subsystem updates for Linux 2.6.35 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

We have support for new chips (SMSC SCH5127, SMSC EMC1403, National
Semiconductor LM64, TI TMP102 and TI TPM105), support for recent
MacBook Pro models, and various cleanups.

 Documentation/hwmon/dme1737         |   51 ++++-
 Documentation/hwmon/lm63            |    7 +
 Documentation/hwmon/ltc4245         |    4 +-
 Documentation/hwmon/sysfs-interface |   13 +-
 Documentation/hwmon/tmp102          |   26 +++
 drivers/acpi/osl.c                  |    9 +
 drivers/hwmon/Kconfig               |   34 +++-
 drivers/hwmon/Makefile              |    2 +
 drivers/hwmon/adm1031.c             |   68 +++++++-
 drivers/hwmon/applesmc.c            |  186 +++++++++++++++++++-
 drivers/hwmon/asus_atk0110.c        |    7 +
 drivers/hwmon/dme1737.c             |  328 +++++++++++++++++++++++-----------
 drivers/hwmon/emc1403.c             |  344 +++++++++++++++++++++++++++++++++++
 drivers/hwmon/f71882fg.c            |  170 +++++++++++++-----
 drivers/hwmon/lm63.c                |   16 ++-
 drivers/hwmon/lm75.c                |    2 +
 drivers/hwmon/lm90.c                |    3 +-
 drivers/hwmon/ltc4245.c             |   18 +--
 drivers/hwmon/tmp102.c              |  321 ++++++++++++++++++++++++++++++++
 drivers/hwmon/tmp401.c              |  255 +++++++++++++-------------
 include/linux/acpi.h                |    2 +
 21 files changed, 1543 insertions(+), 323 deletions(-)
 create mode 100644 Documentation/hwmon/tmp102
 create mode 100644 drivers/hwmon/emc1403.c
 create mode 100644 drivers/hwmon/tmp102.c

---------------

Alex Murray (1):
      hwmon: (applesmc) Add temperature sensor labels to sysfs interface

Andre Prendel (2):
      hwmon: (tmp401) Use constants for sysfs file permissions
      hwmon: (tmp401) Reorganize code to get rid of static forward declarations

Bernhard Froemel (1):
      hwmon: (applesmc) Add generic support for MacBook Pro 6

Giel van Schijndel (4):
      hwmon: (f71882fg) Fixed braces coding style issues
      hwmon: (f71882fg) Use strict_stro(l|ul) instead of simple_strto$1
      hwmon: (f71882fg) Code cleanup
      hwmon: (f71882fg) Acquire I/O regions while we're working with them

Henrik Rydberg (2):
      hwmon: (applesmc) Add support for MacBook Pro 5,3 and 5,4
      hwmon: (applesmc) Add generic support for MacBook Pro 7

Ira W. Snyder (3):
      hwmon: (lm90) Use programmed update rate
      hwmon: Add description of the update_rate sysfs attribute
      hwmon: (ltc4245) Read only one GPIO pin

Jean Delvare (5):
      hwmon: (asus_atk0110) Don't load if ACPI resources aren't enforced
      hwmon: (adm1031) Allow setting update rate
      hwmon: (tmp102) Various fixes
      hwmon: (tmp102) Fix suspend and resume functions
      hwmon: (tmp102) Don't always stop chip at exit

Juerg Haefliger (1):
      hwmon: (dme1737) Add SCH5127 support

Kalhan Trisal (1):
      hwmon: EMC1403 thermal sensor support

Matthew Garrett (1):
      hwmon: (lm63) Add basic support for LM64

Shubhrajyoti Datta (1):
      hwmon: (lm75) Add support for the Texas Instruments TMP105

Steven King (1):
      hwmon: Driver for TI TMP102 temperature sensor

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
