From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 29 Jan 2016 17:15:39 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for v4.5-rc2
Message-Id: <1454087739-23594-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: torvalds@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Linus,

Please pull hwmon fixes for Linux v4.5-rc2 from signed tag:

    git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-for-linus-v4.5-rc2

Thanks,
Guenter
------

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git tags/hwmon-for-linus-v4.5-rc2

for you to fetch changes up to 60dee3ca27b3613e6519df52d02eadf71f853859:

  hwmon: (fam15h_power) Add bit masking for tdp_limit (2016-01-27 18:48:46 -0800)

----------------------------------------------------------------
hwmon fixes for v4.5-rc2

- Use bit mask to calculate tdp limit in fam15h_power driver
- Black-list Dell Studio XPS 8000 in dell-smm driver

----------------------------------------------------------------
Gioh Kim (1):
      hwmon: (fam15h_power) Add bit masking for tdp_limit

Thorsten Leemhuis (1):
      hwmon: (dell-smm) Blacklist Dell Studio XPS 8000

 drivers/hwmon/dell-smm-hwmon.c | 11 +++++++++++
 drivers/hwmon/fam15h_power.c   | 10 +++++++++-
 2 files changed, 20 insertions(+), 1 deletion(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
