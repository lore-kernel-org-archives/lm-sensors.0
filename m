From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 03 Jul 2011 12:02:13 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 3.0
Message-Id: <20110703140213.71def431@endymion.delvare>
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

 Documentation/hwmon/f71882fg |    4 +++
 Documentation/hwmon/k10temp  |    8 ++++-
 drivers/hwmon/Kconfig        |    2 +-
 drivers/hwmon/emc6w201.c     |   58 +++++++++++++++++++++++++++++++----------
 drivers/hwmon/f71882fg.c     |   19 +++++++++++--
 drivers/hwmon/hwmon-vid.c    |    2 +-
 drivers/hwmon/sch5627.c      |    2 +-
 7 files changed, 73 insertions(+), 22 deletions(-)

---------------

Clemens Ladisch (1):
      hwmon: (k10temp) Update documentation for Fam12h

Hans de Goede (2):
      hwmon: Use <> rather than () around my e-mail address
      hwmon: (f71882fg) Add support for the F71869A

Jean Delvare (2):
      hwmon: (emc6w201) Properly handle all errors
      hwmon-vid: Fix typo in VIA CPU name

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
