From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 18 Dec 2015 20:06:52 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for v4.4-rc6
Message-Id: <1450469212-31015-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon fixes for Linux v4.4-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.4-rc6

Thanks,
Guenter
------

The following changes since commit 527e9316f8ec44bd53d90fb9f611fa7ffff52bb9:

  Linux 4.4-rc4 (2015-12-06 15:43:12 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.4-rc6

for you to fetch changes up to a3a316cfc41ab3e7b9e0079338f8ea9dff911d88:

  hwmon: (sht15) Select CONFIG_BITREVERSE (2015-12-18 08:19:52 -0800)

----------------------------------------------------------------
hwmon fixes for v4.4-rc6

- Select CONFIG_BITREVERSE for sht15 driver to avoid build failure
  if it is not configured.
- Force wait for conversion time for the first valid data in tmp102
  driver to avoid reporting erroneous data to the thermal subsystem.

----------------------------------------------------------------
Arnd Bergmann (1):
      hwmon: (sht15) Select CONFIG_BITREVERSE

Nishanth Menon (1):
      hwmon: (tmp102) Force wait for conversion time for the first valid data

 drivers/hwmon/Kconfig  |  1 +
 drivers/hwmon/tmp102.c | 16 +++++++++++++++-
 2 files changed, 16 insertions(+), 1 deletion(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
