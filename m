From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sun, 02 Jan 2011 23:45:26 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.37
Message-Id: <1294011926-6251-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1288978399-16583-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1288978399-16583-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.37 from:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Thanks,
Guenter Roeck

------

The following changes since commit 9109f4eb847b7c0be61ae25fb21b1ce2acc9c2d6:

  Merge branch 'kvm-updates/2.6.37' of git://git.kernel.org/pub/scm/virt/kvm/kvm (2011-01-02 10:44:21 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Maurus Cuelenaere (1):
      hwmon: (s3c-hwmon) Fix compilation

 drivers/hwmon/s3c-hwmon.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
