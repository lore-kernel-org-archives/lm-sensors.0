From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 11 Feb 2011 06:10:33 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.38
Message-Id: <1297404633-19309-1-git-send-email-guenter.roeck@ericsson.com>
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

The following changes since commit 100b33c8bd8a3235fd0b7948338d6cbb3db3c63d:

  Linux 2.6.38-rc4 (2011-02-07 16:03:55 -0800)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Dirk Eibach (1):
      hwmon: (lm63) Consider LM64 temperature offset

Guenter Roeck (1):
      hwmon: (emc1403) Fix I2C address range

 drivers/hwmon/emc1403.c |    2 +-
 drivers/hwmon/lm63.c    |   59 +++++++++++++++++++++++++++++++++++++---------
 2 files changed, 48 insertions(+), 13 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
