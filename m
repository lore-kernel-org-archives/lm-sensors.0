From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Mar 2013 20:38:42 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for Linux 3.9
Message-Id: <20130318213842.77c4da26@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Linus,

Please pull hwmon subsystem fixes for Linux 3.9 from:

git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging.git hwmon-for-linus

 CREDITS                  |    8 ++++++++
 Documentation/hwmon/lm75 |    2 +-
 MAINTAINERS              |   17 ++---------------
 drivers/hwmon/lm75.h     |    2 +-
 4 files changed, 12 insertions(+), 17 deletions(-)

---------------

Jean Delvare (3):
      MAINTAINERS: Remove Mark M. Hoffman
      hwmon: (lm75.h) Update header inclusion
      hwmon: (lm75) Fix tcn75 prefix

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
