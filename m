From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 03 Oct 2010 13:50:18 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.36-rc7
Message-Id: <1286113818-16205-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.36-rc7 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit c6ea21e35bf3691cad59647c771e6606067f627d:

  Merge git://git.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6 (2010-10-01 15:03:37 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Giel van Schijndel (1):
      hwmon: f71882fg: use a muxed resource lock for the Super I/O port

 drivers/hwmon/f71882fg.c |   32 +++++++++++++++++++-------------
 1 files changed, 19 insertions(+), 13 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
