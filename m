From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 25 Aug 2011 05:43:06 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.1-rc4
Message-Id: <1314250986-27516-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.1-rc4 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit fcb8ce5cfe30ca9ca5c9a79cdfe26d1993e65e0c:

  Linux 3.1-rc3 (2011-08-22 11:42:53 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Guenter Roeck (1):
      hwmon: (ntc_thermistor) Simplify if sequence

Jean Delvare (1):
      hwmon: (i5k_amb) Drop i5k_channel_pci_id

 drivers/hwmon/i5k_amb.c        |   42 +++++++++++++--------------------------
 drivers/hwmon/ntc_thermistor.c |    3 +-
 2 files changed, 15 insertions(+), 30 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
