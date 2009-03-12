From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Mar 2009 12:38:58 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.29
Message-Id: <20090312133858.14c1be87@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

Hi Linus,

Please pull some hwmon subsystem fixes for Linux 2.6.29 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 hwmon-for-linus

 Documentation/hwmon/lm90   |   10 ++++++++++
 drivers/hwmon/Kconfig      |    4 ++--
 drivers/hwmon/abituguru3.c |    7 +++++--
 drivers/hwmon/f75375s.c    |    2 +-
 drivers/hwmon/it87.c       |    8 ++++----
 drivers/hwmon/lm90.c       |    8 ++++----
 6 files changed, 26 insertions(+), 13 deletions(-)

---------------

Andrew Klossner (1):
      hwmon: (f75375s) Remove unnecessary and confusing initialization

Darrick J. Wong (1):
      hwmon: (lm90) Document support for the MAX6648/6692 chips

Jean Delvare (2):
      hwmon: (abituguru3) Fix I/O error handling
      hwmon: (it87) Properly decode -128 degrees C temperature

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
