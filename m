From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 21 Feb 2016 18:22:11 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for v4.5-rc6
Message-Id: <1456078931-14315-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon fixes for Linux v4.5-rc6 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-v4.5-rc6

Thanks,
Guenter
------

The following changes since commit 18558cae0272f8fd9647e69d3fec1565a7949865:

  Linux 4.5-rc4 (2016-02-14 13:05:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.5-rc6

for you to fetch changes up to 000e0949148382c4962489593a2f05504c2a6771:

  hwmon: (gpio-fan) Remove un-necessary speed_index lookup for thermal hook (2016-02-19 17:14:25 -0800)

----------------------------------------------------------------
Two fixes headed for stable:

Remove an un-necessary speed_index lookup for thermal hook in the gpio-fan
driver. The unnecessary speed lookup can hog the system.

Handle negative conversion values correctly in the ads1015 driver.

----------------------------------------------------------------
Nishanth Menon (1):
      hwmon: (gpio-fan) Remove un-necessary speed_index lookup for thermal hook

Peter Rosin (1):
      hwmon: (ads1015) Handle negative conversion values correctly

 drivers/hwmon/ads1015.c  | 2 +-
 drivers/hwmon/gpio-fan.c | 7 +------
 2 files changed, 2 insertions(+), 7 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
