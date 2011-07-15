From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 15 Jul 2011 15:59:19 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.0
Message-Id: <1310745559-18529-1-git-send-email-guenter.roeck@ericsson.com>
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

The following changes since commit 620917de59eeb934b9f8cf35cc2d95c1ac8ed0fc:

  Linux 3.0-rc7 (2011-07-11 16:51:52 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Guenter Roeck (2):
      hwmon: (pmbus) Use long variables for register to data conversions
      hwmon: (adm1275) Fix coefficients per datasheet revision B

 drivers/hwmon/adm1275.c    |   10 +++++-----
 drivers/hwmon/pmbus_core.c |   20 ++++++++++----------
 2 files changed, 15 insertions(+), 15 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
