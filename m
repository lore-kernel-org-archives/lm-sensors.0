From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 08 Jul 2013 12:28:33 +0000
Subject: [lm-sensors] [GIT PULL] hwmon updates for Linux 3.11
Message-Id: <20130708142833.52c21536@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem updates for Linux 3.11 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/lm63.c | 5 ++---
 drivers/hwmon/lm90.c | 4 ++--
 2 files changed, 4 insertions(+), 5 deletions(-)

---------------

Jean Delvare (2):
      hwmon: (lm90) Drop redundant safety on cache lifetime
      hwmon: (lm63) Drop redundant safety on cache lifetime

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
