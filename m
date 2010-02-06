From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 06 Feb 2010 15:05:17 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.33
Message-Id: <20100206160517.4cca2e89@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100110230412.321d6c43@hyperion.delvare>
In-Reply-To: <20100110230412.321d6c43@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.33 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/adt7462.c |    2 +-
 drivers/hwmon/lm78.c    |   25 ++++++++++++-------------
 drivers/hwmon/w83781d.c |   26 +++++++++++++-------------
 3 files changed, 26 insertions(+), 27 deletions(-)

---------------

Jean Delvare (2):
      hwmon: (lm78) Request I/O ports individually for probing
      hwmon: (w83781d) Request I/O ports individually for probing

Ray Copeland (1):
      hwmon: (adt7462) Wrong ADT7462_VOLT_COUNT

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
