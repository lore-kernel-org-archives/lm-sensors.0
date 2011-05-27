From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 27 May 2011 09:51:29 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.40
Message-Id: <1306489889-20741-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.40 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit dc7acbb2518f250050179c8581a972df3b6a24f1:

  Merge branch 'upstream/tidy-xen-mmu-2.6.39' of git://git.kernel.org/pub/scm/linux/kernel/git/jeremy/xen (2011-05-26 19:01:15 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Guenter Roeck (2):
      hwmon: (coretemp) Update comments describing the handling of HT CPUs
      hwmon: (pmbus) Initialize sysfs attributes

Jean Delvare (1):
      hwmon: (coretemp) Fix section mismatch

Sergey Senozhatsky (1):
      hwmon: (coretemp) Initialize sysfs attributes

 drivers/hwmon/coretemp.c   |   16 +++++++++-------
 drivers/hwmon/pmbus_core.c |    1 +
 2 files changed, 10 insertions(+), 7 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
