From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 10 Jul 2011 16:30:36 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.0
Message-Id: <1310315436-28204-1-git-send-email-guenter.roeck@ericsson.com>
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

The following changes since commit fe0d42203cb5616eeff68b14576a0f7e2dd56625:

  Linux 3.0-rc6 (2011-07-04 15:56:24 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Guenter Roeck (3):
      hwmon: (lm95241) Fix chip detection code
      hwmon: (lm95241) Fix negative temperature results
      hwmon: (pmbus) Improve auto-detection of temperature status register

 drivers/hwmon/lm95241.c |   22 +++++++++++++++-------
 drivers/hwmon/pmbus.c   |   11 ++++++-----
 2 files changed, 21 insertions(+), 12 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
