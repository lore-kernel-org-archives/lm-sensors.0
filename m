From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 02 Jul 2011 21:52:32 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.0
Message-Id: <1309643552-17775-1-git-send-email-guenter.roeck@ericsson.com>
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

The following changes since commit daf54f1f363a61c618662ef66d4bf09d2b090941:

  drm/radeon/kms: Fix chremap setup on RV770 CE (2011-07-01 07:29:46 +1000)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Guenter Roeck (4):
      hwmon: (pmbus) Drop check for PMBus revision register in probe function
      hwmon: (adm1275) Free allocated memory if probe function fails
      hwmon: (pmbus) Improve fan detection
      hwmon: (pmbus) Auto-detect temp2 and temp3 registers/attributes

 drivers/hwmon/adm1275.c    |   16 +++++++++++++---
 drivers/hwmon/pmbus.c      |   10 ++++++++--
 drivers/hwmon/pmbus_core.c |   11 +++--------
 3 files changed, 24 insertions(+), 13 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
