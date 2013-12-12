From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Dec 2013 07:10:02 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for Linux 3.13
Message-Id: <20131212081002.282498d9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.13 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 drivers/hwmon/lm78.c      |  2 ++
 drivers/hwmon/lm90.c      |  4 +++-
 drivers/hwmon/sis5595.c   |  2 ++
 drivers/hwmon/vt8231.c    |  2 +-
 drivers/hwmon/w83l786ng.c | 13 ++++++++-----
 5 files changed, 16 insertions(+), 7 deletions(-)

---------------

Brian Carnes (1):
      hwmon: (w83l786ng) Fix fan speed control mode setting and reporting

Dan Carpenter (1):
      hwmon: Prevent some divide by zeros in FAN_TO_REG()

Guenter Roeck (1):
      hwmon: (lm90) Unregister hwmon device if interrupt setup fails

Jean Delvare (1):
      hwmon: (w83l768ng) Fix fan speed control range

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
