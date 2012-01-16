From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 16 Jan 2012 22:00:51 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for Linux 3.3
Message-Id: <20120116230051.5a246e6b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull hwmon subsystem updates for Linux 3.3 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

We have support for the ITE IT8728F, and an improved lm63 driver.

 Documentation/hwmon/it87            |   13 +-
 Documentation/hwmon/lm63            |   21 +-
 Documentation/hwmon/sysfs-interface |    2 +-
 drivers/hwmon/Kconfig               |    8 +-
 drivers/hwmon/adm1031.c             |  153 ++++++---
 drivers/hwmon/coretemp.c            |   26 +-
 drivers/hwmon/it87.c                |   61 +++-
 drivers/hwmon/lm63.c                |  592 +++++++++++++++++++++++++++++++----
 drivers/hwmon/lm90.c                |    2 +-
 drivers/hwmon/max1111.c             |   15 +-
 10 files changed, 735 insertions(+), 158 deletions(-)

---------------

Eric Miao (1):
      hwmon: (max1111) Change sysfs interface to in[0-3]_input in millivolts

Guenter Roeck (10):
      hwmon: (lm63) Fix checkpatch errors
      hwmon: (lm63) Add support for external temperature offset register
      hwmon: (lm63) Add support for LM96163
      hwmon: (lm63) Add support for unsigned upper temperature limits
      hwmon: (lm63) Add support for writing the external critical temperature
      hwmon: (lm63) Add support for update_interval sysfs attribute
      hwmon: (lm63) Add sensor type attribute for external sensor on LM96163
      hwmon: (lm90) Add range check to set_update_interval
      hwmon: (adm1031) Fix coding style issues
      hwmon: (sysfs-interface) Update tempX_type attribute to be more generic

Jean Delvare (6):
      hwmon: (lm63) LM64 has a dedicated pin for tachometer
      hwmon: (lm63) Fix incorrect comment about I2C address
      hwmon: (lm63) Expose automatic fan speed control lookup table
      hwmon: (lm63) Support extended lookup table of LM96163
      hwmon: (coretemp) Add missing section annotations
      hwmon: (it87) Add IT8728F support

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
