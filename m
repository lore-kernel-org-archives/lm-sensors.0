From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 11 Nov 2010 17:50:03 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.37
Message-Id: <1289497803-15160-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1288978399-16583-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1288978399-16583-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.37 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit f6614b7bb405a9b35dd28baea989a749492c46b2:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6 (2010-11-09 10:34:48 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Axel Lin (3):
      hwmon: (adt7470) Return proper error code for adt7470_probe()
      hwmon: (ad7414) Return proper error code for ad7414_probe()
      hwmon: (gpio-fan) Fix fan_ctrl_init error path

 drivers/hwmon/ad7414.c   |    6 ++++--
 drivers/hwmon/adt7470.c  |    4 +++-
 drivers/hwmon/gpio-fan.c |    8 ++++----
 3 files changed, 11 insertions(+), 7 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
