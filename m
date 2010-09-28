From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 28 Sep 2010 11:34:43 +0000
Subject: [lm-sensors] [GIT PULL] urgent hwmon fixes for 2.6.36
Message-Id: <1285673683-28202-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.36 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

Guenter Roeck (1):
      hwmon (coretemp): Fix build breakage if SMP is undefined

 drivers/hwmon/coretemp.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
