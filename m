From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 12 Nov 2014 19:43:26 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.18-rc5
Message-Id: <1415821406-18384-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon fixes for Linux 3.18-rc5 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v3.18-rc5

Thanks,
Guenter
------

The following changes since commit 206c5f60a3d902bc4b56dab2de3e88de5eb06108:

  Linux 3.18-rc4 (2014-11-09 14:55:29 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v3.18-rc5

for you to fetch changes up to 0bd52941586b3b59ab9b6e89e55b2dc9e2680de9:

  hwmon: (fam15h_power) Fix NB device ID for F16h M30h (2014-11-11 10:39:45 -0800)

----------------------------------------------------------------
Fix PCI device ID in fam15h_power driver
Fix suspend/resume behavior in pwm-fan driver
Reduce logging noise created by ibmpowernv driver

----------------------------------------------------------------
Aravind Gopalakrishnan (1):
      hwmon: (fam15h_power) Fix NB device ID for F16h M30h

Kamil Debski (1):
      hwmon: (pwm-fan) Fix suspend/resume behavior

Michael Ellerman (1):
      hwmon: (ibmpowernv) Quieten when probing finds no device

 drivers/hwmon/fam15h_power.c |  2 +-
 drivers/hwmon/ibmpowernv.c   |  6 ++++--
 drivers/hwmon/pwm-fan.c      | 13 ++++++++++---
 3 files changed, 15 insertions(+), 6 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
