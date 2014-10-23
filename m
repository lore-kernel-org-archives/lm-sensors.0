From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 23 Oct 2014 00:10:36 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.18-rc2
Message-Id: <1414023036-17120-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon fixes for Linux 3.18-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v3.18-rc2

Thanks,
Guenter
------

The following changes since commit f114040e3ea6e07372334ade75d1ee0775c355e1:

  Linux 3.18-rc1 (2014-10-19 18:08:38 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v3.18-rc2

for you to fetch changes up to 3d5960472de0a245c56ba55e9a59b8d0f4c69cb4:

  hwmon: (menf21bmc) Include linux/err.h (2014-10-19 18:41:18 -0700)

----------------------------------------------------------------
Fix potential compile problem for menf21bmc hwmon driver

----------------------------------------------------------------
Johannes Thumshirn (1):
      hwmon: (menf21bmc) Include linux/err.h

 drivers/hwmon/menf21bmc_hwmon.c | 1 +
 1 file changed, 1 insertion(+)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
