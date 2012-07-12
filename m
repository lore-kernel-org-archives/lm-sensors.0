From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Jul 2012 21:21:41 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fix for Linux 3.5
Message-Id: <20120712232141.0cea1a31@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull one hwmon subsystem fix for Linux 3.5 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/it87.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

---------------

Jean Delvare (1):
      hwmon: (it87) Preserve configuration register bits on init

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
