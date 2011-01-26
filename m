From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 26 Jan 2011 21:52:24 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.38
Message-Id: <1296078744-21895-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
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

The following changes since commit 1bae4ce27c9c90344f23c65ea6966c50ffeae2f5:

  Linux 2.6.38-rc2 (2011-01-21 19:01:34 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Henrik Rydberg (1):
      hwmon: (applesmc) Properly initialize lockdep attributes

Kalhan Trisal (1):
      hwmon: (lis3) turn down the no IRQ message

Luca Tettamanti (1):
      hwmon: (asus_atk0110) Override interface detection on Sabertooth X58

 drivers/hwmon/applesmc.c     |    1 +
 drivers/hwmon/asus_atk0110.c |   23 ++++++++++++++++++++++-
 drivers/hwmon/lis3lv02d.c    |    2 +-
 3 files changed, 24 insertions(+), 2 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
