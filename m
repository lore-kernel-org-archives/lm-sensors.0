From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 30 Jul 2015 14:43:47 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for v4.2-rc5
Message-Id: <1438267427-21920-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon fixes for Linux v4.2-rc5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.2-rc5

Thanks,
Guenter
------

The following changes since commit cbfe8fa6cd672011c755c3cd85c9ffd4e2d10a6f:

  Linux 4.2-rc4 (2015-07-26 12:26:21 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.2-rc5

for you to fetch changes up to 9200bc4c28cd8992eb5379345abd6b4f0c93df16:

  hwmon: (nct7802) Fix integer overflow seen when writing voltage limits (2015-07-29 20:06:50 -0700)

----------------------------------------------------------------
Two patches headed for -stable.

nct7802: Fix integer overflow seen when writing voltage limits
nct7904: Rename pwm attributes to match hwmon ABI

----------------------------------------------------------------
Guenter Roeck (2):
      hwmon: (nct7904) Rename pwm attributes to match hwmon ABI
      hwmon: (nct7802) Fix integer overflow seen when writing voltage limits

 Documentation/hwmon/nct7904 |  4 ++--
 drivers/hwmon/nct7802.c     |  2 +-
 drivers/hwmon/nct7904.c     | 57 +++++++++++++++++++++++----------------------
 3 files changed, 32 insertions(+), 31 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
