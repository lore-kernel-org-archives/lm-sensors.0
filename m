From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 08 May 2009 18:59:16 +0000
Subject: [lm-sensors] [GIT PULL] hwmon fixes for 2.6.30
Message-Id: <20090508205916.4478b06c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LM Sensors <lm-sensors@lm-sensors.org>, LKML <linux-kernel@vger.kernel.org>

Hi Linus,

Please pull some hwmon subsystem fixes for Linux 2.6.30 from:

git://jdelvare.pck.nerim.net/jdelvare-2.6 hwmon-for-linus

 drivers/hwmon/asus_atk0110.c |    2 ++
 drivers/hwmon/w83781d.c      |    3 ++-
 2 files changed, 4 insertions(+), 1 deletions(-)

---------------

Jean Delvare (1):
      hwmon: (w83781d) Fix W83782D support (NULL pointer dereference)

Luca Tettamanti (1):
      hwmon: (asus_atk0110) Fix compiler warning

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
