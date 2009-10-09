From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 09 Oct 2009 18:57:22 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.32
Message-Id: <20091009205722.5434b5c2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull some hwmon subsystem fixes for Linux 2.6.32 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus


 MAINTAINERS                  |    2 +-
 drivers/hwmon/Kconfig        |    2 +-
 drivers/hwmon/asus_atk0110.c |  339 +++++++++++++++++++++++++++++++++++-------
 drivers/hwmon/sht15.c        |    7 +-
 4 files changed, 292 insertions(+), 58 deletions(-)

---------------

Jean Delvare (1):
      MAINTAINERS: Fix Riku Voipio's address

Luca Tettamanti (2):
      hwmon: (asus_atk0110) Refactor the code
      hwmon: (asus_atk0110) Enable the EC

Mark Brown (1):
      hwmon: (s3c-hwmon) Disable build for S3C64xx

Rakib Mullick (1):
      hwmon: (sht15) Fix spurious section mismatch warning

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
