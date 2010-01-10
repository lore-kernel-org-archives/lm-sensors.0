From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 10 Jan 2010 22:04:12 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.33
Message-Id: <20100110230412.321d6c43@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull some hwmon subsystem fixes for Linux 2.6.33 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

The asus_atk0110 changes aren't fixes stricto sensu, however they
should make future bug investigation and fixes much easier so I still
think it's OK to merge it now.

 Documentation/hwmon/k10temp  |   17 ++-
 drivers/hwmon/Kconfig        |    2 +-
 drivers/hwmon/adt7462.c      |    2 +-
 drivers/hwmon/asus_atk0110.c |  289 ++++++++++++++++++++++++++++++++++--------
 drivers/hwmon/coretemp.c     |   16 ++-
 drivers/hwmon/k10temp.c      |   40 +++++-
 drivers/hwmon/k8temp.c       |    2 +-
 drivers/hwmon/sis5595.c      |    2 +-
 drivers/hwmon/via686a.c      |    2 +-
 drivers/hwmon/vt8231.c       |    2 +-
 10 files changed, 299 insertions(+), 75 deletions(-)

---------------

Clemens Ladisch (1):
      hwmon: (k10temp) Blacklist more family 10h processors

Luca Tettamanti (2):
      hwmon: (asus_atk0110) Refactor interface probe code
      hwmon: (asus_atk0110) Add debugfs interface

Márton Németh (1):
      hwmon: Make PCI device ids constant

Roger Blofeld (1):
      hwmon: (adt7462) Fix pin 28 monitoring

Yong Wang (1):
      hwmon: (coretemp) Fix TjMax for Atom N450/D410/D510 CPUs

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
