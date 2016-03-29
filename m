From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 29 Mar 2016 14:53:09 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for v4.6-rc2
Message-Id: <1459263189-14680-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon fixes for Linux v4.6-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.6-rc2

Thanks,
Guenter
------

The following changes since commit f55532a0c0b8bb6148f4e07853b876ef73bc69ca:

  Linux 4.6-rc1 (2016-03-26 16:03:24 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.6-rc2

for you to fetch changes up to 3c2e2266a5bd2d1cef258e6e54dca1d99946379f:

  hwmon: (max1111) Return -ENODEV from max1111_read_channel if not instantiated (2016-03-27 10:37:48 -0700)

----------------------------------------------------------------
Fix crash due to NULL pointer access in max1111 driver

----------------------------------------------------------------
Guenter Roeck (1):
      hwmon: (max1111) Return -ENODEV from max1111_read_channel if not instantiated

 drivers/hwmon/max1111.c | 6 ++++++
 1 file changed, 6 insertions(+)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
