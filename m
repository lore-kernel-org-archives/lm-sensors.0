From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 01 Jun 2009 14:37:59 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.30
Message-Id: <20090601163759.0d125486@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090508205916.4478b06c@hyperion.delvare>
In-Reply-To: <20090508205916.4478b06c@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull some hwmon subsystem fixes for Linux 2.6.30 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 Documentation/hwmon/sysfs-interface |    6 ++++++
 drivers/hwmon/lm78.c                |    2 +-
 2 files changed, 7 insertions(+), 1 deletions(-)

---------------

Christian Engelmayer (1):
      hwmon: Update documentation on fan_max

Mike Frysinger (1):
      hwmon: (lm78) Add missing __devexit_p()

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
