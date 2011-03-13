From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 13 Mar 2011 19:34:47 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.38
Message-Id: <1300044887-30680-1-git-send-email-guenter.roeck@ericsson.com>
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

The following changes since commit a5abba989deceb731047425812d268daf7536575:

  Linux 2.6.38-rc8 (2011-03-07 21:09:37 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Hans de Goede (2):
      hwmon/f71882fg: Fix a typo in a comment
      hwmon/f71882fg: Set platform drvdata to NULL later

 drivers/hwmon/f71882fg.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
