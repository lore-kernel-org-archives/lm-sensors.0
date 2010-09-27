From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 27 Sep 2010 00:11:57 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.36 - take two
Message-Id: <1285546317-18970-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1285531139-16646-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1285531139-16646-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.36 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

This is a single commit which fixes the built breakage introduced with the
series I sent out yesterday. For your convenience, I also copied you on the 
patch itself.

Thanks,
Guenter Roeck

------

Guenter Roeck (1):
      hwmon (coretemp): Fix build breakage if SMP is undefined

 drivers/hwmon/coretemp.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
