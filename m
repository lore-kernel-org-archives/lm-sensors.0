From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 02 Apr 2011 01:53:41 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.39
Message-Id: <1301709701-26408-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1301169714-25636-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1301169714-25636-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.39 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit 0ce790e7d736cedc563e1fb4e998babf5a4dbc3d:

  Linux 2.6.39-rc1 (2011-03-29 12:09:47 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Axel Lin (1):
      hwmon: twl4030-madc-hwmon: add "platform:" prefix for platform modalias

 drivers/hwmon/twl4030-madc-hwmon.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
