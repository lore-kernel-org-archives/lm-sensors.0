From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 06 Sep 2013 12:49:15 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for Linux 3.12
Message-Id: <20130906144915.304f7c34@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem updates for Linux 3.12 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 Documentation/hwmon/w83791d | 2 +-
 Documentation/hwmon/w83792d | 3 +--
 drivers/hwmon/emc6w201.c    | 2 +-
 drivers/hwmon/w83792d.c     | 4 ++--
 4 files changed, 5 insertions(+), 6 deletions(-)

---------------

Guenter Roeck (1):
      hwmon: (emc6w201) Do not declare enum variable

Shane Huang (1):
      hwmon: (w83792d) Update module author

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
