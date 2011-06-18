From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 18 Jun 2011 15:24:46 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.0
Message-Id: <1308410686-21334-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110606170230.2bda2a14@endymion.delvare>
In-Reply-To: <20110606170230.2bda2a14@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.0 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit 95d17b7168eacf1f97f2d1d087ebe7a648c30051:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6 (2011-06-17 10:37:57 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Guenter Roeck (4):
      hwmon: (asus_atk0110) Consolidate sysfs attribute initialization
      hwmon: (ibmaem) Initialize sysfs attributes
      hwmon: (ibmpex) Initialize sysfs attributes
      hwmon: (s3c) Initialize sysfs attributes

Jean Delvare (1):
      hwmon: (coretemp) Drop unused struct members

 drivers/hwmon/asus_atk0110.c |    5 +----
 drivers/hwmon/coretemp.c     |    4 ----
 drivers/hwmon/ibmaem.c       |    2 ++
 drivers/hwmon/ibmpex.c       |    1 +
 drivers/hwmon/s3c-hwmon.c    |    2 ++
 5 files changed, 6 insertions(+), 8 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
