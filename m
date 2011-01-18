From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 18 Jan 2011 21:41:18 +0000
Subject: [lm-sensors] [GIT PULL] hwmon changes for 2.6.38
Message-Id: <1295388791-21305-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294672246-6818-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1294672246-6818-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem changes for Linux 2.6.38 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit a25cecce88194b2edf38b8c3b1665e9318eb2d22:

  Merge branch 'next' of git://git.monstr.eu/linux-2.6-microblaze (2011-01-18 08:06:22 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Guenter Roeck (1):
      hwmon: (lm93) Add support for LM94

 Documentation/hwmon/lm93 |    7 +++++++
 drivers/hwmon/Kconfig    |    4 ++--
 drivers/hwmon/lm93.c     |   21 +++++++++++++++++++--
 3 files changed, 28 insertions(+), 4 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
