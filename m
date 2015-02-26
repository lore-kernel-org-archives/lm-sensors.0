From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 26 Feb 2015 21:58:40 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for v4.0-rc2
Message-Id: <1424987920-17743-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon fixes for Linux v4.0-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.0-rc2

Thanks,
Guenter
------

The following changes since commit c517d838eb7d07bbe9507871fab3931deccff539:

  Linux 4.0-rc1 (2015-02-22 18:21:14 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.0-rc2

for you to fetch changes up to d9ef72cd1c15c2fc1f7131cd78304dd21bc15953:

  hwmon: (ads7828) Check return value of devm_regmap_init_i2c (2015-02-22 20:10:30 -0800)

----------------------------------------------------------------
- Add missing return value check to ads7828 driver

----------------------------------------------------------------
Axel Lin (1):
      hwmon: (ads7828) Check return value of devm_regmap_init_i2c

 drivers/hwmon/ads7828.c | 3 +++
 1 file changed, 3 insertions(+)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
