From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 13 Aug 2011 18:20:23 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.1-rc2
Message-Id: <1313259623-7816-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.1-rc2 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit 322a8b034003c0d46d39af85bf24fee27b902f48:

  Linux 3.1-rc1 (2011-08-07 18:23:30 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Guenter Roeck (2):
      hwmon: (pmbus) Virtualize pmbus_write_byte
      hwmon: (pmbus/lm25066) Ignore byte writes to non-zero pages

Julia Lawall (1):
      hwmon: (ibmaem) add missing kfree

 drivers/hwmon/ibmaem.c           |   15 ++++++++++-----
 drivers/hwmon/pmbus/lm25066.c    |   12 ++++++++++++
 drivers/hwmon/pmbus/pmbus.h      |    1 +
 drivers/hwmon/pmbus/pmbus_core.c |   20 +++++++++++++++++++-
 4 files changed, 42 insertions(+), 6 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
