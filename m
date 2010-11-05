From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 05 Nov 2010 17:33:19 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.37
Message-Id: <1288978399-16583-1-git-send-email-guenter.roeck@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
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

The following changes since commit ff8b16d7e15a8ba2a6086645614a483e048e3fbf:

  vmstat: fix offset calculation on void* (2010-11-03 14:39:58 -0400)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/staging.git hwmon-for-linus

Guenter Roeck (1):
      hwmon: (ltc4261) Add missing newline in debug message

Jean Delvare (1):
      hwmon: (ltc4261) Fix error message format

 drivers/hwmon/ltc4261.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
