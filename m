From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 29 Mar 2010 20:15:25 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.34
Message-Id: <20100329221525.1706d287@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull hwmon subsystem fixes for Linux 2.6.34 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/Kconfig    |    4 ++--
 drivers/hwmon/coretemp.c |    4 ++--
 drivers/hwmon/w83793.c   |    2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

---------------

Dan Carpenter (1):
      hwmon: (w83793) Saving negative errors in unsigned

Dean Nelson (1):
      hwmon: (coretemp) Add missing newline to dev_warn() message

Jaswinder Singh Rajput (1):
      hwmon: (asc7621) Add X58 entry in Kconfig

Prarit Bhargava (1):
      hwmon: (coretemp) Fix cpu model output

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
