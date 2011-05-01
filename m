From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 01 May 2011 20:52:40 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.39
Message-Id: <1304283160-22587-1-git-send-email-guenter.roeck@ericsson.com>
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

The following changes since commit 1be6a1f89f131e9c3d22f819ec542be9cda8c9e3:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi-rc-fixes-2.6 (2011-04-29 16:27:52 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Axel Lin (1):
      hwmon: (twl4030-madc-hwmon) Return proper error if hwmon_device_register fails

 drivers/hwmon/twl4030-madc-hwmon.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
