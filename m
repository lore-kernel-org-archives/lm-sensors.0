From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 10 Oct 2012 14:24:26 +0000
Subject: [lm-sensors] [GIT PULL] hwmon update for Linux 3.7
Message-Id: <20121010162426.62cc89f7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem updates for Linux 3.7 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

Only trivial things this time.

 Documentation/hwmon/da9052             |    2 +-
 Documentation/hwmon/max1619            |    2 +-
 Documentation/hwmon/twl4030-madc-hwmon |    2 +-
 drivers/hwmon/acpi_power_meter.c       |    1 +
 drivers/hwmon/adm9240.c                |    1 +
 drivers/hwmon/adt7411.c                |    1 -
 drivers/hwmon/adt7462.c                |    1 -
 drivers/hwmon/adt7475.c                |    1 +
 drivers/hwmon/applesmc.c               |    1 +
 drivers/hwmon/asus_atk0110.c           |    2 ++
 drivers/hwmon/da9052-hwmon.c           |    1 -
 drivers/hwmon/emc1403.c                |    1 +
 drivers/hwmon/emc6w201.c               |    1 -
 drivers/hwmon/hih6130.c                |    1 +
 drivers/hwmon/i5k_amb.c                |    2 --
 drivers/hwmon/ibmaem.c                 |    1 +
 drivers/hwmon/ibmpex.c                 |    1 +
 drivers/hwmon/ina2xx.c                 |    1 +
 drivers/hwmon/k8temp.c                 |    1 -
 drivers/hwmon/lineage-pem.c            |    1 +
 drivers/hwmon/lm92.c                   |    1 +
 drivers/hwmon/lm93.c                   |    1 +
 drivers/hwmon/ltc4151.c                |    1 +
 drivers/hwmon/ltc4215.c                |    1 +
 drivers/hwmon/ltc4245.c                |    1 +
 drivers/hwmon/ltc4261.c                |    1 +
 drivers/hwmon/max16065.c               |    1 -
 drivers/hwmon/max1619.c                |    4 ++--
 drivers/hwmon/max6642.c                |    2 +-
 drivers/hwmon/pmbus/pmbus_core.c       |    2 +-
 drivers/hwmon/s3c-hwmon.c              |    1 -
 drivers/hwmon/sht21.c                  |    1 +
 drivers/hwmon/smm665.c                 |    1 +
 drivers/hwmon/thmc50.c                 |    1 +
 drivers/hwmon/tmp102.c                 |    1 +
 drivers/hwmon/ultra45_env.c            |    1 +
 drivers/hwmon/w83791d.c                |    1 +
 drivers/hwmon/w83792d.c                |    1 +
 drivers/hwmon/w83793.c                 |    1 +
 drivers/hwmon/w83795.c                 |    2 +-
 drivers/hwmon/w83l786ng.c              |    1 +
 41 files changed, 35 insertions(+), 17 deletions(-)

---------------

Jean Delvare (3):
      hwmon: Add missing inclusions of <linux/jiffies.h>
      hwmon: Add missing inclusions of <linux/err.h>
      hwmon: Drop needless includes of <linux/delay.h>

Oleksij Rempel (1):
      hwmon: Update Alexey Fisher's name

Peter Meerwald (1):
      hwmon: Fix spelling of Celsius

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
