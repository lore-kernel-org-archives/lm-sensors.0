From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 26 Feb 2011 17:52:13 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.38
Message-Id: <1298742733-9854-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1296078744-21895-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1296078744-21895-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.38 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit 493f3358cb289ccf716c5a14fa5bb52ab75943e5:

  Merge branch 'pm-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/rafael/suspend-2.6 (2011-02-25 15:15:17 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Axel Lin (2):
      hwmon: (ad7414) add MODULE_DEVICE_TABLE
      hwmon: (adt7411) add MODULE_DEVICE_TABLE

 drivers/hwmon/ad7414.c  |    1 +
 drivers/hwmon/adt7411.c |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
