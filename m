From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 26 Mar 2011 10:05:18 +0000
Subject: [lm-sensors] [GIT PULL] More hwmon updates for 2.6.39
Message-Id: <20110326110518.5c631e12@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull more hwmon subsystem updates for Linux 2.6.39 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

We have support for two new devices: Fintek F71889A and F81865F.

 Documentation/hwmon/f71882fg |   19 ++++++
 drivers/hwmon/Kconfig        |   17 +++++-
 drivers/hwmon/f71882fg.c     |  126 ++++++++++++++++++++++++++++--------------
 3 files changed, 117 insertions(+), 45 deletions(-)

---------------

Hans de Goede (1):
      hwmon: (f71882fg) Add support for the F71889A

Jean Delvare (4):
      hwmon: (f71882fg) Secure chip property definition arrays
      hwmon: (f71882fg) Per-chip fan/temperature input count tables
      hwmon: (f71882fg) Document all supported devices
      hwmon: (f71882fg) Add support for the F81865F

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
