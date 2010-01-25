From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Jan 2010 14:13:47 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.33
Message-Id: <20100125151347.492690e4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100110230412.321d6c43@hyperion.delvare>
In-Reply-To: <20100110230412.321d6c43@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.33 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/amc6821.c      |    1 -
 drivers/hwmon/asus_atk0110.c |   19 +++++++++----------
 drivers/hwmon/fschmd.c       |    7 +++++--
 drivers/hwmon/smsc47m1.c     |    2 +-
 4 files changed, 15 insertions(+), 14 deletions(-)

---------------

Dan Carpenter (1):
      hwmon: (amc6821) Double unlock bug

Hans de Goede (1):
      hwmon: (fschmd) Fix a memleak on multiple opens of /dev/watchdog

Jeff Mahoney (1):
      hwmon: (smsc47m1) Fix section mismatch

Luca Tettamanti (1):
      hwmon: (asus_atk0110) Do not fail if MBIF is missing

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
