From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 30 May 2015 18:15:10 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for v4.1-rc6
Message-Id: <1433009710-1482-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon fixes for Linux v4.1-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.1-rc6

Thanks,
Guenter
------

The following changes since commit ba155e2d21f6bf05de86a78dbe5bfd8757604a65:

  Linux 4.1-rc5 (2015-05-24 18:22:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.1-rc6

for you to fetch changes up to c7bd6dc320b85445b6b36a0aff41f929210027c7:

  hwmon: (nct6683) Add missing sysfs attribute initialization (2015-05-29 17:47:42 -0700)

----------------------------------------------------------------
Some late hwmon patches, all headed for -stable

- Fix sysfs attribute initialization in nct6775 and nct6683 drivers
- Do not attempt to auto-detect tmp435 on I2C address 0x37
- Ensure iio channel is of type IIO_VOLTAGE in ntc_thermistor driver

----------------------------------------------------------------
Chris Lesiak (1):
      hwmon: (ntc_thermistor) Ensure iio channel is of type IIO_VOLTAGE

Guenter Roeck (3):
      hwmon: (tmp401) Do not auto-detect chip on I2C address 0x37
      hwmon: (nct6775) Add missing sysfs attribute initialization
      hwmon: (nct6683) Add missing sysfs attribute initialization

 Documentation/hwmon/tmp401     | 2 +-
 drivers/hwmon/nct6683.c        | 2 ++
 drivers/hwmon/nct6775.c        | 2 ++
 drivers/hwmon/ntc_thermistor.c | 9 +++++++++
 drivers/hwmon/tmp401.c         | 2 +-
 5 files changed, 15 insertions(+), 2 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
