From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 17 Jul 2011 21:11:06 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.0
Message-Id: <20110717231106.7fac2569@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110606170230.2bda2a14@endymion.delvare>
In-Reply-To: <20110606170230.2bda2a14@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.0 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/asus_atk0110.c |    1 +
 drivers/hwmon/it87.c         |    2 +-
 drivers/hwmon/max1111.c      |   11 +++++++++++
 3 files changed, 13 insertions(+), 1 deletions(-)

---------------

Jean Delvare (1):
      hwmon: (it87) Fix label group removal

Luca Tettamanti (1):
      hwmon: (asus_atk0110) Fix memory leak

Pavel Herrmann (1):
      hwmon: (max1111) Fix race condition causing NULL pointer exception

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
