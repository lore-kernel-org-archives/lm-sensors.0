From: Guenter Roeck <linux@roeck-us.net>
Date: Thu, 04 Sep 2014 15:12:41 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.17-rc4
Message-Id: <1409843561-9245-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon fixes for Linux 3.17-rc4 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus

Thanks,
Guenter
------

The following changes since commit 52addcf9d6669fa439387610bc65c92fa0980cef:

  Linux 3.17-rc2 (2014-08-25 15:36:20 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus

for you to fetch changes up to 39c627a084475e8a690a4a9e7601410ca173ddd2:

  hwmon: (ds1621) Update zbits after conversion rate change (2014-08-28 11:18:47 -0700)

----------------------------------------------------------------
Fix a bug in the ds1621 driver

----------------------------------------------------------------
Robert Coulson (1):
      hwmon: (ds1621) Update zbits after conversion rate change

 drivers/hwmon/ds1621.c | 1 +
 1 file changed, 1 insertion(+)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
