From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 24 Nov 2010 17:46:09 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.37-rc4
Message-Id: <1290621871-27576-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.37-rc4 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit 3561d43fd289f590fdae672e5eb831b8d5cf0bf6:

  Linux 2.6.37-rc3 (2010-11-21 15:18:56 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Guenter Roeck (2):
      hwmon: (i5k_amb) Fix compile warning
      hwmon: (lis3lv02d_i2c) Fix compile warnings

 drivers/hwmon/i5k_amb.c       |    2 ++
 drivers/hwmon/lis3lv02d_i2c.c |   10 ++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
