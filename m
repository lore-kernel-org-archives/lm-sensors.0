From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 02 Jul 2015 18:41:00 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for v4.2-rc1
Message-Id: <1435862460-24409-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon fixes for Linux v4.2-rc1 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.2-rc1

Thanks,
Guenter
------

The following changes since commit 7adf12b87f45a77d364464018fb8e9e1ac875152:

  Merge tag 'for-linus-4.2-rc0-tag' of git://git.kernel.org/pub/scm/linux/kernel/git/xen/tip (2015-07-01 11:53:46 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.2-rc1

for you to fetch changes up to 347d7e45bd09ce09cbc30d5cea9de377eb22f55c:

  hwmon: (mcp3021) Fix broken output scaling (2015-07-01 13:56:27 -0700)

----------------------------------------------------------------
Fixes for v4.2-rc1

Two patches headed for stable:
- Fix broken output scaling in mcp3021 driver
- Fix attribute visibility in nct7802 driver
One regression:
- Fix name attribute in dell-smm-hwmon driver

----------------------------------------------------------------
Constantine Shulyupin (1):
      hwmon: (nct7802) fix visibility of temp3

Gabriele Mazzotta (1):
      hwmon: (dell-smm-hwmon) Use a valid name attribute

Stevens, Nick (1):
      hwmon: (mcp3021) Fix broken output scaling

 drivers/hwmon/dell-smm-hwmon.c |  2 +-
 drivers/hwmon/mcp3021.c        | 14 +-------------
 drivers/hwmon/nct7802.c        |  2 +-
 3 files changed, 3 insertions(+), 15 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
