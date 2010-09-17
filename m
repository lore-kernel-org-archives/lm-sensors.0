From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 17 Sep 2010 15:32:49 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.36
Message-Id: <20100917173249.2e88682a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100825165951.0c5d0955@hyperion.delvare>
In-Reply-To: <20100825165951.0c5d0955@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.36 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 Documentation/hwmon/sysfs-interface |    7 ++---
 MAINTAINERS                         |    5 +++-
 drivers/hwmon/adm1031.c             |   43 +++++++++++++++++++---------------
 drivers/hwmon/emc1403.c             |    1 -
 drivers/hwmon/f75375s.c             |    6 ++--
 drivers/hwmon/lis3lv02d_i2c.c       |    4 +-
 drivers/hwmon/lis3lv02d_spi.c       |    4 +-
 drivers/hwmon/lm95241.c             |   21 +++++++++--------
 drivers/hwmon/w83627ehf.c           |    1 +
 9 files changed, 50 insertions(+), 42 deletions(-)

---------------

Guenter Roeck (2):
      hwmon: (adm1031) Replace update_rate sysfs attribute with update_interval
      hwmon: (lm95241) Replace rate sysfs attribute with update_interval

Guillem Jover (2):
      hwmon: (f75375s) Shift control mode to the correct bit position
      hwmon: (f75375s) Do not overwrite values read from registers

Jean Delvare (1):
      hwmon: New subsystem maintainers

Jonas Jonsson (1):
      hwmon: (w83627ehf) Use proper exit sequence

Kuninori Morimoto (1):
      hwmon: (lis3lv02d) Prevent NULL pointer dereference

Yong Wang (1):
      hwmon: (emc1403) Remove unnecessary hwmon_device_unregister

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
