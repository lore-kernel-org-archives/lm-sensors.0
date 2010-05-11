From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 May 2010 19:20:47 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.34
Message-Id: <20100511212047.2fb78fda@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.34 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/applesmc.c |   61 ++++++++++++++++++--------------------------
 drivers/hwmon/asc7621.c  |   63 ++++++++++++++++++++++-----------------------
 2 files changed, 56 insertions(+), 68 deletions(-)

---------------

Henrik Rydberg (1):
      hwmon: (applesmc) Correct sysfs fan error handling

Ken Milmore (1):
      hwmon: (asc7621) Bug fixes

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
