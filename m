From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 24 Nov 2014 17:40:59 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.18-rc7
Message-Id: <1416850859-30145-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon fixes for Linux 3.18-rc7 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v3.18-rc7

Thanks,
Guenter
------

The following changes since commit fc14f9c1272f62c3e8d01300f52467c0d9af50f9:

  Linux 3.18-rc5 (2014-11-16 16:36:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v3.18-rc7

for you to fetch changes up to 6b19b66013cfe608d63f0dab38834bbaceb0217a:

  hwmon: (g762) fix call to devm_hwmon_device_register_with_groups() (2014-11-19 14:06:47 -0800)

----------------------------------------------------------------
Fix hwmon registration problem in g762 driver

----------------------------------------------------------------
Arnaud Ebalard (1):
      hwmon: (g762) fix call to devm_hwmon_device_register_with_groups()

 drivers/hwmon/g762.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
