From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 18 Nov 2015 16:30:56 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for v4.4-rc2
Message-Id: <1447864256-8985-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon fixes for Linux v4.4-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.4-rc2

Thanks,
Guenter
------

The following changes since commit 8005c49d9aea74d382f474ce11afbbc7d7130bec:

  Linux 4.4-rc1 (2015-11-15 17:00:27 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.4-rc2

for you to fetch changes up to cef03d7e66bd70c4baf61dd2431cf8de250834de:

  hwmon: (scpi) skip unsupported sensors properly (2015-11-16 09:59:50 -0800)

----------------------------------------------------------------
hwmon fixes for v4.4-rc2

Fix build issues in scpi and ina2xx drivers, update scpi driver to
support recent firmware, and fix an uninitialized variable warning
in applesmc driver.

----------------------------------------------------------------
Arnd Bergmann (1):
      hwmon: (scpi) add thermal-of dependency

Li Yang (1):
      hwmon: (ina2xx) Fix build issue by selecting REGMAP_I2C

Shuah Khan (1):
      hwmon : (applesmc) Fix uninitialized variables warnings

Sudeep Holla (1):
      hwmon: (scpi) skip unsupported sensors properly

 drivers/hwmon/Kconfig      |  2 ++
 drivers/hwmon/applesmc.c   |  2 +-
 drivers/hwmon/scpi-hwmon.c | 21 +++++++++++----------
 3 files changed, 14 insertions(+), 11 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
